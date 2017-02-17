int depth = 0;
int start_len = 100;

void setup() {
  size(400, 400);
}

void draw() {
  background(51);

  stroke(255);
  translate(200, height);
  float angle = radians(mouseX);
  branch(angle, start_len, depth);
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    depth -= 1;
  } else {
    depth += 1;
  }
}

void branch(float angle, float len, int depth) {
  if (depth < 0) {
    return;
  }
  
  line(0, 0, 0, -len);
  pushMatrix();
  translate(0, -len);
  rotate(angle);
  branch(angle, -len * 0.67, depth - 1);
  popMatrix();
  pushMatrix();
  translate(0, -len);
  rotate(-angle);
  branch(angle, -len * 0.67, depth - 1);
  popMatrix();
}