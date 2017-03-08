void setup() {
  size(400, 400);
}

int sign(float x) {
  if (x < 0)
    return -1;
  if (x > 0)
    return 1;
  return 0;
}

void draw() {
  background(51);
  noFill();
  stroke(255);
  
  translate(width / 2, height / 2);
  
  beginShape();
  
  float r = 100;
  
  float n = 2;
  float a = r;
  float b = r;
  
  for (float theta = 0; theta < TWO_PI; theta += 0.01) {
    float c_t = cos(theta);
    float s_t = sin(theta);
    
    float p = 2 / n;
    
    float x = pow(abs(c_t), p) * a * sign(c_t);
    float y = pow(abs(s_t), p) * b * sign(s_t);
    vertex(x, y);
  }
  endShape(CLOSE);
}