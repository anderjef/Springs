//Jeffrey Andersen
//started 02/28/2021
//inspiration: https://www.youtube.com/watch?v=Rr-5HiXquhw

float springConstant = 0.5;
float radius = 10;
float frictionMultiplier = 0.985;
PVector gravity = new PVector(0, 0.7);
int numSprings = 20;
float restLength = 0.01;
boolean showParticles = false;
boolean showCloth = false;

Particle[] particles = new Particle[numSprings + 1];
Spring[] springs = new Spring[numSprings];

void setup() {
  size(1600, 1600);
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

void draw() {
  background(0);
  for (int i = 0; i < numSprings; i++) {
    springs[i].show();
  }
  if (showParticles) {
    for (int i = 0; i < particles.length; i++) {
      particles[i].show();
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
  for (int i = 0; i < numSprings; i++) {
    springs[i].update();
  }
  for (int i = 0; i < particles.length; i++) {
    particles[i].applyForce(gravity);
    particles[i].update();
  }
  
  if (mousePressed) {
    particles[0].pos.set(mouseX, mouseY);
    particles[0].velocity.set(0, 0);
  }
}
