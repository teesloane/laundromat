//point position
float px = 0;
float py = 0;

// circle center position
float cx = 300;
float cy = 200;
float radius = 100;

void setup(){
  size (600, 400);
  noCursor(); 
  
  strokeWeight(5);
}

void draw() {
  background(205);
  
  px = mouseX;
  py = mouseY;
  
  boolean hit = pointCircle(px, py, cx, cy, radius);
  
  // create circle + fill
  
  if (hit) {
    fill(255, 250, 9);
  } else {
    fill(30, 102, 3);
  }
  
  noStroke();    
  ellipse(cx, cy, radius*2, radius*2);
   
   // draw the piont
   stroke(0);
   point(px, py);
}


// point circle function

boolean pointCircle(float px, float py, float cx, float cy, float r) {
  // get the distance between point and circle's center with PyTheo
  float distX = px - cx;
  float distY = py - cy;
  float distance = sqrt( (distX*distX) + (distY*distY));
  
  if (distance <= r) {
    return true;
  }
  return false;
}

  