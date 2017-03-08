float radius = 100;
float n1 = 1, n2 = 1, n3 = 1;
float m = 7;
float a = 1;
float b = 1;

float osc = 0;

int n_points = 1000;

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

float calc_r(float theta) {
  float r = 0;
  
  float term1 = (1 / a) * cos((m / 4) * theta);
  term1 = pow(abs(term1), n2);
  
  float term2 = (1 / b) * sin((m / 4) * theta);
  term2 = pow(abs(term2), n3);
  
  r = pow(term1 + term2, 1 / n1);
  
  return 1 / r;
}

void draw() {
  background(51);
  noFill();
  stroke(255);
  
  translate(width / 2, height / 2);
  
  m = (map(sin(osc), -1, 1, 0, 10));
  osc += 0.01;
  
  beginShape();
  
  float inc = TWO_PI / n_points;
  
  for (float theta = 0; theta < TWO_PI; theta += inc) {
    float r = calc_r(theta);
    
    float x = radius * r * cos(theta);
    float y = radius * r * sin(theta);
    vertex(x, y);
  }
  endShape(CLOSE);
}