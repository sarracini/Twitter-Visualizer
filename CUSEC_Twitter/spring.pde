///////////DO NOT TOUCH THIS CLASS THIS MAKES IT ALL SPRINGY///////////
class spring {

  particle particleA;
  particle particleB;
  float distance;
  float springiness;

  spring() {
    particleA=null;
    particleB=null;
  }

  void update() {
    if ((particleA == null) || (particleB == null)) {
      return;
    }
    PVector pta = particleA.pos;
    PVector ptb = particleB.pos;

    PVector distVector=new PVector(pta.x-ptb.x, pta.y-ptb.y, 0);
    float theirDistance = distVector.mag();
    float springForce = (springiness * (distance - theirDistance/2));
    distVector.normalize();
    PVector frcToAdd = new PVector(distVector.x * springForce, distVector.y * springForce, 0);

    particleA.addForce(frcToAdd.x, frcToAdd.y);
    particleB.addForce(-frcToAdd.x, -frcToAdd.y);
  }

  void draw() {
    if ((particleA == null) || (particleB == null)) {
      return;
    }
    stroke(200);
    line(particleA.pos.x, particleA.pos.y, particleB.pos.x, particleB.pos.y);
  }
}

