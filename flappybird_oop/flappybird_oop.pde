
Game game;

// Images
PImage BIRD_IMG;
PImage GROUND_IMG;
PImage PIPE_IMG;


void setup() {
  size(600,600,P3D);
  
  // Load images
  PIPE_IMG = loadImage("pipe.png");
  GROUND_IMG = loadImage("ground.png");
  BIRD_IMG = loadImage("bird.png");
  
  // Create new game
  game = new Game();
}


void draw() {
  
  if (game.dead) {
    
  } else {
    background(200,220,255);
    
    game.update();
    
    game.display();
  }
}

void keyPressed() {
  if (key == ' ' || keyCode == UP) {
    if (game.dead) {
      game.newGame();
    } else {
      game.bird.jump();
    }
  }
}

void mousePressed() {
  game.bird.jump();
}
