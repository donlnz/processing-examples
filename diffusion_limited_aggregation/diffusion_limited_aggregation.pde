PVector walker;
ArrayList<PVector> tree = new ArrayList<PVector>();
int r = 5;
ArrayList<PVector> walkers = new ArrayList<PVector>();
int n_walkers = 2000;

void setup() {
  colorMode(HSB);
  size(600, 600);
  
  tree.add(new PVector(width / 2, height / 2));
  walker = newWalker();
  
  for (int i = 0; i < n_walkers; i++) {
    walkers.add(newWalker());
  }

  background(51);
}

void draw() {
  fill(51, 51, 51, 10);
  rect(0, 0, width, height);
  noStroke();

  for (int i = walkers.size() - 1; i >= 0; i--) {
    for (int j = tree.size() - 1; j >= 0; j--) {
      if (spheresCollide(walkers.get(i), tree.get(j))) {
        tree.add(walkers.get(i));
        walkers.remove(i);
        if (!(walker.x <= 1 || walker.x >= width - 1 || walker.y <= 1 || walker.y >= height - 1))
          walkers.add(newWalker());
        break;
      }
    }
  }
  
  for (PVector p : tree) {
    float d = PVector.dist(p, new PVector(width / 2, height / 2));
    float max_d = PVector.dist(new PVector(0, 0), new PVector(height / 2, width / 2));
    fill(map(d, 0, max_d, 0, 255), 255, 255);
    ellipse(p.x, p.y, r * 2, r * 2);
  }

  fill(0, 0, 255);
  for (PVector w : walkers) {
    PVector v = PVector.random2D();
    v.setMag(r * 2/3);
    w.add(v);
    w.x = constrain(w.x, 0, width);
    w.y = constrain(w.y, 0, height);
    ellipse(w.x, w.y, r * 2, r * 2);
  }

}

boolean spheresCollide(PVector a, PVector b) {
  float dx = b.x - a.x;
  float dy = b.y - a.y;
  return (dx * dx + dy * dy) < r * r * 4;
}

PVector newWalker() {
  int i = floor(random(4));
  switch (i) {
    case 0:
      return new PVector(random(width), 0);
    case 1:
      return new PVector(random(width), height);
    case 2:
      return new PVector(0, random(height));
    default:
      return new PVector(width, random(height));
  }
}