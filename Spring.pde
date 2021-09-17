//Jeffrey Andersen

class Spring {
  float springConstant;
  float restLength;
  Particle p1, p2;
  
  Spring(float _springConstant, float _restLength, Particle _p1, Particle _p2) {
    springConstant = _springConstant;
    restLength = _restLength;
    p1 = _p1;
    p2 = _p2;
  }
  
  void update() {
    PVector force = PVector.sub(p2.pos, p1.pos);
    float displacement = force.mag() - restLength;
    force.setMag(springConstant * displacement);
    p1.applyForce(force);
    force.mult(-1);
    p2.applyForce(force);
  }
  
  void show() {
    line(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y);
  }
}
