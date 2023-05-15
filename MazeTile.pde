public class MazeTile {
  private boolean[] directions;  // Die 4 Himmelsrichtungen
  private color c = color(255, 255, 255);  // Farbe des Felds
  private Point p;  // Koordinaten im Feld

  public MazeTile(Point p) {
    this.p = p;
    this.directions = new boolean[] {false, false, false, false};
  }

  public MazeTile(Point p, color c) {
    this.p = p;
    this.directions = new boolean[] {false, false, false, false};
    this.c = c;
  }

  public void draw(int offset, float width) {
    float x = offset + p.x * width;
    float y = offset + p.y * width;
    // Feld
    stroke(c);
    fill(c);
    rect(x, y, width - 1, width - 1);
    stroke(0);
    // Ränder
    if (!directions[0])  //oben
      line(x, y, x + width - 1, y);
    if (!directions[1])  //rechts
      line(x + width - 1, y, x + width - 1, y + width - 1);
    if (!directions[2])  //unten
      line(x, y + width - 1, x + width - 1, y + width - 1);
    if (!directions[3])  //links
      line(x, y, x, y + width - 1);
  }

  public void changeColor(int r, int g, int b) {
    c = color(r, g, b);
  }

  public void changeColor(int r, int g, int b, int a) {
    c = color(r, g, b, a);
  }

  public void changeColor(color c) {
    this.c = c;
  }

  public boolean hasEmptyNeighbor() {
    return directions[0] | directions[1] | directions[2] | directions[3];
  }

  public MazeTile getMazeTileWithDirection(MazeTile[][] field, int direction) {
    MazeTile m = null;
    if (direction == 0)  m = field[p.x][p.y - 1];
    else if (direction == 1)  m = field[p.x + 1][p.y];
    else if (direction == 2)  m = field[p.x][p.y + 1];
    else if (direction == 3)  m = field[p.x - 1][p.y];
    return m;
  }

  public MazeTile getLongestWay(MazeTile[][] field) {
    int longestWayDirection = -1;
    int longestWay = getMazeTileWithDirection(field, 0).getLength(field);

    for (int i = 1; i < 4; i++) {
      int tmp = getMazeTileWithDirection(field, i).getLength(field);
      if (longestWay > tmp) {
        longestWayDirection = i - 1;
      } else {
        longestWay = tmp;
        longestWayDirection = i;
      }
    }

    if (longestWayDirection == -1)
      return this;
    return getMazeTileWithDirection(field, longestWayDirection).getLongestWay(field);
  }

  public int getLength(MazeTile[][] field) {
    int length = 0;    
    
    for (int i = 0; i < 4; i++) {
      MazeTile m = getMazeTileWithDirection(field, i);
      if (m != null)
        length = max(length, m.getLength(field));
    }
    
    return ++length;
  }
}
