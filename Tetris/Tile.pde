class Tile {
  int size;
  PVector pos;
  color tileColor;
  boolean occupied;
  
  Tile(color newColor) {
    size = 40;
    pos = new PVector(0, 0);
    tileColor = newColor;
    occupied = false;
  }
  
  void drawTile() {
    fill(tileColor);
    stroke(0);
    rect(pos.x, pos.y, size, size);
  }
  
  void drawTileAsGUI(color newColor, int x, int y) {
    fill(newColor);
    stroke(0);
    rect(x * size + 834, y * size + 200, size, size);
  }
  
  void drawTile(color newColor) {
    fill(newColor);
    stroke(0);
    rect(pos.x, pos.y, size, size);
  }
  
  void setColor(color newColor) {
    tileColor = newColor;  
  }
  
  void setPos(int x, int y) {
    pos = new PVector(x, y);  
  }
  
  Tile copy() {
    Tile result = new Tile(tileColor);
    result.size = size;
    result.pos = pos;
    result.occupied = occupied;
    return result;
  }
}
