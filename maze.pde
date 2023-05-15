float b;  // Breite des Feldteils
int w = 30;  // Anzahl an Feldteilen

Maze maze;  // Maze

void setup() {
  size(700, 700);
  // Feldteilbreite an Fenster anpassen
  b = (width - 60) / float(w);
  maze = new Maze(w, w, b);
  // Fast Option
  //while (!maze.finished)
  //  maze.generate();
}

void draw() {
  background(211);
  // Visualization Option
  maze.generate();
  maze.draw(30);
}

void keyPressed() {
  maze = new Maze(w, w, b);
  // Fast Option
  //while (!maze.finished)
  //  maze.generate();
}
