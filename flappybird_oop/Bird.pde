
class Bird {
  
  static final float RAD = 15;
  static final float GRAVITY = 12;
  static final float VEL_DAMPENING = 0.94;
  
  // Bird properties
  float x = 100;
  float y;
  float velY;
  float angle;
  
  Bird() {
    y = 100;  // make sure bird is well above the ground
    velY = 0;  // make sure bird has no y-velocity yet
    angle = 0;  // reset bird rotation
  }
  
  /*
  Set bird's y-velocity and angle to jumping state
  */
  void jump() {
    velY = -30;
    angle = -PI/4;
  }
  
  
  void update() {
    y += GRAVITY;  // move down by GRAVITY
    y += velY;  // add velocity to y
    velY *= VEL_DAMPENING;  // dampen velocity
    angle += .025;  // rotate bird clockwise
  }
  
  /*
  Draw bird
  */
  void display() {
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(angle);
    image(BIRD_IMG, 0, 0);
    popMatrix();
  }
  
}
