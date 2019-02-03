TileSet tileSet;

void settings() {
  size(1280, 920);  
}

void setup() {
  background(0);
  frameRate(60);
  tileSet = new TileSet();
  tileSet.setSpeed(1);
}

void draw() {
  if (!tileSet.gameOver) {
    tileSet.update();
    background(0);
    tileSet.drawGUI();
    tileSet.drawTileSet();
    tileSet.drawFigure();
  } else {
    background(0);
    tileSet.drawGameOverScreen();  
  }
}

void keyPressed() {
  //Arrow left
  if (keyCode == 37) {
    tileSet.moveFigure(-1, 0);  
  }
  //Arrow right
  if (keyCode == 39) {
    tileSet.moveFigure(1, 0);  
  }
  //Arrow down
  if (keyCode == 40) {
    tileSet.hardDrop();  
  }
  //Arrow up
  if (keyCode == 38) {
    tileSet.rotateCurrent();  
  }
}

void keyReleased() {
  //Arrow down
  if (keyCode == 40) {
    tileSet.softDrop();  
  }  
}
