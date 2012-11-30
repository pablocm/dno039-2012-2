class CannonWheel {
 int x, y;
 float handleAngle;
 int wheelRadius, wheelWeight, handleLength;
 int handleRadius;
 color wheelColor, handleColor;
 boolean pressed;
 PImage wheelImg;
 
 CannonWheel(int x, int y) {
   this.x = x;
   this.y = y;
   this.wheelRadius = 100;
   this.handleAngle = 0;
   this.handleRadius = 50;
   
   wheelImg = loadImage("data/rueda.png");
 }
 
 void mousePressed() {
   if( (mouseX - handleX())*(mouseX - handleX()) +
       (mouseY - handleY())*(mouseY - handleY()) <
       handleRadius*handleRadius)
     pressed = true;
 }
 
 void mouseReleased() {
   pressed = false; 
 }
 

 
 int handleX() {
   return (int) (cos(handleAngle)*wheelRadius + x);
 }
 
 int handleY() {
   return (int) (sin(handleAngle)*wheelRadius + y);   
 }
 
 void draw()
 {
   if(pressed) {
     float newHandleAngle = atan2((mouseY-y),(mouseX-x));
     float diff = (newHandleAngle-handleAngle);
     if(diff < 3 && diff > -3)
     {
        for(int i = 0 ; i < abs(diff)*1000 ; i++)
        {
         if(diff > 0)
          emit("1\n");
         else if(diff < 0)
          emit("-1\n"); 
        }
     }
     handleAngle = newHandleAngle;
   }
   
   stroke(wheelColor);
   noFill();
   
   // dibujar sprite del timon
   pushMatrix();
   translate(pixelX(x), pixelY(y));
   rotate(handleAngle + PI/4);  //desfasado para acomodar img
   image(wheelImg, 
         - pixelX(wheelRadius),
         - pixelY(wheelRadius),
         pixelX(wheelRadius*2), pixelY(wheelRadius*2));
   popMatrix();
   
   // dibujar elipses de referencia (debug)
   //ellipse(pixelX(x),pixelY(y),pixelX(wheelRadius*2), pixelY(wheelRadius*2));  
   //ellipse(pixelX(handleX()), pixelY(handleY()), handleRadius,handleRadius);
   
 }
}
