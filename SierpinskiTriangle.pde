public void setup()
{
  size(750, 750);
  background(0);
}
public void draw()
{
  sierpinski(0,0, width);
  float r = map(mouseX, 0, width, 0, 255);
  float g = map(mouseY, 0, height, 0, 255);
  fill(r, g, 0);
}
public void mouseDragged()//optional
{
  redraw();
}
public void sierpinski(int x, int y, int len) {
  if (len<=20) {
    triangle(x, y+height, x+(len/2), y-len+height, x+len, y+height);
  } else {
    sierpinski(x, y, len/2);

    sierpinski (x+len/2, y, len/2);

    sierpinski(x + len/4, y - len/2, len/2);
   

  }
}
