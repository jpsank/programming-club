
float GRAVITY = 12;
float PIPE_RADIUS = 30;
float BIRD_RADIUS = 15;
float GAP = 80;
float VEL_DAMPENING = 0.94;
float GROUND_HEIGHT = 150;


int score;
boolean hoppedThrough;  // has the bird hopped through the current pipe
boolean dead;
float speed;  // how fast pipes move

// Images
PImage birdImg;
PImage groundImg;
PImage pipeImg;


// Bird
float birdX = 100;
float birdY;
float velY;
float angle;  // rotation of bird

// Pipe
float pipeX;
float gapY;  // y value of the center of the gap

// Ground
float groundY;
float groundX;  // for ground scrolling


/*
Create new pair of pipes with random gapY
*/
void resetPipe() {
  pipeX = width+PIPE_RADIUS;
  gapY = 100+random(groundY-200);
  hoppedThrough = false;
}

/*
Initialize a new game
*/
void newGame() {
  score = 0;  // reset score to zero
  dead = false;  // not dead anymore
  speed = 8;
  
  birdY = 100;  // make sure bird is well above the ground
  velY = 0;  // make sure bird has no y-velocity yet
  
  angle = 0;  // reset bird rotation
  
  resetPipe();  // create pipe obstacle
}

/*
Add 1 to score when bird hops through the gap
*/
void hopThrough() {
  score += 1;
  hoppedThrough = true;
  speed += .1;  // increase speed as the player gets more points
}


void setup() {
  size(600, 600, P3D);
  // Initialize ground x and y
  groundX = width;
  groundY = height-GROUND_HEIGHT;
  
  // Load images
  pipeImg = loadImage("pipe.png");
  groundImg = loadImage("ground.png");
  birdImg = loadImage("bird.png");
  
  // Create new game
  newGame();
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
    if (pipeX <= -PIPE_RADIUS) // When pipe moves off the screen to the left, reset it to the other side of the screen
      resetPipe();
    
    // Update bird
    birdY += GRAVITY;  // move down by GRAVITY
    birdY += velY;  // add velocity to y
    velY *= VEL_DAMPENING;  // dampen velocity
    angle += .025;  // rotate bird clockwise
    
    // Add point when the bird gets through the gap
    if (!hoppedThrough && birdX > pipeX) {
      hopThrough();
    }
    
    // Bird dies if it hits the pipe
    float radius = PIPE_RADIUS+BIRD_RADIUS;
    float upper = gapY-GAP;
    float lower = gapY+GAP;
    if (birdX > pipeX-radius && birdX < pipeX+radius) {
      if (birdY < upper+BIRD_RADIUS || birdY > lower-BIRD_RADIUS) {
        dead = true;
      }
    }
    
    // Bird dies if it hits the ground
    if (birdY+BIRD_RADIUS > groundY) {
      dead = true;
    }
    
    // Draw pipes
    imageMode(CORNER);
    pushMatrix();
    translate(pipeX-PIPE_RADIUS, gapY-GAP);
    scale(1, -1);
    image(pipeImg, 0, 0);
    popMatrix();
    image(pipeImg, pipeX-PIPE_RADIUS, gapY+GAP);
    
    // Draw ground
    imageMode(CORNER);
    image(groundImg, groundX-width, groundY);
    image(groundImg, groundX, groundY);
    
    // Draw bird
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

/*
Set bird's y-velocity and angle to jumping state
*/
void jump() {
  velY = -30;
  angle = -PI/4;
}

void keyPressed() {
  if (key == ' ' || keyCode == UP) {
    if (dead) {
      newGame();
    } else {
      jump();
    }
  }
}

void mousePressed() {
  jump();
}
