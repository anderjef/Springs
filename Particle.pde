//Jeffrey Andersen

class Particle {
  PVector pos; //position
  PVector velocity;
  PVector acceleration;
  float frictionMultiplier;
  float radius;
  float mass = 1;
  
  Particle(PVector _pos, float _radius, float _frictionMultiplier) {
    pos = _pos;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    frictionMultiplier = _frictionMultiplier;
    radius = _radius;
  }
  
  void applyForce(PVector force) {
    acceleration.add(force.copy().div(mass));
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.mult(frictionMultiplier);
    pos.add(velocity);
    acceleration.mult(0);
  }
  
  void show() {
    circle(pos.x, pos.y, radius * 2);
  }
}
