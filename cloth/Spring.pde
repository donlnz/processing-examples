class Spring extends VerletSpring2D {
  Spring(Particle a, Particle b, float len, float strength){
    super(a, b, len, strength);
  }
  
  void show() {
    stroke(255);
    line(a.x, a.y, b.x, b.y);
  }
}