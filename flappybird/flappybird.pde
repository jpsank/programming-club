
float GRAVITY = 12;
float PIPE_RADIUS = 30;
float BIRD_RADIUS = 15;
float GAP = 80;
float VEL_DAMPENING = 0.94;
float GROUND_HEIGHT = 150;

int score;
boolean hoppedThrough;  // has the bird hopped through the current pipe
boolean dead;
float speed;  // per second

// Images
PImage birdImg;
PImage groundImg;
PImage pipeImg;


// Bird
float birdX = 100;
float birdY;
float velY;  // per second
float angle;

// Pipe
float pipeX;
float gapY;

// Ground
float groundY;
float groundX;


void resetPipe() {
  pipeX = width+PIPE_RADIUS;
  gapY = 100+random(groundY-200);
  hoppedThrough = false;
}

void restart() {
  score = 0;
  dead = false;
  speed = 8;
  
  birdY = 100;
  velY = 0;
  
  angle = 0;
  
  resetPipe();
}

void hopThrough() {
  score += 1;
  hoppedThrough = true;
  speed += .1;
}


void setup() {
  size(600, 600, P3D);
  groundX = width;
  groundY = height-GROUND_HEIGHT;
  
  pipeImg = loadImage("pipe.png");
  groundImg = loadImage("ground.png");
  birdImg = loadImage("bird.png");
  
  restart();
}


void draw() {
  
  if (dead) {
    
  } else {
    background(200,220,255);
    
    // Update ground
    groundX -= speed;
    if (groundX <= 0)
      groundX = width;
    
    // Update pipes
    pipeX -= speed;
    if (pipeX <= -PIPE_RADIUS)
      resetPipe();
    
    // Update bird
    birdY += GRAVITY;
    birdY += velY;
    velY *= VEL_DAMPENING;
    
    angle += .03;
    
    if (!hoppedThrough && birdX > pipeX) {
      hopThrough();
    }
    
    float radius = PIPE_RADIUS+BIRD_RADIUS;
    float upper = gapY-GAP;
    float lower = gapY+GAP;
    if (birdX > pipeX-radius && birdX < pipeX+radius) {
      if (birdY < upper+BIRD_RADIUS || birdY > lower-BIRD_RADIUS) {
        dead = true;
      }
    }
    
    if (birdY+BIRD_RADIUS > groundY) {
      dead = true;
    }
    
    noStroke();
    
    // Draw pipes
    //fill(0,255,0);
    //rect(pipeX-PIPE_RADIUS, 0, PIPE_RADIUS*2, gapY-GAP);
    //rect(pipeX-PIPE_RADIUS, gapY+GAP, PIPE_RADIUS*2, height-gapY-GAP);
    imageMode(CORNER);
    pushMatrix();
    translate(pipeX-PIPE_RADIUS, gapY-GAP);
    scale(1, -1);
    image(pipeImg, 0, 0);
    popMatrix();
    image(pipeImg, pipeX-PIPE_RADIUS, gapY+GAP);
    
    // Draw ground
    //fill(0,255,0);
    //rect(0,groundY, width,GROUND_HEIGHT);
    imageMode(CORNER);
    image(groundImg, groundX-width, groundY);
    image(groundImg, groundX, groundY);
    
    // Draw bird
    //fill(255,0,0);
    //ellipse(birdX, birdY, BIRD_RADIUS*2, BIRD_RADIUS*2);
    imageMode(CENTER);
    pushMatrix();
    translate(birdX, birdY);
    rotate(angle);
    image(birdImg, 0, 0);
    popMatrix();
    
    // Draw score
    fill(0);
    textSize(32);
    text(score, 20, 100);
  }
}

void jump() {
  velY = -30;
  angle = -PI/4;
}

void keyPressed() {
  if (key == ' ' || keyCode == UP) {
    if (dead) {
      restart();
    } else {
      jump();
    }
  }
}

void mousePressed() {
  jump();
}
