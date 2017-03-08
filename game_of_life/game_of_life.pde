boolean[][] grid;
color[][] colors;
int scale = 20;
int cols, rows;
boolean running = false;

void setup() {
  size(600, 600);
  frameRate(10);
  
  cols = floor(width / scale);
  rows = floor(height / scale);
  
  grid = new boolean[cols][rows];
  colors = new color[cols][rows];
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int r = round(random(100, 255));
      color c = color(r, r, r);
      colors[x][y] = c;
      grid[x][y] = false;
    }
  }  
}

void mousePressed() {
  if (mouseButton == LEFT) {
    int x = floor(mouseX / scale);
    int y = floor(mouseY / scale);
    grid[x][y] = !grid[x][y];
  } else if (mouseButton == RIGHT) {
    running = !running;
  }
}

boolean[][] update() {
  boolean[][] newGrid = new boolean[cols][rows];
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      int neighbors = 0;
      neighbors = y < (rows - 1) && grid[x][y + 1] ? neighbors + 1 : neighbors;
      neighbors = y > 0 && grid[x][y - 1] ? neighbors + 1 : neighbors;
      neighbors = x < (cols - 1) && grid[x + 1][y] ? neighbors + 1 : neighbors;
      neighbors = x > 0 && grid[x - 1][y] ? neighbors + 1 : neighbors;
      neighbors = x > 0 && y > 0 && grid[x - 1][y - 1] ? neighbors + 1 : neighbors;
      neighbors = x > 0 && y < (rows - 1) && grid[x - 1][y + 1] ? neighbors + 1 : neighbors;
      neighbors = x < (cols - 1) && y > 0 && grid[x + 1][y - 1] ? neighbors + 1 : neighbors;
      neighbors = x < (cols - 1) && y < (rows - 1) && grid[x + 1][y + 1] ? neighbors + 1 : neighbors;
      
      if (grid[x][y] && (neighbors < 2 || neighbors > 3)) {
        newGrid[x][y] = false;
      } else if (grid[x][y]) {
        newGrid[x][y] = true;
      } else if (neighbors == 3) {
        newGrid[x][y] = true;
      }
    }
  }  
  return newGrid;
}

void draw() {
  background(51);
  noStroke();
  noFill();
  
  if (running)
    grid = update();
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (grid[x][y]) {
        fill(colors[x][y]);
        rect(x * scale, y * scale, scale, scale);
      }
    }
  }
}