import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import themidibus.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Laundromat extends PApplet {

/* TO DO
 *  Billiard physics
 *  Prevent balls from getting stuck when the distance b/w ball and container is much smaller
 *  Stop balls from being able to escape the container (unless by choice...
 */

/* EVENTUALLY
 * create a max velocity
 * Midi input for note choice.
 * Midi mapping knobs?
 * Toggle-able ball collisions. (fix (slow down) ball collisions)
 * Slider controls for gravity, friction, etc.
 */



MidiBus myBus;

/* Vars and Setup */

//Container Circle vars
float c2x = 200;
float c2y = 200;
float c2r = 100;
float buffer = 5;

// Other
int numBalls = 5;
float spring = 0.05f;
float gravity = 0.03f;
float friction = -0.8f;
Ball[] balls = new Ball[numBalls];

PShape wM;


public void setup() {
  // instantiate midi =======================
  MidiBus.list();
  myBus = new MidiBus(this, -1, "Chill Bus");
  

  // create the container =======================
  wM = createShape(ELLIPSE, c2x, c2y, c2r*2, c2r*2);
  wM.fill(200, 200, 200, 50);
  wM.strokeWeight(50);


  // create the balls  =======================
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(c2x-25, c2x+25), random(150, 250), random(10, 30), i, balls);
  }

}

public void draw() {
  background(230);

  // washing machine
  shape(wM);

  for (Ball ball : balls) {
    ball.collideOthers(); // balls colliding with each other causes things to freak out and explode.
    ball.collideContainer();
    ball.display();
  }
}


/* ====== Functions ====== */

public void sendNote(int channel, int pitch, int velocity) {
  println("note sent");
  myBus.sendNoteOn(channel, pitch, velocity);
  delay(1); // may be unecessary
  myBus.sendNoteOff(channel, pitch, velocity);
}

public void delay (int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

/* ======= Ball Class ====== */

class Ball {
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;

  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  }

  public void collideContainer() {
    // problems.
    vy += gravity;
    x += vx;
    y += vy;

    float distX = x - c2x;
    float distY = y - c2y;
    float distance = sqrt( (distX*distX) + (distY*distY));

    println(y);

    if (distance > c2r - (diameter/2 + buffer)) {
      changeColour();
      sendNote(0, 60, 127);

      float angle = atan2(distX, distY);
      println(angle);
      if (angle >= 0) {
        vx -= cos(angle);
      } else {
        vx += cos(angle);
      }

      vy *= friction; // should be moved into it's own function eventually
    }
  }

  public void collideOthers() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) {
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }
  }

  public void changeColour() {
    fill(220, 100, 200);
  }

  public void display() {
    ellipse(x, y, diameter, diameter);
    fill(93, 32, 30);
  }
}
float cx = 0;    // position of the circle
float cy = 0;
float r =  30;   // circle's radius

// array of PVectors, one for each vertex in the polygon
PVector[] vertices = new PVector[4];


public void setup() {
  size(600,400);
  noStroke();

  // set position of the vertices (here a trapezoid)
  vertices[0] = new PVector(200,100);
  vertices[1] = new PVector(400,100);
  vertices[2] = new PVector(350,300);
  vertices[3] = new PVector(250,300);
}


public void draw() {
  background(255);

  // update circle to mouse coordinates
  cx = mouseX;
  cy = mouseY;

  // check for collision
  // if hit, change fill color
  boolean hit = polyCircle(vertices, cx,cy,r);
  if (hit) fill(255,150,0);
  else fill(0,150,255);

  // draw the polygon using beginShape()
  noStroke();
  beginShape();
  for (PVector v : vertices) {
    vertex(v.x, v.y);
  }
  endShape();

  // draw the circle
  fill(0, 150);
  ellipse(cx,cy, r*2,r*2);
}


// POLYGON/CIRCLE
public boolean polyCircle(PVector[] vertices, float cx, float cy, float r) {

  // go through each of the vertices, plus
  // the next vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list
    // if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position
    // this makes our if statement a little cleaner
    PVector vc = vertices[current];    // c for "current"
    PVector vn = vertices[next];       // n for "next"

    // check for collision between the circle and
    // a line formed between the two vertices
    boolean collision = lineCircle(vc.x,vc.y, vn.x,vn.y, cx,cy,r);
    if (collision) return true;
  }

  // the above algorithm only checks if the circle
  // is touching the edges of the polygon \u2013 in most
  // cases this is enough, but you can un-comment the
  // following code to also test if the center of the
  // circle is inside the polygon

  // boolean centerInside = polygonPoint(vertices, cx,cy);
  // if (centerInside) return true;

  // otherwise, after all that, return false
  return false;
}


// LINE/CIRCLE
public boolean lineCircle(float x1, float y1, float x2, float y2, float cx, float cy, float r) {

  // get length of the line
  float distX = x1 - x2;
  float distY = y1 - y2;
  float len = sqrt( (distX*distX) + (distY*distY) );

  // get dot product of the line and circle
  float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len,2);

  // find the closest point on the line
  float closestX = x1 + (dot * (x2-x1));
  float closestY = y1 + (dot * (y2-y1));

  // is this point actually on the line segment?
  // if so keep going, but if not, return false
  boolean onSegment = linePoint(x1,y1,x2,y2, closestX,closestY);
  if (!onSegment) return false;

  // optionally, draw a circle at the closest point
  // on the line
  fill(255,0,0);
  noStroke();
  ellipse(closestX, closestY, 20, 20);

  // get distance to closest point
  distX = closestX - cx;
  distY = closestY - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // is the circle on the line?
  if (distance <= r) {
    return true;
  }
  return false;
}


// LINE/POINT
public boolean linePoint(float x1, float y1, float x2, float y2, float px, float py) {

  // get distance from the point to the two ends of the line
  float d1 = dist(px,py, x1,y1);
  float d2 = dist(px,py, x2,y2);

  // get the length of the line
  float lineLen = dist(x1,y1, x2,y2);

  // since floats are so minutely accurate, add
  // a little buffer zone that will give collision
  float buffer = 0.1f;    // higher # = less accurate

  // if the two distances are equal to the line's
  // length, the point is on the line!
  // note we use the buffer here to give a range, rather
  // than one #
  if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
    return true;
  }
  return false;
}


// POLYGON/POINT
// only needed if you're going to check if the circle
// is INSIDE the polygon
public boolean polygonPoint(PVector[] vertices, float px, float py) {
  boolean collision = false;

  // go through each of the vertices, plus the next
  // vertex in the list
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list
    // if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position
    // this makes our if statement a little cleaner
    PVector vc = vertices[current];    // c for "current"
    PVector vn = vertices[next];       // n for "next"

    // compare position, flip 'collision' variable
    // back and forth
    if (((vc.y > py && vn.y < py) || (vc.y < py && vn.y > py)) &&
         (px < (vn.x-vc.x)*(py-vc.y) / (vn.y-vc.y)+vc.x)) {
            collision = !collision;
    }
  }
  return collision;
}
  public void settings() {  size (500, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Laundromat" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
