float y = 0;
float vy = 0;  // y-velocity
void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  ellipse(100, y, 50, 50);
  y += 5;  // add gravity
  y += vy;  // add y-velocity
  vy *= .9;  // apply damping
}

void keyPressed() {
  if (key == ' ') {
    vy = -30;
  }
}
