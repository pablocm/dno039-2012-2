class Camera implements Runnable {
  Server server;
  PImage img;
  PImage buffer;
  
  Camera(Server server) {
    buffer = createImage(320, 240, ARGB); 
    //buffer.loadPixels(); 
    img = createImage(320, 240, ARGB);  
    this.server = server;
  }  

  void run() {
    while(true)
    {
      Client client = server.available();
      if(client != null)
      readImage(client);
    }
  }
  
  void readImage(Client thisClient) {
    byte[] data = new byte[320*240*4];

    if(thisClient.available() < 320*240*4) 
      return;
    
    thisClient.readBytes(data);
    //for(int in = 0; in < data.length; in+= 4) {
    //  buffer.pixels[in/4] = color(data[in] & 0xff, data[in+1] & 0xff, data[in+2] & 0xff, data[in+3] & 0xff);
    //}
    //buffer.updatePixels();  
    swapImages();
    
  }
  
  synchronized PImage getImage() {
    return img;   
  }
  
  synchronized void swapImages() {
    PImage tmp = img;
    img = buffer;
    buffer = tmp;    
  }
}
