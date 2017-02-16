public class Particle {

  private static final int MAX_VELOCITY = 1;
  
  private PVector prev_pos, pos, v, a;
    
  public Particle() {
    this.pos = new PVector(0, 0);
    this.updatePrevious();
    this.v = new PVector(0, 0);
    this.a = new PVector(0, 0);
  }
  
  public Particle(boolean randomized) {
    this();
    if (randomized) {
      this.pos = new PVector(random(width), random(height));
      this.updatePrevious();
      this.v = PVector.random2D();
      this.a = new PVector(0, 0);
    }
  }
  
  public Particle(PVector pos, PVector v, PVector a) {
    this.pos = pos;
    this.prev_pos = pos;
    this.v = v;
    this.a = a;
  }
  
  public void update() {
    this.updatePrevious();
    this.pos.add(this.v);
    this.v.add(a);
    this.v.limit(MAX_VELOCITY);
    this.a.mult(0);
    this.checkEdges();
  }
  
  private void checkEdges() {
    if (this.pos.x < 0) {
      this.pos.x = width;
      this.updatePrevious();
    }
    if (this.pos.y < 0) {
      this.pos.y = height;
      this.updatePrevious();
    }
    if (this.pos.x > width) {
      this.pos.x = 0;
      this.updatePrevious();  
  }
    if (this.pos.y > height) {
      this.pos.y = 0;
      this.updatePrevious();
    }
  }
  
  private void updatePrevious() {
    this.prev_pos = this.pos.copy();
  }
  
  public void applyForce(PVector f) {
    this.a.add(f);
  }
  
  public void show() {
    this.show(false);
  }
  
  public void show(boolean debug) {
    stroke(0, noise(this.pos.x, this.pos.y) * 25);
    if (debug)
      strokeWeight(4);
 
    line(this.prev_pos.x, this.prev_pos.y, this.pos.x, this.pos.y);
    
    if (debug)
      strokeWeight(1);
}
}