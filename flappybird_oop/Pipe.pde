
class Pipe {
  
  static final float RAD = 30;
  static final float GAP = 80;
  
  float x;
  float gapY;
  
  Pipe() {
  }
  
  /*
  Move pipes
  */
  void move(float speed) {
    x -= speed;
  }
  
  /*
  Draw pipes
  */
  void display() {
    imageMode(CORNER);
    pushMatrix();
    translate(x-RAD, gapY-GAP);
    scale(1, -1);
    image(PIPE_IMG, 0, 0);
    popMatrix();
    image(PIPE_IMG, x-RAD, gapY+GAP);
  }
  
}
