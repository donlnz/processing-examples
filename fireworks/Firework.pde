class Firework {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  Particle particle;
  int n_particles;
  boolean exploded = false;
  int c;
  
  Firework(int n_particles) {
    this.particle = new Particle(random(0, width), height);
    this.particle.applyForce(new PVector(random(-2, 2), random(-20, -8)));
    this.particles.add(particle);
    this.n_particles = n_particles;
    this.c = color(random(0, 255), 255, 255, 200);
  }
  
  void update() {
    for (Particle p : particles) {
      p.applyForce(gravity);
      p.update();
    }
    
    if (this.particle.v.y >= 0 && !this.exploded) {
      this.particles.clear();
      this.exploded = true;
      for (int i = 0; i < this.n_particles; i++) {
        Particle p = new Particle(this.particle.pos.x, this.particle.pos.y);
        p.applyForce(PVector.random2D().setMag(random(1, 5)));
        this.particles.add(p);
      }
    } else if (this.exploded) {
      for (int i = this.particles.size() - 1; i >= 0; i--) {
        if (this.particles.get(i).pos.y > height)
          this.particles.remove(i);
      }
    }
  }
  
  void show() {
    stroke(this.c);
    for (Particle p : particles) {
      p.show();
    }
  }
}