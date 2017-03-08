class Particle extends VerletParticle3D {
  
  Particle(float x, float y, float z) {
    super(x, y, z);
  }
  
  void show() {
    fill(255);
    //translate(x, y, z);
    ellipse(x, y, 10, 10);
  }
}