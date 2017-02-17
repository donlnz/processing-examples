Drop[] drops = new Drop[500];

void setup() {
  size(1500, 900);
  
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
}

void draw() {
  background(230, 230, 250);
  
  for (int i = 0; i < drops.length; i++) {
    drops[i].update();
    drops[i].show();
  }
}