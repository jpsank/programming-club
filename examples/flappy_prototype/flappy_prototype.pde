
// Let's make these hyperparameters
float birdX = 100;  // the x-position of the bird (constant)
float birdRadius = 25;  // the radius of the bird circle
float pipeWidth = 20;  // the width of the pipe
float gap = 80;  // the width of the gap between the two pipes

float jumpForce = 20;  // the velocity of a jump/flap




float y = 0;
float vy = 0;  // y-velocity

// you want pipes with a gap in the middle
float pipeX;
float gapY;

// you want the ground to be at a certain Y
float groundY;

// there will only be one pair of pipes on screen at a time.
// the pipes will move left across the screen, until they go off; then, they will reset
// to the right side.
// This function resets the pipes.
void resetPipe() {
  pipeX = width;
  gapY = random(height);
}

void setup() {
  size(500, 500);
  
  // initialize the ground Y at a certain height
  groundY = height-100; // 100 pixels from the bottom of the screen
  
}
void draw() {
  background(255);
  
  // This updates the pipes
  pipeX -= 4;  // move pipes across the screen to the left
  if (pipeX < 0) // if the pipe goes off the left side of the screen,
    resetPipe(); // reset it
  
  
  // This updates the bird
  y += 5;  // add gravity
  y += vy;  // add y-velocity
  vy *= .9;  // apply damping
  
  // Now to kill the bird when it hits the pipe
  // First, let's define some variables
  float combinedRadius = birdRadius+pipeWidth/2;  // The combined distance from center of bird to center of pipe on impact
  float upperGapY = gapY-gap;  // the y of the top of the gap (bottom of top pipe)
  float lowerGapY = gapY+gap;  // the y of the bottom of the gap (top of the bottom pipe)
  
  // If bird's x coordinate is within collision radius
  if (birdX > pipeX-combinedRadius && birdX < pipeX+combinedRadius) {
    // And if bird's y coordinate is within collision radius,
    if (y < upperGapY+birdRadius || y > lowerGapY-birdRadius) {
      exit();  // GAME OVER
    }
  }
  
  
  // Draw the pipes
  stroke(0, 255, 0);  // set the color of drawing to green (0 red, 255 green, 0 blue)
  strokeWeight(pipeWidth);  // set the width/thickness of line to 20
  // Draw two vertical lines at x=pipeX that represent the pipes
  line(pipeX, 0, pipeX, gapY-gap);  // a line going from y=0 to 80 pixels above the gapY
  line(pipeX, height, pipeX, gapY+gap);  // line going from the bottom of screen to 80 pixels below the gapY
  
  // Draw the bird
  // Let's style the bird
  noStroke(); // no outline for bird
  fill(255, 0, 0); // fill bird with red color (255 red, 0 green, 0 blue)
  ellipse(birdX, y, birdRadius*2, birdRadius*2);
  
}

void keyPressed() {
  if (key == ' ' || keyCode == UP) {
    vy = -jumpForce;
  }
}
