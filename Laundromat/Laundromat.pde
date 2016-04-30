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

// Other
int numBalls = 1;  
float spring = 0.05;
float gravity = 0.01;
float friction = -0.9;
Ball[] balls = new Ball[numBalls];


void setup() {
  size (500, 500);
  noStroke();

  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(150, 230), random(150, 250), random(10, 30), i, balls);
  }


  MidiBus.list();
  myBus = new MidiBus(this, -1, "Chill Bus");
}

void draw() {
  background(230);

  // washing machine
  ellipseMode(CENTER);
  fill(100, 100, 100, 50);
  ellipse (c2x, c2y, c2r*2, c2r*2);

  for (Ball ball : balls) {
    
    //ball.collideOthers(); // balls colliding with each other causes things to freak out and explode.
    //ball.move(); // <-- should eventually be replaced by collideContainer();
    
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

    void collideContainer(){

        vy += gravity;
        x += vx;
        y += vy;

        float distX = x - c2x;
        float distY = y - c2y;
        float distance = sqrt( (distX*distX) + (distY*distY));

        if (distance > c2r - (diameter/2)) {   
            changeColour();
            sendNote(0, 60, 127);
            
            
            
            float angle = atan2(distX, distY);
            println(cos(angle));
            
            float cos = cos(angle);
            float sin = sin(angle);
            
            vx += cos(angle) * x - sin(angle) * y;
            
            //float targetX = x + sin(angle);
            //float targetY = y + cos(angle);
            
            //float ax = (targetX - c2x);
            //float ay = (targetY - c2y);
            
            //vx -= ax;
            //vy -= ay;

            
            
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