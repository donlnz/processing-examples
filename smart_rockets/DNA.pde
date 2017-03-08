abstract class DNA {
  float[] dna;
  int lifespan;
  float fitness = 255;
  
  DNA(int lifespan) {
    this.lifespan = lifespan;
    this.dna = new float[lifespan];
    for (int i = 0; i < lifespan; i++) {
      dna[i] = random(-1, 1);
    }
  }
  
  abstract float eval(PVector target);
  abstract DNA crossover(DNA partber);
  
  void mutate() {
    int idx = floor(random(0, dna.length));
    dna[idx] = random(-1, 1);
  }
}