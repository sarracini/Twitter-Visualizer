float boxTweetX;
PFont pTweets;

class particle {
  PVector pos=new PVector();
  PVector vel=new PVector();
  PVector frc=new PVector();   // frc is also know as acceleration (newton says "f=ma")
  boolean  bFixed;
  float damping;
  String thisIsTheTweet;

  particle() {
    setInitialCondition(0, 0, 0, 0);
    damping = 0.05f;
    bFixed = false;
  }

  void resetForce() {
    // we reset the forces every frame
    frc.set(0, 0, 0);
  }

  //------------------------------------------------------------
  void addForce(float x, float y) {
    // add in a fPVectororce in X and Y for this frame.
    frc.x = frc.x + x;
    frc.y = frc.y + y;
  }

  //------------------------------------------------------------
  void addRepulsionForce(float x, float y, float radius, float scale) {

    // ----------- (1) make a vector of where this position is: 

    PVector posOfForce=new PVector();
    posOfForce.set(x, y, 0);

    // ----------- (2) calculate the difference & length 

    PVector diff	= new PVector();
    diff.set(pos.x - posOfForce.x, pos.y - posOfForce.y, 0);
    float length	= diff.mag();

    // ----------- (3) check close enough

    boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    // ----------- (4) if so, update force

      if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x + diff.x * scale * pct;
      frc.y = frc.y + diff.y * scale * pct;
    }
  }

  //------------------------------------------------------------
  void addAttractionForce(float x, float y, float radius, float scale) {

    // ----------- (1) make a vector of where this position is: 

    PVector posOfForce=new PVector();
    posOfForce.set(x, y, 0);

    // ----------- (2) calculate the difference & length 

    PVector diff	= new PVector();
    diff.set(pos.x - posOfForce.x, pos.y - posOfForce.y, 0);
    float length	= diff.mag();

    // ----------- (3) check close enough

    boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    // ----------- (4) if so, update force

      if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x - diff.x * scale * pct;
      frc.y = frc.y - diff.y * scale * pct;
    }
  }

  //------------------------------------------------------------
  void addRepulsionForce(particle p, float radius, float scale) {

    // ----------- (1) make a vector of where this particle p is: 
    PVector posOfForce=new PVector();
    posOfForce.set(p.pos.x, p.pos.y, 0);

    // ----------- (2) calculate the difference & length 

    PVector diff	= new PVector();
    diff.set(pos.x - posOfForce.x, pos.y - posOfForce.y, 0);
    float length	= diff.mag();

    // ----------- (3) check close enough

    boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    // ----------- (4) if so, update force

      if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x + diff.x * scale * pct;
      frc.y = frc.y + diff.y * scale * pct;
      p.frc.x = p.frc.x - diff.x * scale * pct;
      p.frc.y = p.frc.y - diff.y * scale * pct;
    }
  }

  //------------------------------------------------------------
  void addAttractionForce(particle p, float radius, float scale) {

    // ----------- (1) make a vector of where this particle p is: 
    PVector posOfForce=new PVector();
    posOfForce.set(p.pos.x, p.pos.y, 0);

    // ----------- (2) calculate the difference & length 

    PVector diff	= new PVector();
    diff.set(pos.x - posOfForce.x, pos.y - posOfForce.y, 0);
    float length	= diff.mag();

    // ----------- (3) check close enough

    boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    // ----------- (4) if so, update force

      if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x - diff.x * scale * pct;
      frc.y = frc.y - diff.y * scale * pct;
      p.frc.x = p.frc.x + diff.x * scale * pct;
      p.frc.y = p.frc.y + diff.y * scale * pct;
    }
  }

  //------------------------------------------------------------
  void addClockwiseForce(particle p, float radius, float scale) {

    // ----------- (1) make a vector of where this particle p is: 
    PVector posOfForce =new PVector();
    posOfForce.set(p.pos.x, p.pos.y, 0);

    // ----------- (2) calculate the difference & length 

    PVector diff	= new PVector();
    diff.set(pos.x - posOfForce.x, pos.y - posOfForce.y, 0);
    float length	= diff.mag();

    // ----------- (3) check close enough

    boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    // ----------- (4) if so, update force

      if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x - diff.y * scale * pct;
      frc.y = frc.y + diff.x * scale * pct;
      p.frc.x = p.frc.x + diff.y * scale * pct;
      p.frc.y = p.frc.y - diff.x * scale * pct;
    }
  }

  //------------------------------------------------------------
  void addCounterClockwiseForce(particle p, float radius, float scale) {

    // ----------- (1) make a vector of where this particle p is: 
    PVector posOfForce=new PVector();
    posOfForce.set(p.pos.x, p.pos.y, 0);

    // ----------- (2) calculate the difference & length 

    PVector diff	= new PVector();
    diff.set(pos.x - posOfForce.x, pos.y - posOfForce.y, 0);
    float length	= diff.mag();

    // ----------- (3) check close enough

    boolean bAmCloseEnough = true;
    if (radius > 0) {
      if (length > radius) {
        bAmCloseEnough = false;
      }
    }

    // ----------- (4) if so, update force

      if (bAmCloseEnough == true) {
      float pct = 1 - (length / radius);  // stronger on the inside
      diff.normalize();
      frc.x = frc.x + diff.y * scale * pct;
      frc.y = frc.y - diff.x * scale * pct;
      p.frc.x = p.frc.x - diff.y * scale * pct;
      p.frc.y = p.frc.y + diff.x * scale * pct;
    }
  }


  //------------------------------------------------------------
  void addDampingForce() {

    // the usual way to write this is  vel *= 0.99
    // basically, subtract some part of the velocity 
    // damping is a force operating in the oposite direction of the 
    // velocity vector

    frc.x = frc.x - vel.x * damping;
    frc.y = frc.y - vel.y * damping;
  }

  //------------------------------------------------------------
  void setInitialCondition(float px, float py, float vx, float vy) {
    pos.set(px, py, 0);
    vel.set(vx, vy, 0);
    thisIsTheTweet = " ";
  }

  //------------------------------------------------------------
  void update() {	
    if (bFixed == false) {
      vel.x = vel.x + frc.x;
      vel.y = vel.y + frc.y;
      pos.x = pos.x + vel.x;
      pos.y = pos.y + vel.y;
    }
  }

  //------------------------------------------------------------
  void draw() {
    //fill(255);
    //draw a dot if there is no thisIsTheTweet, otherwise draw the thisIsTheTweet
    pTweets = createFont("Raleway Heavy", 22);
    textFont(pTweets);
    
    if (thisIsTheTweet== " ") {
      ellipse(pos.x, pos.y, 2, 2);
    }
    else {
      ellipse(pos.x, pos.y, 6, 6);
      //float xOffset = textWidth(thisIsTheTweet)/2;
      
      if (thisIsTheTweet.length() >= 60) {
        boxTweetX = textWidth(thisIsTheTweet) / 2;
      }
      else {
        boxTweetX = 250;
      }
      
      textAlign(CENTER);
      text(thisIsTheTweet, pos.x - boxTweetX/2, pos.y - 30, boxTweetX + 20, 150);
      //println(thisIsTheTweet + ": " + thisIsTheTweet.length());
    }
  }


  //------------------------------------------------------------
  void bounceOffWalls() {

    // sometimes it makes sense to damped, when we hit
    boolean bDampedOnCollision = true;
    boolean bDidICollide = false;

    //////////// WALL LIMITATIONS ///////////////////////
    float minx = 0;
    float miny = 0;
    float maxx = width;
    float maxy = height;

    if (pos.x > maxx) {
      pos.x = maxx; // move to the edge, (important!)
      vel.x *= -1;
      bDidICollide = true;
    } 
    else if (pos.x < minx) {
      pos.x = minx; // move to the edge, (important!)
      vel.x *= -1;
      bDidICollide = true;
    }
    if (pos.y > maxy) {
      pos.y = maxy; // move to the edge, (important!)
      vel.y *= -1;
      bDidICollide = true;
    } 
    else if (pos.y < miny) {
      pos.y = miny; // move to the edge, (important!)
      vel.y *= -1;
      bDidICollide = true;
    }
    if (bDidICollide == true && bDampedOnCollision == true) {
      vel.x *= 0.3;
      vel.y *= 0.3;
    }
  }
}

