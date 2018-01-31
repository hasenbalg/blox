Board board;

void setup() {
  size(300, 600);
  board = new Board();
}

void draw() {
  background(222);
  board.draw();
}

void keyPressed() {
  board.keyPressed(key);
}
void keyReleased() {
  board.keyReleased(key);
}