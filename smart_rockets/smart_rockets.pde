ArrayList<Rocket> rockets;
Population population;

int pop_size = 3000;
int lifespan = 200;
PVector target;
int count = 0;

void setup() {
  //size(400, 400);
  fullScreen();
  target = new PVector(width / 2, 20);
  init();
}

void init() {
  count = 0;
  if (population == null) {
    population = new Population(pop_size);
    rockets = new ArrayList<Rocket>();
    for (int i = 0; i < pop_size; i++) {
      Rocket r = new Rocket(lifespan);
      rockets.add(r);
      population.add(r);
    }
  } else {
    population.objects = population.nextGen(target);
    rockets.clear();
    for (DNA d : population.objects) {
      rockets.add((Rocket) d);
    }
  }
}

void draw() {
  background(51);
  count++;
  if (count == lifespan) {
    init();
  }
  for (Rocket r : rockets) {
    r.applyForce(new PVector(0, 0.3));
    r.update();
    r.show();
  }
  fill(255);
  ellipse(target.x, target.y, 24, 24);
}