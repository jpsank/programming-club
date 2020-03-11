int score = 0;
boolean addedScore = false;

float y = 0;
float vy = 0;
float pipeX = 500;
float pipeGapY = 200;
float pipeGapSize = 250;
float angle = 0;


PImage sky;
PImage pipe;
PImage bird;

void setup() {
  size(500, 500, P3D);
  sky = loadImage("sky.png");
  bird = loadImage("bird.png");
  pipe = loadImage("pipe.png");
}
void draw() {
  image(sky, 0, 0);
  colorMode(HSB);
  fill(map(y, 0, 500, 0, 255),255,255);
  colorMode(RGB);
  
  float angleKeep = 0.75;
  angle = angleKeep * angle + (1 - angleKeep) * (vy / 20);
  
  pushMatrix();
  translate(100, y);
  rotate(angle);
  imageMode(CENTER);
  image(bird, 0, 0);
  imageMode(CORNER);
  popMatrix();
  
  vy++; 
  y += vy;
  vy *= 0.9;
  if(y > height) {
    exit();
  }
  if(y < 0) {
    exit();
  }
  fill(0, 255, 0);
  pushMatrix();
  scale(1, -1);
  image(pipe, pipeX, -(pipeGapY - pipeGapSize / 2), 50, pipe.height);
  popMatrix();
  
  image(pipe, pipeX, pipeGapY + pipeGapSize / 2, 50, pipe.height);
  
  pipeX -= 3;
  
  if(pipeX < -50) {
    pipeGapY = random(0, height);
    pipeGapSize = random(150, 275);
    pipeX = width;
    addedScore = false;
  }
  
  float HALF_SIZE = 25;
  float x = 100;
  
  if(x > pipeX - HALF_SIZE && x < pipeX + 50 + HALF_SIZE) {
    if(y + HALF_SIZE > pipeGapY + pipeGapSize / 2 || y - HALF_SIZE < pipeGapY - pipeGapSize / 2) {
      exit();
    }else if(addedScore == false) {
      score++;
      addedScore = true;
    }
  }
  fill(255, 0, 0);
  textSize(25);
  text(score, 15, 25);
}
void keyPressed() {
  if(key == ' ') {
    vy = - 15;
  }
}
