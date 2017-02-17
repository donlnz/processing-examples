float[][] agrid, bgrid, anext, bnext;

float da = 1, db = 0.5;
float f = 0.055, k = 0.062;
float dt = 1;

void setup() {
  size(600, 400);
  
  agrid = new float[width][height];
  bgrid = new float[width][height];
  anext = new float[width][height];
  bnext = new float[width][height];
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      agrid[x][y] = 1;
      bgrid[x][y] = 0;
      
      anext[x][y] = 1;
      bnext[x][y] = 0;
    }
  }
  
  for (int x = 280; x < 300; x++) {
    for (int y = 100; y < 110; y++) {
      bgrid[x][y] = 1;
    }
  }
  
 for (int x = 380; x < 410; x++) {
    for (int y = 200; y < 205; y++) {
      bgrid[x][y] = 1;
    }
  }
}


float laplace(float[][] grid, int x, int y) {
  float s = 0;
  s += grid[x][y] * -1;
  s += grid[x + 1][y] * 0.2;
  s += grid[x - 1][y] * 0.2;
  s += grid[x][y + 1] * 0.2;
  s += grid[x][y - 1] * 0.2;
  s += grid[x + 1][y + 1] * 0.05;
  s += grid[x + 1][y - 1] * 0.05;
  s += grid[x - 1][y + 1] * 0.05;
  s += grid[x - 1][y - 1] * 0.05;
  return s;
}

void draw() {
  background(255);

  for (int x = 1; x < width - 1; x++) {
    for (int y = 1; y < height - 1; y++) {
      float a = agrid[x][y];
      float b = bgrid[x][y];
      
      anext[x][y] = a + (da * laplace(agrid, x, y) - (a * b * b) + f * (1 - a)) * dt;
      bnext[x][y] = b + (db * laplace(bgrid, x, y) + (a * b * b) - b * (k + f)) * dt;
    }
  }
    
  agrid = anext;
  bgrid = bnext;
  
  anext = new float[width][height];
  bnext = new float[width][height];
  
 for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      anext[x][y] = agrid[x][y];
      bnext[x][y] = bgrid[x][y];
    }
  }
    
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float c = floor((agrid[x][y] - bgrid[x][y]) * 255);
      color cl = color(c, c, c);
      int i = (x + y * width);
      pixels[i] = cl;
    }
  }
  updatePixels();
}