float c2x = 200;
float c2y = 200;

float cx = 0;
float cy = 0;
float r = 10;

// gravity 
float gravity = 0.03;
float friction = -0.8;

int numBalls = 2;
Ball[] balls = new Ball[numBalls];

PVector[] vertices = new PVector[6];

void setup(){
  size(600, 400);
  noStroke();
  
  // create the container 
  vertices[0] = new PVector(100,100);
  vertices[1] = new PVector(300,100);
  vertices[2] = new PVector(400,200);
  vertices[3] = new PVector(300,300);
  vertices[4] = new PVector(100,200);
  vertices[5] = new PVector(100,100);
  
  // create the balls
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(c2x-25, c2x+25), random(100, 200), random(20, 40), i, balls);
  }
  
}

void draw(){
  background(255);
  
  //cx = mouseX;
  //cy = mouseY;
  
  // collision detection.
  boolean hit = polyCircle(vertices, cx, cy, r);
  if (hit) fill (255, 22, 24);
  else fill(13);
  
  // create the polygon (TBR)
  
  noStroke();
  beginShape();
  for (PVector v : vertices) {
    vertex(v.x, v.y);
  }
  endShape();
  
  // draw circle
  //fill(32, 123, 35);
  //ellipse(cx, cy, r*2, r*2);
  
  for (Ball ball : balls)  {
    
    ball.display();
    ball.moveBalls();
    if (ball.hit) {
      ball.changeColour();
    }
  }
}


/* =================== PolyGon / Circle =================== */ 

boolean polyCircle(PVector[] vertices, float cx, float cy, float r) {
  
  /* 
  * go through vertices, and next vertix in the list. 
  * loop through vertices, if last, wrap to first.
  */
  
  int next = 0;
  for (int current = 0; current < vertices.length; current++) {
    next = current + 1;
    if (next == vertices.length) next = 0;
    
    // get pvectors at current position.
    PVector vc = vertices[current]; // current vertex
    PVector vn = vertices[next]; // next vertex.
    
    
    // checks collision with outer lines.
    boolean collision = lineCircle(vc.x, vc.y, vn.x, vn.y, cx, cy, r);
    if (collision) {
       return true;
    }
  }
    
    boolean internalCollision = polygonPoint(vertices, cx, cy);
    if (internalCollision) {
      return true;
    }
    
    return false;
  
  
}

/* =========== Line / Circle ========= */

boolean lineCircle(float x1, float y1, float x2, float y2, float cx, float cy, float r) {

  // get length of the line
  float distX = x1 - x2;
  float distY = y1 - y2;
  float len = sqrt( (distX*distX) + (distY*distY) );
  
  // get dot product of the line and circle (???)
  float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len, 2);
  
  // find closest point on the line
  float closestX = x1 + (dot * (x2 - x1));
  float closestY = y1 + (dot * (y2 - y1));
  
  // is point on line seg? if so, go, if not false
  boolean onSegment = linePoint(x1,y1, x2, y2, closestX, closestY);
  if(!onSegment) return false;
  
  // optional display a circle at the closest point on the line.
  
  // get distance to closest point 
  distX = closestX - cx;
  distY = closestY - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // is the circle on the line
  
  if (distance <= r) {
    return true;
  }
  
  return false; 

}

/* =========== line / point ========= */

boolean linePoint(float x1, float y1, float x2, float y2, float px, float py){
  //distance from the piont to the end of the line:
  float d1 = dist(px, py, x1, y1);
  float d2 = dist(px, py, x2, y2);
  
  // length of line
  float lineLen = dist(x1, y1, x2, y2);
  
  // buffer
  float buffer = 0.1;
  
  // if two dists are == to line len, the point is on the line
  if (d1+d2 >= lineLen - buffer && d1 + d2 <= lineLen+buffer){
    return true;    
  }
  
  return false;


}

/* =========== Polygon / Point ========= */
// needed to check if circle is inside polygon

boolean polygonPoint (PVector[] vertices, float px, float py){
  boolean collision = false;
  
  int next = 0;
  for (int current = 0; current < vertices.length; current++) {
    next = current+1;
    if (next == vertices.length) next = 0;
    
    PVector vc = vertices[current];
    PVector vn = vertices[next];
    
    //compare position, flip 'collision' var.
    
    if (((vc.y > py && vn.y < py) || (vc.y < py && vn.y > py))  &&
      (px < (vn.x-vc.x)*(py-vc.y) / (vn.y - vc.y) - vc.x)) {
        collision = !collision;
      }
  }
  return collision;

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

 
  
  boolean hit = polyCircle(vertices, cx, cy, r);
 
   
  void changeColour() {
    fill(220, 100, 200);
  }
  
  void moveBalls() {
    vy += gravity;
    x += vx;
    y += vy;
  }

  void display() {
    ellipse(x, y, diameter, diameter);
    fill(93, 32, 30);
  }
}