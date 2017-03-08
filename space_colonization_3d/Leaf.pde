class Leaf {
  PVector pos;
  boolean reached = false;  
  
  Leaf(PVector minPos, PVector maxPos) {
    this.pos = new PVector(random(minPos.x, maxPos.x), random(minPos.y, maxPos.y), random(minPos.z, maxPos.z));
    this.pos = PVector.random3D();
    this.pos.mult(random(width / 2));
  }
  
  void show() {
    fill(255);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    ellipse(0, 0, 4, 4);
    popMatrix();
  }
}