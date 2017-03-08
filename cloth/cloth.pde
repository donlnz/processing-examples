import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;
import toxi.geom.*;

Particle[][] particles = new Particle[40][40];
ArrayList<Spring> springs = new ArrayList<Spring>();
VerletPhysics2D physics;

float scale = 10;

void setup() {
  size(600, 800);
  
  physics = new VerletPhysics2D();
  physics.setTimeStep(1.0 / 60);
  Vec2D gravity = new Vec2D(0, 9.8);
  GravityBehavior2D gb = new GravityBehavior2D(gravity);
  physics.addBehavior(gb);
  
  float x = 100;
  float y = 10;
  for (int i = 0; i < 40; i++) {
    y = 10;
    for (int j = 0; j < 40; j++) {
      Particle p = new Particle(x, y);
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
      Spring s1 = new Spring(a, b, scale, 0.5);
      Spring s2 = new Spring(a, c, scale, 0.5);
      springs.add(s1);
      springs.add(s2);
      physics.addSpring(s1);
      physics.addSpring(s2);
    }
  }
  
  Particle p = particles[0][0];
  p.lock();
  p = particles[particles.length - 1][0];
  p.lock();
}

void draw() {
  background(51);
  physics.update();
  for (int i = 0; i < particles.length; i++) {
    for (int j = 0; j < particles[i].length; j++) {
     //particles[i][j].show();
    }
  }
  
  for (Spring s : springs) {
    s.show();
  }
}