import themidibus.*;

MidiBus myBus;

/* Vars and Setup */

//circle 1
//float c1x = 200;
//float c1y = 200;
//float c1r = 10;

//circle 2
float c2x = 200;
float c2y = 200;
float c2r = 100;

//gravity
//
// float yPos = 200;
// float xPos = 200;
// float G = .10;
// float acceleration = 0;

// Other
int numBalls = 1;
float spring = 0.05;
float gravity = 0.03;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];


void setup() {
  size (500, 500);
  noStroke();

  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(200, 100, random(30, 70), i, balls);
  }


  MidiBus.list();
  myBus = new MidiBus(this, -1, "Chill Bus");
}

void draw() {
  background(230);

  // c1x = mouseX;
  // c1y = mouseY;
  //
  // yPos += acceleration;
  // acceleration += G;

  // boolean hit = collision(c1x, c1y, c1r, c2x, c2y, c2r);

  //if (hit) {
  //  sendNote(0, 60, 100);
  //  acceleration =- acceleration/1.10 ;
  //}

  // washing machine
  ellipseMode(CENTER);
  fill(100, 100, 100, 50);
  ellipse (c2x, c2y, c2r*2, c2r*2);

  for (Ball ball : balls) {
    ball.collideContainer();
    ball.collideOthers();
    ball.move();
    ball.display();
    
  }

  // bouncing ball.

  // ellipseMode(CENTER);
  // fill (0, 140, 32);
  // ellipse(xPos, yPos, c1r*2, c1r*2);
}


/* ====== Functions ====== */

void sendNote(int channel, int pitch, int velocity) {
  myBus.sendNoteOn(channel, pitch, velocity);
}

//boolean collision(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {

//  float distX = xPos - c2x;
//  float distY = yPos - c2y;
//  float distance = sqrt( (distX*distX) + (distY*distY));

//  if (distance >= c2r - c1r) {
//    return true;
//  }

//  return false;
//}


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

    boolean collideContainer(){
        // ?
        vy += gravity;
        x += vx;
        y += vy;

        float distX = x - c2x;
        float distY = y - c2y;
        float distance = sqrt( (distX*distX) + (distY*distY));

        if (distance >= c2r - diameter) {
            changeColour();
        }
        
        return false;

        // if (x + diameter/2 > width) {
        //   x = width - diameter/2;
        //   vx *= friction;
        // }
        // else if (x - diameter/2 < 0) {
        //   x = diameter/2;
        //   vx *= friction;
        // }
        // if (y + diameter/2 > height) {
        //   y = height - diameter/2;
        //   vy *= friction;
        // }
        // else if (y - diameter/2 < 0) {
        //   y = diameter/2;
        //   vy *= friction;
        // }


    }


    //boolean collision(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {

    //  float distX = xPos - c2x;
    //  float distY = yPos - c2y;
    //  float distance = sqrt( (distX*distX) + (distY*distY));

    //  if (distance >= c2r - c1r) {
    //    return true;
    //  }

    //  return false;
    //}

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

    void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction;
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction;
    }
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
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