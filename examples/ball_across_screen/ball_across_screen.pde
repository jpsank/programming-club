float x = 0;
void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  ellipse(x, 250, 50, 50);
  x = x + 5;
}
