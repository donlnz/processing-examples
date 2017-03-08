import peasy.*;

float radius = 100;
float n1 = 1, n2 = 1, n3 = 1;
float m = 7;
float a = 1;
float b = 1;

float osc = 0;

PVector[][] sphere;

int n_points = 75;

PeasyCam cam;

void setup() {
  size(400, 400, P3D);
  colorMode(HSB);
  
  cam = new PeasyCam(this, 0, 0, 0, 500);
  
  sphere = new PVector[n_points + 1][n_points + 1];
  createSphere();
}

float calc_r(float theta, float m, float n1, float n2, float n3) {
  float result = 0;
  
  float term1 = (1 / a) * cos(m * theta / 4);
  term1 = pow(abs(term1), n2);
  
  float term2 = (1 / b) * sin(m * theta / 4);
  term2 = pow(abs(term2), n3);
  
  result = pow(term1 + term2, -1 / n1);
  
  return result;
}

void createSphere() {
 for (int i = 0; i < n_points + 1; i++) {
   float lat = map(i, 0, n_points, -HALF_PI, HALF_PI);
   //float r2 = calc_r(lat, 2, 10, 10, 10);
   float r2 = calc_r(lat, m, .2, 1.7, 1.7);
   for (int j = 0; j < n_points + 1; j++) {
      float lon = map(j, 0, n_points, -PI, PI);
      //float r1 = calc_r(lon, 8, 60, 100, 30);     
      float r1 = calc_r(lon, m, .2, 1.7, 1.7);
      
      float x = radius * r1 * cos(lon) * r2 * cos(lat);
      float y = radius * r1 * sin(lon) * r2 * cos(lat);
      float z = radius * r2 * sin(lat);
      
      sphere[i][j] = new PVector(x, y, z);
    }
  }
}

void draw() {
  background(0);
  //stroke(255);
  noStroke();
  //noFill();
  //lights();
    
  m = (map(sin(osc), -1, 1, 10, 10));
  osc += 0.01;
    
  createSphere();  
  
  float inc = TWO_PI / n_points;
  for (int i = 0; i < n_points; i++) {
    beginShape(TRIANGLE_STRIP);
    float hue = map(i, 0, n_points, 0, 255);
    fill(hue, 255, 255);
    for (int j = 0; j < n_points + 1; j++) {
      PVector v1 = sphere[i][j];
      PVector v2 = sphere[i + 1][j];
      vertex(v1.x, v1.y, v1.z);
      vertex(v2.x, v2.y, v2.z);
    }
    endShape(CLOSE);
  }
}