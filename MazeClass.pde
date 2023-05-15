public class Maze {
  private int width;  // Breite des Felds
  private int height;  // Höhe des Felds
  private float tilewidth;  // Breite des Feldteils
  private MazeTile[][] tiles;  // Feldteile als 2D-Array
  private int[][] generated;
  Point start;
  Point pointer;
  boolean fw = true;
  boolean finished = false;
  ArrayList<MazeTile> path = new ArrayList<MazeTile>();

  public Maze(int width, int height, float tilewidth) {
    this.width = width;
    this.height = height;
    this.tilewidth = tilewidth;
    tiles = new MazeTile[width][height];
    generated = new int[width][height];
    // Startpunkt bestimmen
    start = getStartPoint();
    pointer = start.copy();
    tiles[pointer.x][pointer.y] = new MazeTile(new Point(pointer.x, pointer.y));
    generated[pointer.x][pointer.y] = 1;
    tiles[start.x][start.y].changeColor(0, 0, 200);  // Startpunkt blau
    path.add(tiles[pointer.x][pointer.y]);
  }

  void generate() {
    // Get End Point
    if (finished) {
      println("finished");
      //println(tiles[start.x][start.y].getLongestWay(tiles).p.toString());
      return;
    }
    // Generating
    if (fw)
      goForwards();
    else
      goBackwards();
  }

  void goForwards() {
    // neues Teil erstellen
    Point newp = new Point(-1, -1);
    // Richtung anhand des derzeitigen Standorts ermitteln
    int direction = getRandomDirection(pointer, newp);
    // wenn kein Richtung frei ist geht generator rückwärts
    if (direction == -1) {
      fw = false;
      return;
    }

    tiles[pointer.x][pointer.y].directions[direction] = true;
    if (tiles[pointer.x][pointer.y].c == color(200, 0, 0))
      tiles[pointer.x][pointer.y].changeColor(200, 0, 0, 120);
    pointer = newp;
    tiles[pointer.x][pointer.y] = new MazeTile(new Point(pointer.x, pointer.y));
    tiles[pointer.x][pointer.y].directions[(direction + 2) % 4] = true;
    generated[pointer.x][pointer.y] = 1;
    tiles[pointer.x][pointer.y].changeColor(200, 0, 0);
    path.add(tiles[pointer.x][pointer.y]);
  }

  void goBackwards() {
    if (path.size() > 0)
      path.remove(path.size() - 1);
    if (path.size() == 0 && pointer.equals(start)) {
      println("finished");
      finished = true;
      return;
    }
    //pointer = path.get(path.size() - 1);
    MazeTile lastTile = path.get(path.size() - 1);
    if (lastTile.hasEmptyNeighbor())
      fw = true;
    tiles[pointer.x][pointer.y].changeColor(255, 255, 255);
    pointer = lastTile.p;
    if (!pointer.equals(start))
      tiles[pointer.x][pointer.y].changeColor(200, 0, 0);
  }

  private int getRandomDirection(Point p, Point newp) {
    int[] nums = new int[] { 0, 0, 0, 0};
    int dir;
    do {
      do {
        if (getSum(nums) == 4)
          return -1;
        dir = floor(random(4));
      } while (nums[dir] != 0);      
      if (dir == 0)  newp.set(new Point(p.x, p.y - 1));
      else if (dir == 1)  newp.set(new Point(p.x + 1, p.y));
      else if (dir == 2)  newp.set(new Point(p.x, p.y + 1));
      else if (dir == 3)  newp.set(new Point(p.x - 1, p.y));
      else throw new ArrayIndexOutOfBoundsException();
      nums[dir] = 1;
    } while (newp.outOfBounds(width, height) || generated[newp.x][newp.y] == 1);
    return dir;
  }

  private int getSum(int[] array) {
    int sum = 0;
    for (int i : array)
      sum += i;
    return sum;
  }

  private Point getStartPoint() {
    Point p;
    do {
      p = new Point(floor(random(width)), floor(random(height)));
    } while (!(p.x == 0 || p.x == width - 1) && !(p.y == 0 || p.y == height - 1));
    return p;
  }

  public void draw(int offset) {
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        if (tiles[x][y] != null) //|| generated[x][y] == 1
          tiles[x][y].draw(offset, tilewidth);
        else {
          stroke(0);
          fill(211);
          rect(offset + x * tilewidth, offset + y * tilewidth, tilewidth - 1, tilewidth - 1);
        }
      }
    }
  }
}
