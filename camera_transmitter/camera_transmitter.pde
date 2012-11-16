import processing.net.*;
Server server;

void setup() {
  size(200,200);
  server = new Server(this, 5204);
}

void draw()
{
  Client client = server.available();
  if(client != null)
  {
    String input = client.readString();
    if(input != null)
    {
      println(input);     
    }
  }
}

void serverEvent(Server server, Client client) {
 println("New connection from "+client.ip()); 
}
    
