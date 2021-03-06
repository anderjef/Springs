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
    circle(pos.x, pos.y, radius);
  }
}
