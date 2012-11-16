/**
 * Getting Started with Capture.
 * 
 * GSVideo version by Andres Colubri. 
 * 
 * Reading and displaying an image from an attached Capture device. 
 */ 
import codeanticode.gsvideo.*;
import processing.net.*;

Client socket;
GSCapture cam;
PImage img;

void setup() {
  size(640, 480);
  img = loadImage("icon320x240.png");
  img.loadPixels();
  
  println("Connecting...");
  socket = new Client(this, "127.0.0.1", 5203);
}

void draw() {
  emit(img.pixels);
}

void emit(color[] data) {
 if (socket != null) {
   try {
     for(int i = 0; i < data.length; i++) {
        int a = ((data[i] >> 24) & 0xff);
        int r = ((data[i] >> 16) & 0xff);
        int g = ((data[i] >> 8) & 0xff);
        int b = ((data[i] >> 0) & 0xff);
        socket.write(r);
        socket.write(g);
        socket.write(b);
        socket.write(a);
     }
   }
   catch (NullPointerException e)
   { 
     println("Disconnected! EXCP");   
   }
 }
 else
   println("Not connected.");
}

void disconnectEvent(Client c) {
  socket = null;
  println("Disconnected!");
}
