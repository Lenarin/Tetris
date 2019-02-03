class Figure {
   PVector[] parts;
   color figureColor;
   PVector startingPos;
   int offsetX;
   int offsetY;
   
   Figure(int size, color newColor) {
     figureColor = newColor;
     parts = new PVector[size];
     startingPos = new PVector(5, 0);
     
     for (int i = 0; i < size; i++) {
       parts[i] = new PVector();  
     }
   }
   
   void move(int x, int y) {
     for (int i = 0; i < parts.length; i++) {
       parts[i].x += x;
       parts[i].y += y;
     }
   }
   
   void rotate() {
     PVector rotation;
     int offsetX;
     int offsetY;
     for (int i = 1; i < parts.length; i++) {
       offsetX = (int)(parts[i].x - parts[0].x); 
       offsetY = (int)(parts[i].y - parts[0].y); 
       rotation = new PVector(0, 0);
     
     
       if (offsetX == 0) {
         //rotation = new PVector(offsetY, -offsetY);
         rotation.x += offsetY;
         rotation.y += -offsetY;
       } else if (offsetY == 0) {
         //rotation = new PVector(-offsetX, -offsetX);
         rotation.x += -offsetX;
         rotation.y += -offsetX;
       } else if (offsetX * offsetY > 0) {
         //rotation = new PVector(0, -offsetX - offsetY); 
         rotation.y += -offsetX - offsetY;
       } else if (offsetX * offsetY < 0) {
         //rotation = new PVector(-offsetX + offsetY, 0);
         rotation.x += -offsetX + offsetY;
       }
       
       parts[i].x += rotation.x;
       parts[i].y += rotation.y;
     }
     
     offsetX = 0;
     for (int i = 0; i < parts.length; i++) {
        if (parts[i].x < 0) {
          offsetX += 1;  
        } else if (parts[i].x >= 10) {
          offsetX -= 1; 
        }
     }
     
     if (offsetX != 0) {
       for (int i = 0; i < parts.length; i++) {
         parts[i].x += offsetX;  
       }
     }
   }
   
   void setPart(int idx, int x, int y) {
     parts[idx].x = startingPos.x + x;
     parts[idx].y = startingPos.y + y;
   }
   
   Figure copy() {
     Figure result = new Figure(parts.length, figureColor);
     
     for (int i = 0; i < parts.length; i++) {
       result.parts[i].x = parts[i].x;
       result.parts[i].y = parts[i].y;
     }
     
     return result;
   }
}
