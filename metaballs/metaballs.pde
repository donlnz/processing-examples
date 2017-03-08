class Blob {
  PVector pos;
  PVector v;
  float r;
  
  Blob(PVector pos, float r) {
    this.pos = pos;
    this.r = r;
    this.v = PVector.random2D();
    this.v.mult(random(1, 2));
  }
  
  void update() {
    this.pos.add(v);
    
    if (this.pos.x > width || this.pos.x < 0)
      this.v.x *= -1;
      
    if (this.pos.y > height || this.pos.y < 0)
      this.v.y *= -1;
  }
  
  void show() {
    noFill();
    stroke(255);
    ellipse(this.pos.x, this.pos.y, this.r, this.r);
  }
}

int n_blobs = 4;
Blob[] blobs = new Blob[n_blobs];

void setup() {
  size(400, 400);
  for (int i = 0; i < n_blobs; i++) {
    blobs[i] = new Blob(new PVector(random(width), random(height)), random(10000));
  }
}

int getColor(int x, int y) {
  int s = 0;
  for (Blob b : blobs) {
    float d = dist(x, y, b.pos.x, b.pos.y);
    s += (b.r / d);
  }
  return color(s);
}

void draw() {
  for (Blob b : blobs) {
    b.update();
  }
  
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int idx = x + y * width;
      pixels[idx] = getColor(x, y);
    }
  }
  updatePixels();
  //b.show();
}