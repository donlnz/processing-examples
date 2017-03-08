import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;
import toxi.physics3d.constraints.*;
import toxi.geom.*;
import peasy.*;

Particle[][] particles = new Particle[40][40];
ArrayList<Spring> springs = new ArrayList<Spring>();
VerletPhysics3D physics;

float scale = 10;

PeasyCam cam;

void setup() {
  //size(600, 800, P3D);
  fullScreen(P3D);
  
  physics = new VerletPhysics3D();
  physics.setTimeStep(1.0 / 60);
  Vec3D gravity = new Vec3D(0, 9.8, 0);
  GravityBehavior3D gb = new GravityBehavior3D(gravity);
  physics.addBehavior(gb);
  
  cam = new PeasyCam(this, 0, 0, 0, 1000);
  
  float x = 100;
  float y = 10;
  for (int i = 0; i < 40; i++) {
    y = 10;
    for (int j = 0; j < 40; j++) {
      Particle p = new Particle(x, y, random(-2, 2));
      particles[i][j] = p;
      physics.addParticle(p);
      y = y + scale;
    }
    x = x + scale;
  }
  
  for (int i = 0; i < particles.length - 1; i++) {
    for (int j = 0; j < particles[i].length - 1; j++) {
      Particle a = particles[i][j];
      Particle b = particles[i + 1][j];
      Particle c = particles[i][j + 1];
      Particle d = particles[i + 1][j + 1];
      Spring s1 = new Spring(a, b, scale, 0.5);
      Spring s2 = new Spring(a, c, scale, 0.5);
      Spring s3 = new Spring(a, c, scale, 0.5);
      springs.add(s1);
      springs.add(s2);
      springs.add(s3);
      physics.addSpring(s1);
      physics.addSpring(s2);
      physics.addSpring(s3);
    }
  }
  
  particles[0][0].lock();
  particles[0][39 ].lock();
}

void draw() {
  background(51);
  physics.update();
  //translate(-width / 2, - height / 2, 0);
  for (int i = 0; i < particles.length; i++) {
    for (int j = 0; j < particles[i].length; j++) {
     //particles[i][j].show();
    }
  }
  
  for (Spring s : springs) {
    s.show();
  }
}