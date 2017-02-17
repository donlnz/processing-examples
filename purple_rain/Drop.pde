class Drop {
  float x, y, z;
  float a;
  float len;
  
  Drop() {
    this.x = random(width);
    this.y = random(-100, -50);
    this.z = random(0, 20);
    this.a = random(map(this.z, 0, 20, 50, 20));
    this.len = random(map(this.z, 0, 20, 10, 20));
  }
  
  void update() {
    y = y + a;
    a += 0.3;
    
    if (y > height) {
      y = random(-200, -100);
      this.a = random(map(this.z, 0, 20, 50, 20));
    }
  }
  
  void show() {
    stroke(138, 43, 226);
    strokeWeight(map(this.z, 0, 20, 1, 4));
    line(x, y, x, y + this.len);
  }
}