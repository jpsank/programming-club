
class Ground {
  
  static final float HEIGHT = 150;
  
  float x;  // for ground scrolling
  float y;
  
  Ground() {
    x = width;
    y = height-HEIGHT;
  }
  
  void move(float speed) {
    x -= speed;
    if (x <= 0)
      x = width;
  }
  
  void display() {
    imageMode(CORNER);
    image(GROUND_IMG, x-width, y);
    image(GROUND_IMG, x, y);
  }
  
}
