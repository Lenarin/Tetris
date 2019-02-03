class TileSet {
  int sizeX;
  int sizeY;
  Tile[][] tileMatrix;
  FigureDict figures;
  Figure currentFigure;
  Figure nextFigure;
  Figure rotationFigure;
  int offsetX;
  int offsetY;
  int tileSize = 40;
  float maxSpeed;
  float speed;
  float delta;
  int oldMills;
  int score;
  boolean gameOver;
  
  TileSet() {
    offsetX = 440;
    offsetY = 40;
    sizeX = 10;
    sizeY = 20;
    tileMatrix = new Tile[sizeX][sizeY];
    figures = new FigureDict(offsetX, offsetY);
    speed = 10;
    delta = speed;
    score = 0;
    gameOver = false;
    oldMills = millis();
    nextFigure = figures.getRandom();
    
    
    for (int i = 0; i < sizeX; i++) {
      for (int j = 0; j < sizeY; j++) {
        tileMatrix[i][j] = new Tile(255);
        tileMatrix[i][j].size = tileSize;
        tileMatrix[i][j].setPos(offsetX + i * tileSize, offsetY + j * tileSize);
      }
    }
    getNewCurrent();
  }
  
  void setSpeed(float seconds) {
    maxSpeed = seconds * 1000;
    speed = maxSpeed;
  }
  
  void getNewCurrent() {
    boolean locked = false;
    for (int i = 0; i < nextFigure.parts.length; i++) {
      if (tileMatrix[(int)nextFigure.parts[i].x][(int)nextFigure.parts[i].y].occupied) {
        locked = true;  
      }
    }
    
    if (locked) {
      gameOver = true;  
    } else {
      currentFigure = nextFigure;
      nextFigure = figures.getRandom();
    }
  }
  
  void drawGameOverScreen() {
    fill(255);
    text("Game Over", 600, 200);
    text("score: " + score, 600, 230);
    text("Press R to restart", 600, 260);
  }
  
  boolean isClearPath(int x, int y) {
    for (int i = 0; i < currentFigure.parts.length; i++) {
      if ((currentFigure.parts[i].x + x >= sizeX) || (currentFigure.parts[i].y + y >= sizeY) || (currentFigure.parts[i].x + x < 0)
      || (tileMatrix[(int)currentFigure.parts[i].x + x][(int)currentFigure.parts[i].y + y].occupied)) {
        return false;  
      }
    }
    return true;
  }
  
  void rotateCurrent() {
    rotationFigure = currentFigure.copy();
    rotationFigure.rotate();
    
    boolean rotationCheck = true;
    for (int i = 0; i < rotationFigure.parts.length; i++) {
      if (((int)rotationFigure.parts[i].y < 0) || (tileMatrix[(int)rotationFigure.parts[i].x][(int)rotationFigure.parts[i].y].occupied)) {
        rotationCheck = false;
      }
    }
    if (rotationCheck) {
      currentFigure = rotationFigure;  
    }
  }
  
  void hardDrop() {
    speed = 0.2;  
  }
  
  void softDrop() {
    speed = maxSpeed;  
  }
  
  void drawFigure() {
    for (int i = 0; i < currentFigure.parts.length; i++) {
      tileMatrix[(int)currentFigure.parts[i].x][(int)currentFigure.parts[i].y].drawTile(currentFigure.figureColor);
    }
  }
  
  boolean moveFigure(int x, int y) {
    if (isClearPath(x, y)) {
      currentFigure.move(x, y);    
    } else {
      return false;  
    }
    
    return true;
  }
  
  void drawTileSet() {
    for (int i = 0; i < sizeX; i++) {
      for (int j = 0; j < sizeY; j++) {
        tileMatrix[i][j].drawTile(); 
      }
    }
  }
  
  void gravity() {
    boolean moved = moveFigure(0, 1);
    
    if (!moved) {
      for (int i = 0; i < currentFigure.parts.length; i++) {
        tileMatrix[(int)currentFigure.parts[i].x][(int)currentFigure.parts[i].y].occupied = true;
        tileMatrix[(int)currentFigure.parts[i].x][(int)currentFigure.parts[i].y].setColor(currentFigure.figureColor);
      }
      
      checkLines();
      getNewCurrent();
    }
  }
  
  void checkLines() {
    int linesCleared = 0;
    int firstClearedLine = 0;
    for (int j = 19; j >= 0; j--) {
      boolean stacked = true;
      for (int i = 0; i < sizeX; i++) {
        if (!tileMatrix[i][j].occupied) {
          stacked = false;  
        }
      }
      
      if (stacked) {
        if (linesCleared == 0) {
          firstClearedLine = j;    
        }
        linesCleared++;
        for (int i = 0; i < sizeX; i++) {
          tileMatrix[i][j].occupied = false;
          tileMatrix[i][j].tileColor = 255;
        }
      }
    }
    
    if (linesCleared > 0) {
      if (linesCleared == 1) {
        score += 200;  
      } else if (linesCleared == 2) {
        score += 500;  
      } else if (linesCleared == 3) {
        score += 1200;  
      } else if (linesCleared == 4) {
        score += 2000;  
      }
      
      for (int j = firstClearedLine; j > linesCleared; j--) {
        for (int i = 0; i < sizeX; i++) {
          tileMatrix[i][j].tileColor = tileMatrix[i][j - linesCleared].tileColor;
          tileMatrix[i][j].occupied = tileMatrix[i][j - linesCleared].occupied;
        }
      }
      
      for (int j = linesCleared - 1; j >= 0; j--) {
        for (int i = 0; i < sizeX; i++) {
          tileMatrix[i][j].tileColor = 255;
          tileMatrix[i][j].occupied = false;
        }
      }
    }
  }
  
  void drawGUI() {
    textSize(32);
    fill(255);
    text("TETRIS", 1000, 80);
    
    rect(953, 160, 200, 200);
    
    textSize(16);
    fill(255);
    text("Next Figure", 1005, 150);
    text("score: " + score, 1005, 130);
    for (int i = 0; i < nextFigure.parts.length; i++) {
      tileMatrix[0][0].drawTileAsGUI(nextFigure.figureColor, (int)nextFigure.parts[i].x, (int)nextFigure.parts[i].y);
    }
  }
  
  void update() {
    delta = millis() - oldMills;
    if (delta >= speed) {
      oldMills = millis();
      
      gravity();
    }
  }
}
