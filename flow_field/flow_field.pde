float x_start = 0;
float step_size = 1;
float scale = 0.05;
float y_start = 0;
float z_off = 0;

int cell_size = 10;
int cols, rows;

int n_particles = 50000;
Particle[] particles = new Particle[n_particles];

PVector[][] vector_field;

void setup() {
  //size(1024, 768);
  fullScreen(P2D);
  cols = floor(width / cell_size);
  rows = floor(height / cell_size);

  vector_field = new PVector[cols][rows];

  for (int i = 0; i < n_particles; i++) {
    particles[i] = new Particle(true);
  }
  background(255);
}

void draw() {
  //stroke(255);
  //fill(255, 255, 255, 1);
  //rect(0, 0, width, height);
  
  float y_off = 0;
  println(frameRate);
  
  for (int y = 0; y < rows; y++) {
    float x_off = 0;
    for (int x = 0; x < cols; x++) {
      
      int c = floor(noise(x_off * scale, y_off * scale, z_off * scale) * TWO_PI * 4);
     
      PVector v = PVector.fromAngle(c);
      vector_field[x][y] = v;
      
      //draw_vectors(v, x, y);
      
      x_off += step_size;
    }
    y_off += step_size;
  }
  z_off += step_size / 10;

 for (int i = 0; i < n_particles; i++) {
   Particle p = particles[i];
   int x_index = round(map(p.pos.x, 0, width, 0, cols -1 ));
   int y_index = round(map(p.pos.y, 0, height, 0, rows - 1));
   PVector v = vector_field[x_index][y_index];
   v.setMag(0.05);
   p.applyForce(v);
   p.update();
   p.show();
 }

}

void draw_vectors(PVector v, int x, int y) { 
  stroke(0, 100);
  pushMatrix();
  translate(x * cell_size, y * cell_size);
  rotate(v.heading());
  line(0, 0, cell_size, 0);
  popMatrix();
}