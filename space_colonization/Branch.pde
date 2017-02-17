class Branch {
  PVector pos;
  PVector dir;
  PVector origDir;
  Branch parent;
  int count = 0;  
  
  Branch(Branch parent, PVector pos, PVector dir) {
    this.parent = parent;
    this.pos = pos;
    this.dir = dir;
    this.origDir = dir.copy();
  }
  
  Branch next() {
    return new Branch(this, PVector.add(this.pos, this.dir), this.dir.copy());
  }
  
  void reset() {
    this.dir = origDir.copy();
    this.count = 0;  
  }
  
  void show() {
    if (parent != null) {
      stroke(255);
      line(this.pos.x, this.pos.y, this.parent.pos.x, this.parent.pos.y);
    }
  }
}