import processing.net.*;

//Thread cameraThread;
Client cannonClient;
Camera cam;

CannonButton[] buttons;
CannonWheel cannonWheel;
ProgressBar progressBar;
PImage backgroundImg;
PImage crosshairImg;
PImage bulletImg;
PImage dogsImg;

String cannon_ip = "146.155.107.21";
//String cannon_ip = "192.168.1.100";

void setup()
{
  cannonClient = new Client(this, cannon_ip, 9999);
  Client camClient = new Client(this, cannon_ip, 5555);
  
  cam = new Camera(camClient);
  
  size(1024,576); 
  smooth();
  buttons = new CannonButton[1];
  color default_color = color(50,0,50);
  buttons[0] = new CannonButton(width/6, height*55/100, 80, color(0,100,0), 0);
  cannonWheel = new CannonWheel(width*82/100, height*55/100);
  progressBar = new ProgressBar(pixelX(100), pixelY(90), pixelX(170), pixelY(15));
  progressBar.setValue(100);
  
  backgroundImg = loadImage("data/base.png");
  crosshairImg = loadImage("data/crosshair.png");
  bulletImg = loadImage("data/bullet.png");
  dogsImg = loadImage("data/perros.png");
}

void emit(String output) {
  // Si se dispara, reiniciar progressBar
  if ("0\n".equals(output) && progressBar.getPercentage() == 1)
  {
    progressBar.setValue(0);
    if(cannonClient != null) {
      cannonClient.write(output);
    }
  }
  // otros inputs enviarlos siempre
  else {
    if(cannonClient != null) {
      cannonClient.write(output);
    }
  }
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
  // obtener imagen webcam
  Client client = cam.client;
  if(client != null)
    cam.readImage(client);
  
  //background(255);
  image(backgroundImg, 0, 0, pixelX(1024), pixelY(576));
  
  for(int i = 0 ; i < buttons.length ; i++)
    buttons[i].draw(); 
  cannonWheel.draw();
  image(cam.getImage(), width/2 - pixelX(160), height/2 - pixelY(120 +25),
        320, 240);
  image(crosshairImg, width/2 - pixelX(160), height/2 - pixelY(200 +25), 
        320, 400);

  //temporal:
  if (progressBar.getPercentage() < 1) {
    progressBar.draw();
    progressBar.addValue(1);
  }
  else {
    image(bulletImg, pixelX(160), pixelY(50), pixelX(33), pixelY(96));
  }
  //image(dogsImg, width/2 - pixelX(256), height*90/100, pixelX(512), pixelY(27));
}

void mousePressed() {
   cannonWheel.mousePressed(); 
}

void mouseReleased() {
   cannonWheel.mouseReleased(); 
}

void clientEvent(Client client) {
    if(client ==  cannonClient) {
      String msg = client.readString();
      if(msg != null)
        println("Client dijo " + msg);
    }
}
