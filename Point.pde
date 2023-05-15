public class Point {
  int x;
  int y;

  public Point(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public Point copy() {
    return new Point(x, y);
  }

  public boolean outOfBounds(int width, int height) {
    if (x < 0 || x >= width || y < 0 || y >= height)
      return true;
    return false;
  }

  public void set(Point p) {
    x = p.x;
    y = p.y;
  }

  public String toString() {
    return "[" + x + ", " + y + "]";
  }

  public boolean equals(Point p) {
    if (x == p.x && y == p.y)
      return true;
    return false;
  }
}
