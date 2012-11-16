import processing.net.*;

Thread cameraThread;
Client cannonClient;
Camera cam;

CannonButton[] buttons;
CannonWheel cannonWheel;

void setup()
{
  cam = new Camera(new Server(this, 5203));
  cameraThread = new Thread(cam);
  cameraThread.start();
  
  //cannonClient = new Client(this, "127.0.0.1", 5204);
  size(1024,576); 
  smooth();
  buttons = new CannonButton[1];
  color default_color = color(50,0,50);
  buttons[0] = new CannonButton(width/6, height/2, 50, color(0,100,0), 0);
  cannonWheel = new CannonWheel(5*width/6, height/2);
}

void emit(String output) {
 //cannonClient.write(output); 
}

int pixelX(int x) {
 return x*1024/width; 
}

int pixelY(int y) {
 return y*576/height; 
}

void mouseClicked() {
 for(int i = 0 ; i < buttons.length ; i++)
    if(buttons[i].isMouseInside())
      buttons[i].press();
}

void draw()
{ 
  background(255);
  for(int i = 0 ; i < buttons.length ; i++)
    buttons[i].draw(); 
  cannonWheel.draw();
  //image(cam.getImage(), width/2 - pixelX(160), height/2 - pixelY(120));
}

void mousePressed() {
   cannonWheel.mousePressed(); 
}

void mouseReleased() {
   cannonWheel.mouseReleased(); 
}
