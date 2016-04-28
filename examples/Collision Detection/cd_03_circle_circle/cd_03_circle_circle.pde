float c1x = 0;
float c1y = 0;
float c1r = 30;

float c2x = 200;
float c2y = 302;
float c2r = 100;

void setup() {
  size(700,403);
  noStroke();
}

void draw(){
  background(203);
  
  c1x = mouseX;
  c1y = mouseY;
  
  //check collision
  
  boolean hit = circleOnCircle(c1x, c1y, c1r, c2x, c2y, c2r);
  if (hit) {
    fill(34,122,34);
  } else {
    fill(2, 11, 2);
  }
  
  ellipse(c2x, c2y, c2r*2, c2r*2);
  
  // mouse circle:
  fill(0, 130);
  ellipse(c1x, c1y, c1r*2, c1r*2);
}

boolean circleOnCircle(float c1x, float c1y, float c1r, float c2x, float c2y, float c2r) {
  // distance between circle centers.
  // compute distance with pythagorean theor.
  float distX = c1x - c2x;
  float distY = c1y - c2y;
  float distance = sqrt( (distX*distX) + (distY*distY));  

  // if distance is < sum of the circle's radii, they are touching.
  
  if (distance <= c1r+c2r) {
  return true;
  } else {
    return false;
  }

}