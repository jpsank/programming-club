float y = 0;
float vy = 0;
float pipeX = 500;
float pipeGapY = 200;
float pipeGapSize = 250;
 
void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  fill(255, 255, 0);
  ellipse(100, y, 50, 50);
  y += 5;
  y += vy;
  vy *= 0.9;
  if(y > height) {
    y -= 5;
  }
  if(y < 0) {
    y = 5;
    vy = 0;
  }
  fill(0, 255, 0);
 
  rect(pipeX, 0, 50, pipeGapY - pipeGapSize / 2);
  rect(pipeX, pipeGapY + pipeGapSize / 2, 50, height);
 
  pipeX -= 3;
 
  if(pipeX < -50) {
    pipeGapY = random(0, height);
    pipeGapSize = random(150, 275);
    pipeX = width;
  }
}
void keyPressed() {
  if(key == ' ') {
    vy = - 15;
  }
}
