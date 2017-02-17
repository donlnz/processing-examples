class Star {
  float x, y, z;
  
  float pz;
  
  PVector c;
  
  Star() {
    this.x = random(-width, width);
    this.y = random(-height, height);
    this.z = random(0, width);
    
    this.pz = z;
    
    this.c = new PVector(random(200, 255), random(200, 255), random(200, 255));
  }
  
  void update() {
    z -= speed;
    
    if (z < 1) {
      z = width;
      x = random(-width, width);
      y = random(-height, height);
      
      this.pz = z;
    }
  }
  
  void show() {
    fill(255);
    noStroke();
    
    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    float r = map(z, 0, width, 8, 0);
    
    float px = map(x / pz, 0, 1, 0, width);
    float py = map(y / pz, 0, 1, 0, height);
    
    if (px != 0 && py != 0) {
      stroke(c.x, c.y, c.z, 100);
      strokeWeight(r);
      line(px, py, sx, sy);
    }
    
    pz = z;
  }
}