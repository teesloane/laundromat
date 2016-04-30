ArrayList colliz = new ArrayList();
boolean showVectors = true;
int xOrigin, yOrigin, diameter, cRadius;
PVector center;

void setup() {
  size(500, 500);
  smooth();

  xOrigin = width/2;
  yOrigin = height/2;
  diameter = width-100;
  cRadius = diameter/2;
  
  center = new PVector(xOrigin, yOrigin);
  
  for (int i = 0; i < 1; i++) {
    colliz.add(new Circ(new PVector(random(5), random(-5, 5)), new PVector(width/2, height/2)));
  }
}

void draw() {
  background(100);
  noFill();
  stroke(255);
  ellipse(250, 250, diameter, diameter);

  for (int i = 0; i < colliz.size(); i++) {
    Circ test = (Circ) colliz.get(i);
    test.go();
    for (int j = 0; j < colliz.size(); j++) {
      Circ collide = (Circ) colliz.get(j);
      test.collideEqualMass(collide);
    }
  }
}

void mousePressed() {
  //showVectors = !showVectors;
  colliz.add(new Circ(new PVector(random(5), random(-5, 5)), new PVector(mouseX, mouseY)));
}

class Circ {
  PVector loc;
  PVector vel;
  float bounce = 1.0;
  float r = 5;
  boolean colliding = false;
  boolean isIn = true;
  PVector ploc;

  Circ(PVector v, PVector l) {
    vel = v.get();
    loc = l.get();
  }

  // Main method to operate object
  void go() {
    update();
    borders();
    render();
  }

  // Method to update location
  void update() {
    ploc = loc;
    vel.limit(5);
    loc.add(vel);
  }

  void borders() {
    //    TEST TO SEE IF A CIRCLE CAN BE USED AS THE BOUNDRY
    //    
    if (loc.dist(center) >= cRadius) {
      float a = PVector.angleBetween(loc, center);
      ploc.sub(vel);
      
      vel.y *= -bounce;
      vel.x *= -bounce;


      
      loc.x = ploc.x;
      loc.y = ploc.y;
    }
  
  }  

  void inside() {
    if ((sq(loc.x - xOrigin) + sq(loc.y - yOrigin)) <= sq(cRadius)) {
      isIn = true;
    } 
    else { 
      isIn = false;
    }
  }
  // Method to display
  void render() {
    ellipseMode(CENTER);
    noStroke();
    fill(255);
    ellipse(loc.x, loc.y, r*2, r*2);
    if (showVectors) {
      drawVector(vel, loc, 10);
    }
  }

  void collideEqualMass(Circ t) {
    float d = PVector.dist(loc, t.loc);
    float sumR = r + t.r;
    // Are they colliding?
    if (!colliding && d <= (sumR+1) ) {
      // Yes, make new velocities!
      colliding = true;
      // Direction of one object another
      PVector n = PVector.sub(t.loc, loc);
      n.normalize();

      // Difference of velocities so that we think of one object as stationary
      PVector u = PVector.sub(vel, t.vel);

      // Separate out components -- one in direction of normal
      PVector un = componentVector(u, n);
      // Other component
      u.sub(un);
      // These are the new velocities plus the velocity of the object we consider as stastionary
      vel = PVector.add(u, t.vel);
      t.vel = PVector.add(un, t.vel);
    } 
    else if (d > sumR) {
      colliding = false;
    }
  }
}

PVector componentVector (PVector vector, PVector directionVector) {
  //--! ARGUMENTS: vector, directionVector (2D vectors)
  //--! RETURNS: the component vector of vector in the direction directionVector
  //-- normalize directionVector
  directionVector.normalize();
  directionVector.mult(vector.dot(directionVector));
  return directionVector;
}

void drawVector(PVector v, PVector loc, float scayl) {
  pushMatrix();
  float arrowsize = 4;
  // Translate to location to render vector
  translate(loc.x,loc.y);
  stroke(0);
  // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
  rotate(v.heading2D());
  // Calculate length of vector & scale it to be bigger or smaller if necessary
  float len = v.mag()*scayl;
  // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
  line(0,0,len,0);
  line(len,0,len-arrowsize,+arrowsize/2);
  line(len,0,len-arrowsize,-arrowsize/2);
  popMatrix();
}


//void mousePressed() {
//  showVectors = !showVectors;
//}