import codeanticode.gsvideo.*;
import processing.net.*;

Server keyServer;
Server camServer;
GSCapture cam;
PImage img;
byte interesting = 10;

void setup() {
  size(320, 240);
  //img = loadImage("icon320x240.png");
  //img.loadPixels();
  
  camServer = new Server(this, 5555);
  keyServer = new Server(this, 9999);
  println("Server started");
  
  //webcam
  cam = new GSCapture(this, 160, 120, 10);
  cam.start();
  println("Webcam started");
}

int i = 0;
void draw() {
  
  // Get the next available client
  Client thisClient = keyServer.available();
  // If the client is not null, and says something, display what it said
  if (thisClient !=null) {
    readString(thisClient);
  }
  
  //image(img, 0, 0, 320, 240);
  //emit(img.pixels);
  
  if (cam.available() == true) {
    cam.read();
    image(cam, 0, 0, 320, 240);
    emit(cam.pixels);
  }
}

void readString(Client thisClient) {
  String whatClientSaid = thisClient.readStringUntil(interesting);
    if (whatClientSaid != null) {
      thisClient.clear();
      
      if(whatClientSaid.equals("-1\n"))
        println("UP");
      else if(whatClientSaid.equals("1\n"))
        println("DOWN");
      else if(whatClientSaid.equals("0\n"))
        println("BOOM!");
      
      //background((int)random(255));
    }
}

void emit(color[] data) {
 if (camServer != null) {
   try {
     for(int i = 0; i < data.length; i++) {
        byte r = (byte)((data[i] >> 16) & 0xff);
        byte g = (byte)((data[i] >> 8) & 0xff);
        byte b = (byte)((data[i] >> 0) & 0xff);
        //char a = (byte)((data[i] >> 24) & 0xff);
        camServer.write(r);
        camServer.write(g);
        camServer.write(b);
        //camServer.write(a);
     }
   }
   catch (NullPointerException e)
   { 
     println("Disconnected! EXCP");   
   }
 }
}

void serverEvent(Server s, Client c) {
  println("Client connected.");
}

void disconnectEvent(Client c) {
  camServer = null;
  println("Disconnected!");
}

void mouseClicked() {
  if (keyServer != null) {
    keyServer.write("X");
    println("X");
  }
}
