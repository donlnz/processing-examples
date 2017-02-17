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

public class landscape extends PApplet {

int scale = 20;

int w = 1800, h = 1000;
int cols, rows;
float[][] z;

float noise_step = 0.2f;
float zoff = 0;

public void setup() {
  

  cols = round(w / scale);
  rows = round(h / scale);
  
  //noiseDetail(2, 6);
}

public void draw() {
  background(0);
  stroke(255);
  noFill();

  translate(width / 2, height / 2);
  rotateX(PI / 3);
  
  translate(-w / 2, -h / 2 + 50);

  z = new float[cols][rows];
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      z[x][y] = map(noise(x * noise_step, y * noise_step -zoff), 0, 1, -100, 100);
    }
  }
  zoff += 0.1f;

  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * scale, y * scale, z[x][y]);
      vertex(x * scale, (y + 1) * scale, z[x][y+1]);
    }
    endShape();
  }
  
  println(frameRate);

}
  public void settings() {  size(1024, 768, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "landscape" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
