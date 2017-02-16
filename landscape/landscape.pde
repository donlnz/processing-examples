int scale = 20;

int w = 1800, h = 1000;
int cols, rows;
float[][] z;

float noise_step = 0.2;
float zoff = 0;

void setup() {
  size(1024, 768, P3D);

  cols = round(w / scale);
  rows = round(h / scale);
  
  //noiseDetail(2, 6);
}

void draw() {
  background(0);
  stroke(255);
  noFill();

  translate(width / 2, height / 2);
  rotateX(PI / 3);
  
  translate(-w / 2, -h / 2 + 50);

  z = new float[cols][rows];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      z[x][y] = map(noise(x * noise_step, y * noise_step -zoff), 0, 1, -100, 100);
    }
  }
  zoff += 0.1;

  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * scale, y * scale, z[x][y]);
      vertex(x * scale, (y + 1) * scale, z[x][y+1]);
    }
    endShape();
  }
  
  println(frameRate);

}