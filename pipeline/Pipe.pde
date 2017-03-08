class Pipe {
  PVector pos;

  Pipe left, right, up, down;
  
  int scale;
  int offset;
  
  Pipe(PVector pos, int scale) {
    this.pos = pos;
    this.scale = scale;
    this.offset = round(scale / 10);
  }
  
  void show() {
    noStroke();
    fill(255);
    pushMatrix();
    
    translate(this.pos.x + this.scale / 2, this.pos.y + this.scale / 2);
   
    int x_start = round(this.pos.x * this.scale - this.scale / 2 + this.offset);
    int x_size = round(this.scale - this.offset);
    int y_start = round(this.pos.y * this.scale - this.scale / 2 + this.offset);
    int y_size = round(this.scale - this.offset);
    
    rect(x_start, y_start, x_size, y_size);

    popMatrix();
  }
  
  Pipe connect(ArrayList<Pipe> grid) {
    if (random(0, 1) > 0.01)
      return null;
    
    boolean horizontal = false;
    if (random(0, 1) > 0.5)
      horizontal = true;
      
    int sign = 1;
    if (random(0, 1) > 0.5)
      sign = -1;
    
    PVector connectPos = this.pos.copy();
    if (horizontal)
      connectPos.add(new PVector(sign, 0));
    else
      connectPos.add(new PVector(0, sign));
    
    boolean found = false;
    Pipe connected = null;
    for (Pipe p : pipes) {
      if (p.pos == connectPos) {
        found = true;
        connected = p;
        break;
      }
    }
    
    if (!found) {
      return new Pipe(connectPos, this.scale);
    }
    
    return null;
  }
}