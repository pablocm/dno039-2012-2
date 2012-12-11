import processing.net.*;

//Thread cameraThread;
Client cannonClient;
Camera cam;

CannonButton[] buttons;
CannonWheel cannonWheel;
ProgressBar progressBar;
ScoreBar score;
PImage backgroundImg;
PImage crosshairImg;
PImage bulletImg;
PImage gameOverImg;
boolean gameOver = false;

String cannon_ip = "127.0.0.1";
//String cannon_ip = "192.168.1.100";

void setup()
{
  cannonClient = new Client(this, cannon_ip, 9999);
  Client camClient = new Client(this, cannon_ip, 5555);
  
  cam = new Camera(camClient);
  
  size(1024,576); 
  //size(512,288);
  //size(896,504);  
  smooth();
  buttons = new CannonButton[1];
  color default_color = color(50,0,50);
  buttons[0] = new CannonButton(width/6, height*55/100, pixelX(80), color(0,100,0), 0);
  cannonWheel = new CannonWheel(pixelX(840), pixelY(317));
  progressBar = new ProgressBar(pixelX(100), pixelY(90), pixelX(170), pixelY(15));
  progressBar.setValue(100);
  score = new ScoreBar(width/2 - pixelX(256), height*90/100);
  
  backgroundImg = loadImage("data/base.png");
  crosshairImg = loadImage("data/crosshair.png");
  bulletImg = loadImage("data/bullet.png");
  gameOverImg = loadImage("data/smiley.png");
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
 return x*width/1024; 
}

int pixelY(int y) {
 return y*height/576; 
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
  //webcam
  image(cam.getImage(), width/2 - pixelX(160), height/2 - pixelY(120 +25),
        pixelX(320), pixelY(240));
  //target
  image(crosshairImg, width/2 - pixelX(160), height/2 - pixelY(200 +25), 
        pixelX(320), pixelY(400));

  //progreso carga bala
  if (progressBar.getPercentage() < 1) {
    progressBar.draw();
    progressBar.addValue(1);
  }
  else {
    image(bulletImg, pixelX(160), pixelY(50), pixelX(33), pixelY(96));
  }
  
  // perros muertos
  score.draw();
  
  //game over?
  if (gameOver)
    image(gameOverImg, width/2 - pixelX(250), height/2 - pixelY(250), 
      pixelX(500), pixelY(500));
}

void mousePressed() {
   cannonWheel.mousePressed(); 
}

void mouseReleased() {
   cannonWheel.mouseReleased(); 
}

// mensajes del server
void clientEvent(Client client) {
    if(client ==  cannonClient) {
      String msg = client.readString();
      
      // murio un perro
      if ("x\n".equals(msg))
        score.addValue(1);
      // game over
      else if ("g\n".equals(msg))
        gameOver = true;
    }
}
