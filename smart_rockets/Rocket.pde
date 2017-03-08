class Rocket extends DNA {
  PVector pos, v, a;
  int count = 0;
  
  Rocket(int lifespan) {
    super(lifespan);
    this.pos = new PVector(width / 2, height / 2);
    this.v = new PVector(0, 0);
    this.a = new PVector(0, 0);
  }
  
  void applyForce(PVector force) {
    this.a.add(force);
  }
  
  Rocket crossover(DNA partner) {
    float[] newDna = new float[this.dna.length];
    int x = round(random(1, this.dna.length - 2));
    for (int i = 0; i < x; i++) {
      newDna[i] = this.dna[i];
    }
    for (int i = x; i < newDna.length; i++) {
      newDna[i] = partner.dna[i];
    }
    Rocket r = new Rocket(this.lifespan);
    r.dna = newDna;
    r.fitness = (this.fitness + partner.fitness) / 2.0;
    return r;
  }
  
  float eval(PVector target) {
    return 1 / PVector.dist(target, this.pos);
  }
  
  void update() {
    this.applyForce(new PVector(this.dna[count], this.dna[count + 1]));
    count = (count + 1) % (lifespan - 2);

    this.v.add(a);
    this.pos.add(v);
    this.a.mult(0);
    count++;
  }
  
  void show() {
    pushMatrix();
    noStroke();
    float c = map(this.fitness, 0, 1, 0, 255);
    fill(255-c, c, 0, 50);
    translate(this.pos.x, this.pos.y);
    rectMode(CENTER);
    rotate(this.v.heading());
    rect(0, 0, 25, 5);
    popMatrix();
  }
}