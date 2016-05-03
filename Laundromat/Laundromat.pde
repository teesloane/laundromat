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

import themidibus.*;

MidiBus myBus;

/* Vars and Setup */

//Container Circle vars
float c2x = 200;
float c2y = 200;
float c2r = 100;
float buffer = 5;

// Other
int numBalls = 5;
float spring = 0.05;
float gravity = 0.03;
float friction = -0.8;
Ball[] balls = new Ball[numBalls];

PShape wM;


void setup() {
  // instantiate midi =======================
  MidiBus.list();
  myBus = new MidiBus(this, -1, "Chill Bus");
  size (500, 500);

  // create the container =======================
  wM = createShape(ELLIPSE, c2x, c2y, c2r*2, c2r*2);
  wM.fill(200, 200, 200, 50);
  wM.strokeWeight(50);


  // create the balls  =======================
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(c2x-25, c2x+25), random(150, 250), random(10, 30), i, balls);
  }

}

void draw() {
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

void sendNote(int channel, int pitch, int velocity) {
  println("note sent");
  myBus.sendNoteOn(channel, pitch, velocity);
  delay(1); // may be unecessary
  myBus.sendNoteOff(channel, pitch, velocity);
}

void delay (int time) {
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

  void collideContainer() {
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

  void collideOthers() {
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

  void changeColour() {
    fill(220, 100, 200);
  }

  void display() {
    ellipse(x, y, diameter, diameter);
    fill(93, 32, 30);
  }
}
