int numParticles = 1000;
Particle[] particles;

void setup() {
  frameRate(144);
  size(1900, 900, P3D);
  particles = new Particle[numParticles];
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle(random(width), random(height), random(200), random(TWO_PI), random(1, 3));
  }
}

void draw() {
  background(0);

  for (Particle particle : particles) {
    particle.update();
    particle.display();
  }
}

void keyPressed() {
  // Reset particles if space key is pressed
  if (key == ' ') {
    for (Particle particle : particles) {
      particle.reset();
    }
  }
}

void mousePressed() {
  for (Particle particle : particles) {
    float distance = dist(mouseX, mouseY, particle.x, particle.y);
    if (distance < 100) { // Adjust the radius of influence 
      float forceStrength = map(distance, 0, 100, 1, 0); // Inverse relationship
      float forceX = (particle.x - mouseX) * forceStrength;
      float forceY = (particle.y - mouseY) * forceStrength;
      particle.applyForce(forceX, forceY);
    }
  }
}

class Particle {
  float x, y, z;
  float angle;
  float speed;
  float radius;
  float xForce, yForce;

  Particle(float x, float y, float z, float angle, float speed) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.angle = angle;
    this.speed = speed;
    this.radius = random(2, 5);
    this.xForce = 0;
    this.yForce = 0;
  }

  void update() {
    float noiseValue = noise(x * 0.005, y * 0.005, frameCount * 0.005) * 10;
    float r = radius + noiseValue;

    x += cos(angle) * speed + xForce;
    y += sin(angle) * speed + yForce;
    z += noiseValue;

    if (x < 0 || x > width || y < 0 || y > height) {
      reset();
    }

    angle += noise(x * 0.01, y * 0.01, frameCount * 0.01) - 0.5;
  }

  void display() {
    float col1 = map(z, 0, 200, 50, 100);
    float col2 = map(z, 0, 200, 0, 50);
    float col3 = map(z, 0, 200, 100, 200);
    fill(col1, col2, col3, 150);
    noStroke();
    ellipse(x, y, radius * 2, radius * 2);
  }

  void applyForce(float forceX, float forceY) {
    xForce += forceX;
    yForce += forceY;
  }

  void reset() {
    x = width / 2;
    y = height / 2;
    z = random(200);
    xForce = 0;
    yForce = 0;
  }
}
