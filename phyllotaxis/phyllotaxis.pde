int n_dots = 500;
int c = 1;
float scale = 8;

void setup() {
  colorMode(HSB);
  size(400, 400);
}

void draw() {
  background(51);
  strokeWeight(scale);
  
  translate(width / 2, height / 2);
  
  for (int i = 0; i < n_dots; i++) {
    float a = i * 137.5;
    float r = c * sqrt(i) * scale;

    a = radians(a) % TWO_PI;
    
    stroke(map(a, 0, TWO_PI, 0, 255), 255, 255);
    
    int x = floor(r * cos(a));
    int y = floor(r * sin(a));
    
    point(x, y);
  }
}