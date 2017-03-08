int iterations = 50;
int[][] vals;
float scale = 2;
float xpos = 0, ypos = 0;
float scale_delta = 0.8;
int[] colors;
float[] c = {0, 0};
//float[] c = {-.70176, -.3842};
float a_speed = 0.01;

float a = -1;

void setup() {
  size(800, 800);
  colorMode(HSB);
  
  colors = new int[9];
  colors[0] = color(255, 0, 0);
  colors[1] = color(200, 0, 55);
  colors[2] = color(100, 0, 155);
  colors[3] = color(0, 0, 255);
  colors[4] = color(0, 55, 200);
  colors[5] = color(0, 155, 155);
  colors[6] = color(0, 255, 0);
  colors[7] = color(55, 200, 0);
  colors[8] = color(155, 100, 0);
  
  update();
}

int iterations() {
  return 1;
}

void update() {
  vals = calc(scale, iterations, c, 16);
}

void mousePressed() {
  xpos = map(mouseX, 0, width, xpos-scale, xpos+scale);
  ypos = map(mouseY, 0, height, ypos-scale, ypos+scale);
  if (mouseButton == LEFT) {
    scale *= scale_delta;
  } else if (mouseButton == RIGHT) {
    scale /= scale_delta;
  }
  update();
}

void keyPressed() {
  if (key == 'I') {
    ypos -= scale;
  } else if (key == 'J') {
    xpos -= scale;
  } else if (key == 'L') {
    xpos += scale;
  } else if (key == 'K') {
    ypos += scale;
  }
}

void update(float[] n) {
  float real = n[0], imag = n[1];
  float newReal = real * real - imag * imag;
  float newImag = 2 * real * imag;
  n[0] = newReal;
  n[1] = newImag;
}

int[][] calc(float scale, int iterations, float[] c, float threshold) {
  int[][] result = new int[width][height];
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      
      float a = map(x, 0, width, xpos-scale, xpos+scale);
      float b = map(y, 0, height, ypos-scale, ypos+scale);
      
      int z = 0;
      
      float[] r = new float[2];
      r[0] = a;
      r[1] = b;
      int i;
      for (i = 0; i < iterations; i++) {
        update(r);
        r[0] += c[0];
        r[1] += c[1];
        
        if (r[0] * r[0] + r[1] * r[1] > threshold)
          break;
      }
      
      if (i == iterations) {
        result[x][y] = color(0, 0, 0);
      } else {
        float n = map(i, 0, iterations, 0, 1);
        float h = map(sqrt(n), 0, 1, 0, 360); 
        result[x][y] = color(h, 255, 255);
      }
    }
  }
  return result;
}

void draw() {
  //background(51);
  c[0] = cos(a * 1.1);
  c[1] = cos(a);
  a += a_speed;
  update();
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int c = vals[x][y];
      int idx = x + y * width;
      pixels[idx] = c;
    }
  }
  updatePixels();
}