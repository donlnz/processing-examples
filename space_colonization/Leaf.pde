class Leaf {
  PVector pos;
  boolean reached = false;  
  
  Leaf(PVector minPos, PVector maxPos) {
    this.pos = new PVector(random(minPos.x, maxPos.x), random(minPos.y, maxPos.y  ));
  }
  
  void show() {
    fill(255);
    noStroke();
    ellipse(this.pos.x, this.pos.y, 4, 4);
  }
}