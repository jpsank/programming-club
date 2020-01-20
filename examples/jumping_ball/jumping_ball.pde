float y = 0;
void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  ellipse(100, y, 50, 50);
  y += 5;
}

void keyPressed() {
  if (key == ' ') {
    y -= 100;
  }
}
