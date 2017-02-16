public class Particle {

  private static final int MAX_VELOCITY = 1;
  
  private final PVector[] COLORS = {
    new PVector(148, 0, 211), //Violet
    new PVector(75, 0, 140), //Indigo
    new PVector(0, 0, 255), //Blue
    new PVector(0, 255, 0), //Green
    new PVector(255, 255, 0), //Yellow
    new PVector(255, 127, 0), //Orange
    new PVector(255, 0, 0) //Red
  };
  
  private PVector prev_pos, pos, v, a, c;
    
  public Particle() {
    this.pos = new PVector(0, 0);
    this.updatePrevious();
    this.v = new PVector(0, 0);
    this.a = new PVector(0, 0);
    this.c = new PVector(0, 0, 0);
}
 
  public Particle(boolean randomized) {
    this();
    if (randomized) {
      this.pos = new PVector(random(width), random(height));
      this.updatePrevious();
      this.v = PVector.random2D();
      this.a = new PVector(0, 0);
      this.c = COLORS[round(map(this.pos.x * this.pos.y, 0, width * height, COLORS.length - 1, 0))];
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
    //int r = round(noise(this.pos.x) * 255);
    //int b = round(noise(this.pos.y) * 255);
    stroke(this.c.x, this.c.y, this.c.z, noise(this.pos.x, this.pos.y) * 50);
    if (debug)
      strokeWeight(4);
 
    line(this.prev_pos.x, this.prev_pos.y, this.pos.x, this.pos.y);
    
    if (debug)
      strokeWeight(1);
}
}