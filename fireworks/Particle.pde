class Particle {
  
  PVector pos, v, a;
  
  Particle(float x, float y) {
    this.pos = new PVector(x, y);
    this.v = new PVector(0, 0);
    this.a = new PVector(0, 0);
  }
  
  void applyForce(PVector force) {
    this.a.add(force);
  }
  
  void update() {
    this.v.add(this.a);
    this.pos.add(this.v);
    this.a.mult(0);
  }
  
  void show() {
    point(this.pos.x, this.pos.y);
  }
}