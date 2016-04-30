import themidibus.*;

MidiBus myBus;

/* Vars and Setup */

//circle 1

//circle 2
float c2x = 200;
float c2y = 200;
float c2r = 100;

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


}


/* ====== Functions ====== */

void sendNote(int channel, int pitch, int velocity) {
  myBus.sendNoteOn(channel, pitch, velocity);
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

        //vy += gravity;
        //x += vx;
        //y += vy;

        float distX = x - c2x;
        float distY = y - c2y;
        float distance = sqrt( (distX*distX) + (distY*distY));

        if (distance > c2r - (diameter/2)) {
          
          /*gist: 
            if (hit) {
              sendNote(0, 60, 100);
              acceleration =- acceleration/1.10 ;
            }
           */
            
            changeColour();
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