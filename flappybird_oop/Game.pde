
class Game {
  
  int score;
  boolean hoppedThrough;  // has the bird hopped through the current pipe
  boolean dead;
  float speed;  // how fast pipes move
  
  Bird bird;
  Pipe pipe;
  Ground ground;
  
  Game() {
    newGame();
  }
  
  /*
  Initialize a new game
  */
  void newGame() {
    score = 0;  // reset score to zero
    dead = false;  // not dead anymore
    speed = 8;
    
    ground = new Ground();
    
    bird = new Bird();
    
    // create pipe obstacle
    pipe = new Pipe();
    resetPipe();
  }
  
  /*
  Create new pair of pipes with random gapY
  */
  void resetPipe() {
    pipe.x = width+Pipe.RAD;
    pipe.gapY = 100+random(ground.y-200);
    hoppedThrough = false;
  }
  
  /*
  Add 1 to score when bird hops through the gap
  */
  void hopThrough() {
    score += 1;
    hoppedThrough = true;
    speed += .1;  // increase speed as the player gets more points
  }
  
  
  void update() {
    ground.move(speed);
    
    pipe.move(speed);
    if (pipe.x <= -Pipe.RAD) // When pipe moves off the screen to the left, reset it to the other side of the screen
      resetPipe();
    
    bird.update();
    
    // Add point when the bird gets through the gap
    if (!hoppedThrough && bird.x > pipe.x) {
      hopThrough();
    }
    
    // Bird dies if it hits the pipe
    float radius = Pipe.RAD + Bird.RAD;
    float upper = pipe.gapY - Pipe.GAP;
    float lower = pipe.gapY + Pipe.GAP;
    if (bird.x > pipe.x - radius && bird.x < pipe.x + radius) {
      if (bird.y < upper + Bird.RAD || bird.y > lower - Bird.RAD) {
        dead = true;
      }
    }
    
    // Bird dies if it hits the ground
    if (bird.y+Bird.RAD > ground.y) {
      dead = true;
    }
    
  }
  
  
  void display() {
    // Draw pipes
    pipe.display();
    
    // Draw ground
    ground.display();
    
    // Draw bird
    bird.display();
    
    // Draw score
    fill(0);
    textSize(32);
    text(score, 20, 100);
  }
  
}
