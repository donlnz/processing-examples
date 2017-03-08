ArrayList<Firework> fireworks = new ArrayList<Firework>();
PVector gravity;
//int n_firework = 100;

void setup() {
  //size(400, 400);
  fullScreen();
  colorMode(HSB);
  stroke(255);
  strokeWeight(5);
  
  gravity = new PVector(0, 0.2);
    
}

void draw() {
  background(0, 0, 0, 10);

  if (random(0, 1) < 0.05) {
    Firework f = new Firework(round(random(150, 200)));
    fireworks.add(f);
  }
 
  for (int i = fireworks.size() - 1; i >= 0; i--) {
    if (fireworks.get(i).particles.size() < 1) {
      fireworks.remove(i);
    }
    else {
      fireworks.get(i).update();
      fireworks.get(i).show();
    }
  }
}