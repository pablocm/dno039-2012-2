class Camera {
  Client client;
  PImage buffer;
  
  Camera(Client client) {
    buffer = createImage(160, 120, RGB); 
    this.client = client;
  }
  
  byte[] data = new byte[160*120*3];
  
  void readImage(Client thisClient) {
    if(thisClient.available() < 160*120*3)
      return;
    
    thisClient.readBytes(data);
    for(int in = 0; in < data.length; in+= 3) {
      buffer.pixels[in/3] = color(data[in] & 0xff, data[in+1] & 0xff, data[in+2] & 0xff /*,data[in+3] & 0xff*/);
    }
    buffer.updatePixels();  
    
    while(thisClient.available() >= 160*120*3) {
      thisClient.readBytes(data);
    }
  }
  
  PImage getImage() {
    return buffer;
  }
}
