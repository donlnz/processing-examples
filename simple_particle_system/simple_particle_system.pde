ParticleSystem ps;

PVector a;

void setup() {
  //size(1024, 768);
  fullScreen();
  ps = new ParticleSystem(5000);
}

void draw() {
  background(0);
  translate(width / 3, height - height / 3);
  ps.update();
  ps.show();
}