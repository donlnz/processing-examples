public class ParticleSystem {
  
  private int n_particles;
  private PVector[] pos, v, a;

  public ParticleSystem(int n_particles) {
    this.n_particles = n_particles;
    pos = new PVector[n_particles];
    v = new PVector[n_particles];
    a = new PVector[n_particles];
    
    this.init();
  }
  
  private void init() {
    for (int i = 0; i < n_particles; i++) {
      this.init(i);
    }
  }
  
  private void init(int i) {
    pos[i] = new PVector(random(-5, 5), random(-10, 0));
    v[i] = new PVector(0, 0);
    a[i] = new PVector(random(-0.1, 0.1), random(-0.3, -0.1));
  }
  
  public void update() {
    for (int i = 0; i < n_particles; i++) {
      pos[i].add(v[i]);
      v[i].add(a[i]);
      a[i].y += 0.005;
      
      if (pos[i].y > height / 2 || random(0, 1) < 0.05) {
        this.init(i);
      }
    }
  }
  
  public void show() {
    for (int i = 0; i < n_particles; i++) {
      noStroke();
      fill(0, 255, 0, map(pos[i].y, 0, height / 2, 100, 0));
      strokeWeight(1);
      rect(pos[i].x, pos[i].y, 10, 10);
    }
  }
}