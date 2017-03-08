import peasy.*;

Tree t;
float max_dist = 200;
float min_dist = 10;

PeasyCam cam;

void setup() {
  size(400, 400, P3D);
  t = new Tree(new PVector(0, height, 0), min_dist, max_dist);
  cam = new PeasyCam(this, 0, 0, 0, 3000);
}

void draw() {
  background(51);
  t.grow();
  t.show();
}