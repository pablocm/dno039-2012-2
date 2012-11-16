class Camera implements Runnable {
  Client client;
  PImage img;
  PImage buffer;
  
  Camera(Client client) {
    buffer = createImage(160, 120, RGB); 
    //buffer.loadPixels(); 
    img = createImage(160, 120, RGB);  
    this.client = client;
  }

  void run() {
    while(true)
    {
      if(client != null)
        readImage(client);
    }
  }
  
  // dejemos esto afuera para no maltratar al garbage collector
  byte[] data = new byte[160*120*3];
  
  void readImage(Client thisClient) {
    if(thisClient.available() < 160*120*3)
      return;
    
    thisClient.readBytes(data);
    for(int in = 0; in < data.length; in+= 3) {
      buffer.pixels[in/3] = color(data[in] & 0xff, data[in+1] & 0xff, data[in+2] & 0xff /*,data[in+3] & 0xff*/);
    }
    
    buffer.updatePixels();  
    //swapImages();
    
    // si queda mucho por leer, descartemos data
    while(thisClient.available() >= 160*120*3) {
      thisClient.readBytes(data);
      println("Descartando frame!");
    }
  }
  
  synchronized PImage getImage() {
    //return img;   
    return buffer;
  }
  
  synchronized void swapImages() {
    PImage tmp = img;
    img = buffer;
    buffer = tmp;    
  }
}
