float x_start = 0;
float step_size = 0.01;
float scale = 1;//0.01;
float y_start = 0;

void setup() {
  size(400, 400);
  
}

void draw() {
  loadPixels();
  background(51);
  
  float y_off = 0;
  
  for (int y = 0; y < height; y++) {
    float x_off = 0;
    for (int x = 0; x < width; x++) {
      int index = x + y * width;
      
      int c = floor(noise(x_off * scale, y_off * scale) * 255);
      
      int r = c;
      int g = c;
      int b = c;
      int a = 255;
      
      pixels[index] = color(r, g, b, a);
      
      x_off += step_size;
    }
    y_off += step_size;
  }
  
  //x_off += x_step;
  
  updatePixels();
}