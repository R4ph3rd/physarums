class Agent {

  PVector pos, initPos, flowPos;
  float heading, initHeading ;
  float step, nextStep ;
  float sensorAngle ;
  int sensorDist ;
  color col;
  boolean recycle ;

  Agent(PVector pos, float heading, color col) {
    this.pos = pos.copy() ;
    this.heading = random(TWO_PI);
    this.col = col;
    this.sensorAngle = random(PI/6, PI/10);
    this.sensorDist = 50 ;
    this.step = random(2, 5);
    this.nextStep = this.step ;
    
    this.initPos = pos.copy();
    this.initHeading = heading;
    this.recycle = false;
    this.flowPos = pos.copy();
  }

  void update() {
    if (recycle) {
      pos.set(flowPos.x , flowPos.y);   
      recycle = !recycle ;
    } else {
      headingSensors(this);
      pos.add(new PVector(cos(heading), sin(heading)).mult(nextStep));
    }
    

    if ( this.outOfBound() ) {
      pos.set(initPos);
      heading = initHeading;
    }   
  }

  void render() {
    stroke(this.col);
    point(pos.x, pos.y);
  }

  boolean outOfBound() {
    return ( pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height );
  }
}
