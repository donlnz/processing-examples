import peasy.*;

float x = 0.01, y = 0, z = 0;

float sigma = 10;
float rho = 28;
float beta = 8 / 3.0;

float dt = 0.01;

PeasyCam cam;

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
//  size(800, 600, P3D);
  fullScreen(P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 0, 0, 0, 500);
}

void draw() {
  background(0);
  
  float dx = (sigma * (y - x)) * dt;
  float dy = (x * (rho - z) - y) * dt;
  float dz = (x * y - beta * z) * dt;
  
  x = x + dx;
  y = y + dy;
  z = z + dz;
  
  points.add(new PVector(x, y, z));
  
  scale(5);
  noFill();
  
  float hue = 0;
  
  beginShape();
  for (PVector v : points) {
    stroke(hue, 255, 255);
    vertex(v.x, v.y, v.z);
    hue += 0.1;
    hue = hue % 255;
  }
  endShape();
}