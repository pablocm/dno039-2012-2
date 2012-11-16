class CannonButton {
  int x, y, r, output;
  int pressed;
  color normal_color;
  color pressed_color;
  
  public CannonButton(int x, int y, int r, color c, int output) {
      this.x = x;
      this.y = y;
      this.r = r;
      this.normal_color = c;
      this.pressed_color = color(255,100,0);
      this.output = output;
  } 
  
  public boolean isInside(int x, int y) {
    return (this.x - x)*(this.x - x) +
     (this.y - y)*(this.y - y) <
       r*r;
  }
  
  public boolean isMouseInside(){
    return isInside(mouseX, mouseY);
  }
  
  public void draw() {
    if(pressed > 0)
    {
      pressed--;
      fill(pressed_color);
    }
    else
    {
      fill(normal_color);
    }
    ellipse(x,y,2*r,2*r); 
  }
  
  public void press() {
    pressed = 5;
    emit(""+output);
  }
}