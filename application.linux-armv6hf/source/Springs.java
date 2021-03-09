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

public class Springs extends PApplet {

//Jeffrey Andersen

float springConstant = 0.5f;
float radius = 10;
float frictionMultiplier = 0.985f;
PVector gravity = new PVector(0, 0.7f);
int numSprings = 20; //must be greater than or equal to one
float restLength = 0.01f;
boolean showParticles = false;
boolean showCloth = false;

Particle[] particles = new Particle[numSprings + 1];
Spring[] springs = new Spring[numSprings];

public void setup() {
  
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(new PVector(width / 2, i * (height / particles.length)), radius, frictionMultiplier);
  }
  for (int i = 0; i < numSprings; i++) {
    springs[i] = new Spring(springConstant, restLength, particles[i], particles[i + 1]);
  }
  strokeWeight(3);
  stroke(255);
  fill(255);
}

public void draw() {
  background(0);
  for (Spring s : springs) {
    s.show();
  }
  if (showParticles) {
    for (Particle p : particles) {
      p.show();
    }
  }
  if (showCloth) {
    beginShape();
    curveVertex(particles[0].pos.x, particles[0].pos.y);
    for (int i = 0; i < particles.length; i++) {
      curveVertex(particles[i].pos.x, particles[i].pos.y);
    }
    curveVertex(particles[particles.length - 1].pos.x, particles[particles.length - 1].pos.y);
    endShape();
  }
  for (Spring s : springs) {
    s.update();
  }
  for (Particle p : particles) {
    p.applyForce(gravity);
    p.update();
  }
  
  if (mousePressed) {
    particles[0].pos.set(mouseX, mouseY);
    particles[0].velocity.set(0, 0);
  }
}
//Jeffrey Andersen

class Particle {
  PVector pos;
  PVector velocity;
  PVector acceleration;
  float frictionMultiplier;
  float radius;
  float mass;
  
  Particle(PVector _pos, float _radius, float _frictionMultiplier) {
    pos = _pos;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    frictionMultiplier = _frictionMultiplier;
    radius = _radius;
    mass = 1;
  }
  
  public void applyForce(PVector force) {
    acceleration.add(force.copy().div(mass));
  }
  
  public void update() {
    velocity.add(acceleration);
    velocity.mult(frictionMultiplier);
    pos.add(velocity);
    acceleration.mult(0);
  }
  
  public void show() {
    circle(pos.x, pos.y, radius);
  }
}
//Jeffrey Andersen

class Spring {
  float springConstant;
  float restLength;
  Particle p1, p2;
  
  Spring(float _springConstant, float _restLength, Particle _particle1, Particle _particle2) {
    springConstant = _springConstant;
    restLength = _restLength;
    p1 = _particle1;
    p2 = _particle2;
  }
  
  public void update() {
    PVector force = PVector.sub(p2.pos, p1.pos);
    float displacement = force.mag() - restLength;
    force.normalize().mult(springConstant * displacement);
    p1.applyForce(force);
    force.mult(-1);
    p2.applyForce(force);
  }
  
  public void show() {
    line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
  }
}
  public void settings() {  size(1600, 1600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Springs" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
