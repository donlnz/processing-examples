class Spring extends VerletSpring3D {
  Spring(Particle a, Particle b, float len, float strength){
    super(a, b, len, strength);
  }
  
  void show() {
    stroke(255);
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  }
}