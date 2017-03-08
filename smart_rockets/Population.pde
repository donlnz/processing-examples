class Population {
  ArrayList<DNA> objects = new ArrayList<DNA>();
  int n;
  
  Population(int n) {
    this.n = n;
  }
  
  void add(DNA d) {
    objects.add(d);
  }
  
  float[] eval(PVector target) {
    float[] scores = new float[objects.size()];
    for (int i = 0; i < objects.size(); i++) {
      scores[i] = objects.get(i).eval(target);
    }
    return scores;
  }
  
  ArrayList<DNA> nextGen(PVector target) {
    ArrayList<DNA> newGen = new ArrayList<DNA>();
    ArrayList<DNA> mating = new ArrayList<DNA>();
    float[] scores = eval(target);
    float maxFit = 0.0000001;
    for (int i = 0; i < scores.length; i++) {
      if (scores[i] > maxFit)
        maxFit = scores[i];
    }
    
    for (int i = 0; i < scores.length; i++) {
      scores[i] /= maxFit;
      objects.get(i).fitness = scores[i];
      scores[i] = floor(scores[i] * 100);
    }
    
    for (int i = 0; i < scores.length; i++) {
      for (int j = 0; j < scores[i]; j++) {
        mating.add(rockets.get(i));
      }
    }
   
   while (newGen.size() < rockets.size()) {
     int a = floor(random(mating.size()));
     int b = floor(random(mating.size()));
     
     newGen.add(mating.get(a).crossover(mating.get(b)));
   }
   
   for (DNA d : newGen) {
     if (random(0, 1) < 0.01)
       d.mutate();
   }
   
   return newGen;
  }
}