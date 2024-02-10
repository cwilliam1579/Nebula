int ballX, ballY, ballSpeedX = 5, ballSpeedY = 3;
int paddleWidth = 10, paddleHeight = 80;
int paddle1Y, paddle2Y;
int paddleSpeed = 5;

boolean wKey, sKey, upKey, downKey;

void setup() {
  size(600, 400);
  reset();
}

void draw() {
  background(0);
  
  // Draw paddles
  fill(255);
  rect(10, paddle1Y, paddleWidth, paddleHeight);
  rect(width - paddleWidth - 10, paddle2Y, paddleWidth, paddleHeight);
  
  // Draw ball
  fill(255);
  ellipse(ballX, ballY, 20, 20);
  
  // Move paddles
  movePaddle();
  
  // Move ball
  ballX += ballSpeedX;
  ballY += ballSpeedY;
  
  // Check collision with walls
  if (ballY < 0 || ballY > height) {
    ballSpeedY *= -1;
  }
  
  // Check collision with paddles
  if (ballX <= 20 && ballY >= paddle1Y && ballY <= paddle1Y + paddleHeight) {
    ballSpeedX *= -1;
  }
  
  if (ballX >= width - 20 - paddleWidth && ballY >= paddle2Y && ballY <= paddle2Y + paddleHeight) {
    ballSpeedX *= -1;
  }
  
  // Check if ball is out of bounds
  if (ballX < 0 || ballX > width) {
    reset();
  }
}

void movePaddle() {
  // Move paddle 1 with keys 'W' and 'S'
  if (wKey && paddle1Y > 0) {
    paddle1Y -= paddleSpeed;
  } 
  if (sKey && paddle1Y < height - paddleHeight) {
    paddle1Y += paddleSpeed;
  }
  
  // Move paddle 2 with arrow keys
  if (upKey && paddle2Y > 0) {
    paddle2Y -= paddleSpeed;
  } 
  if (downKey && paddle2Y < height - paddleHeight) {
    paddle2Y += paddleSpeed;
  }
}

void keyPressed() {
  if (key == 'w') {
    wKey = true;
  } else if (key == 's') {
    sKey = true;
  }
  
  if (keyCode == UP) {
    upKey = true;
  } else if (keyCode == DOWN) {
    downKey = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    wKey = false;
  } else if (key == 's') {
    sKey = false;
  }
  
  if (keyCode == UP) {
    upKey = false;
  } else if (keyCode == DOWN) {
    downKey = false;
  }
}

void reset() {
  ballX = width / 2;
  ballY = height / 2;
  paddle1Y = height / 2 - paddleHeight / 2;
  paddle2Y = height / 2 - paddleHeight / 2;
  ballSpeedX *= random(1) > 0.5 ? 1 : -1;
  ballSpeedY *= random(1) > 0.5 ? 1 : -1;
}
