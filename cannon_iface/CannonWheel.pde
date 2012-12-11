class CannonWheel {
 int x, y;
 float handleAngle;
 float previousHandleAngle;
 int wheelRadius, wheelWeight, handleLength;
 int handleRadius;
 color wheelColor, handleColor;
 boolean pressed;
 PImage wheelImg;
 
 CannonWheel(int x, int y) {
   this.x = x;
   this.y = y;
   this.wheelRadius = 100;
   this.handleAngle = this.previousHandleAngle = 0;
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
     this.handleAngle = atan2((mouseY-y),(mouseX-x));
     float diff = (this.handleAngle - this.previousHandleAngle);
     
     // enviar inputs al girar > 45° la rueda
     if(diff < -PI/4 || diff > PI/4)
     {
       this.previousHandleAngle = this.handleAngle;
       
       if(diff > 0)
        emit("1\n");
       else if(diff < 0)
        emit("-1\n");
     }
   }
   
   stroke(wheelColor);
   noFill();
   
   // dibujar sprite del timon
   pushMatrix();
   translate(x, y);
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
