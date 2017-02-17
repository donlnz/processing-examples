import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class flow_field extends PApplet {

float x_start = 0;
float step_size = 1;
float scale = 0.05f;
float y_start = 0;
float z_off = 0;

int cell_size = 10;
int cols, rows;

int n_particles = 50000;
Particle[] particles = new Particle[n_particles];

PVector[][] vector_field;

public void setup() {
  //size(1024, 768);
  
  cols = floor(width / cell_size);
  rows = floor(height / cell_size);

  vector_field = new PVector[cols][rows];

  for (int i = 0; i < n_particles; i++) {
    particles[i] = new Particle(true);
  }
  background(255);
}

public void draw() {
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
   v.setMag(0.05f);
   p.applyForce(v);
   p.update();
   p.show();
 }

}

public void draw_vectors(PVector v, int x, int y) { 
  stroke(0, 100);
  pushMatrix();
  translate(x * cell_size, y * cell_size);
  rotate(v.heading());
  line(0, 0, cell_size, 0);
  popMatrix();
}
public class Particle {

  private static final int MAX_VELOCITY = 1;
  
  private PVector prev_pos, pos, v, a;
    
  public Particle() {
    this.pos = new PVector(0, 0);
    this.updatePrevious();
    this.v = new PVector(0, 0);
    this.a = new PVector(0, 0);
  }
  
  public Particle(boolean randomized) {
    this();
    if (randomized) {
      this.pos = new PVector(random(width), random(height));
      this.updatePrevious();
      this.v = PVector.random2D();
      this.a = new PVector(0, 0);
    }
  }
  
  public Particle(PVector pos, PVector v, PVector a) {
    this.pos = pos;
    this.prev_pos = pos;
    this.v = v;
    this.a = a;
  }
  
  public void update() {
    this.updatePrevious();
    this.pos.add(this.v);
    this.v.add(a);
    this.v.limit(MAX_VELOCITY);
    this.a.mult(0);
    this.checkEdges();
  }
  
  private void checkEdges() {
    if (this.pos.x < 0) {
      this.pos.x = width;
      this.updatePrevious();
    }
    if (this.pos.y < 0) {
      this.pos.y = height;
      this.updatePrevious();
    }
    if (this.pos.x > width) {
      this.pos.x = 0;
      this.updatePrevious();  
  }
    if (this.pos.y > height) {
      this.pos.y = 0;
      this.updatePrevious();
    }
  }
  
  private void updatePrevious() {
    this.prev_pos = this.pos.copy();
  }
  
  public void applyForce(PVector f) {
    this.a.add(f);
  }
  
  public void show() {
    this.show(false);
  }
  
  public void show(boolean debug) {
    stroke(0, noise(this.pos.x, this.pos.y) * 25);
    if (debug)
      strokeWeight(4);
 
    line(this.prev_pos.x, this.prev_pos.y, this.pos.x, this.pos.y);
    
    if (debug)
      strokeWeight(1);
}
}
  public void settings() {  fullScreen(P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "flow_field" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
