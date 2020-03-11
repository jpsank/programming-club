
// Static variables
float PIPE_WIDTH = 50;
float BIRD_RADIUS = 20;
float pipeGapSize = 200;

PImage sky;
PImage pipe;
PImage bird;


// Nonstatic variables

int score = 0;
boolean hoppedThrough = false;  // has bird hopped through the pipes

float birdX = 100;
float y = 0;
float vy = 0;
float pipeX = 500;
float pipeGapY = 200;


void setup() {
  size(500, 500, P3D);
  // Load images
  sky = loadImage("sky.png");
  bird = loadImage("bird.png");
  pipe = loadImage("pipe.png");
}

void draw() {
  
  // --------------- LOGIC ---------------
  
  // Update bird
  vy += 1;  // gravity
  y += vy;  // add velocity to y
  vy *= 0.9;  // apply damping
  if(y > height) {
    exit();
  }
  if(y < 0) {
    y = 0;
  }
  
  // Move pipes
  pipeX -= 3;
  
  // Reset pipes
  if(pipeX < -PIPE_WIDTH) {
    pipeGapY = random(0, height);
    pipeX = width;
    hoppedThrough = false;
  }
  
  // Check for pipe/bird collision
  float topY = pipeGapY - pipeGapSize / 2;  // top of gap
  float bottomY = pipeGapY + pipeGapSize / 2;  // bottom of gap
  
  if(birdX > pipeX - BIRD_RADIUS && birdX < pipeX + PIPE_WIDTH + BIRD_RADIUS) {
    if(y > bottomY - BIRD_RADIUS || y < topY + BIRD_RADIUS) {
      exit();
    }
  }
  
  // If bird got through pipe, add score
  if (birdX > pipeX + PIPE_WIDTH && !hoppedThrough) {
    score++;
    hoppedThrough = true;
  }
  
  // --------------- DISPLAY ---------------
  
  // Draw background
  image(sky, 0, 0);
  
  // Draw bird
  float angle = vy/20;
  imageMode(CENTER);
  pushMatrix();
  translate(birdX, y);
  rotate(angle);
  image(bird, 0, 0);
  popMatrix();
  
  // Draw pipes
  fill(0, 255, 0);
  imageMode(CORNER);
  pushMatrix();
  scale(1, -1);
  image(pipe, pipeX, -topY, 50, pipe.height);
  popMatrix();
  image(pipe, pipeX, bottomY, 50, pipe.height);
  
  // Draw score
  fill(255, 0, 0);
  textSize(25);
  text(score, 15, 25);
}
void keyPressed() {
  if (key == ' ' || keyCode == UP) {
    vy = -15;
  }
}
