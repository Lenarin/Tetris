class FigureDict {
  Figure[] figures;
  
  FigureDict(int offsetX, int offsetY) {
    figures = new Figure[7];
    
    //Figure I
    figures[0] = new Figure(4, #08F9FF);
    figures[0].setPart(2, 0, 0);
    figures[0].setPart(1, 0, 1);
    figures[0].setPart(0, 0, 2);
    figures[0].setPart(3, 0, 3);
    
    //Figure J
    figures[1] = new Figure(4, #0017FC);
    figures[1].setPart(2, 0, 0);
    figures[1].setPart(1, 0, 1);
    figures[1].setPart(0, 0, 2);
    figures[1].setPart(3, -1, 2);
    
    //Figure L
    figures[2] = new Figure(4, #FCA900);
    figures[2].setPart(2, 0, 0);
    figures[2].setPart(1, 0, 1);
    figures[2].setPart(0, 0, 2);
    figures[2].setPart(3, 1, 2);
    
    //Figure O
    figures[3] = new Figure(4, #FCA900);
    figures[3].setPart(0, 0, 0);
    figures[3].setPart(1, 0, 1);
    figures[3].setPart(2, 1, 0);
    figures[3].setPart(3, 1, 1);
    
    //Figure S
    figures[4] = new Figure(4, #00FF2C);
    figures[4].setPart(0, 0, 0);
    figures[4].setPart(1, 0, 1);
    figures[4].setPart(2, 1, 0);
    figures[4].setPart(3, -1, 1);
    
    //Figure T
    figures[5] = new Figure(4, #E000FF);
    figures[5].setPart(0, 0, 0);
    figures[5].setPart(1, 1, 0);
    figures[5].setPart(2, -1, 0);
    figures[5].setPart(3, 0, 1);
    
    //Figure Z
    figures[6] = new Figure(4, #FF0000);
    figures[6].setPart(0, 0, 0);
    figures[6].setPart(1, -1, 0);
    figures[6].setPart(2, 0, 1);
    figures[6].setPart(3, 1, 1);
  }
  
  Figure copy(int idx) {
    Figure result = figures[idx].copy();
    return result;
  }
  
  Figure getRandom() {
    int rand = floor(random(7));
    Figure result = copy(rand);
    return result;
  }
}
