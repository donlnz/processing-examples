Tree t;
float max_dist = 100;
float min_dist = 10;

void setup() {
  size(400, 400);
  t = new Tree(new PVector(width / 2, height), min_dist, max_dist);
}

void draw() {
  background(51);
  t.grow();
  t.show();
}