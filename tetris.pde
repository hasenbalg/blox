Board board;
Overlay overlay;
Controls controls;
PImage spriteSheet;
color backgroundColor;

void setup() {
  size(300, 600);
  spriteSheet = loadImage("spritesheet.png");
  board = new Board(spriteSheet);
  board.stopGame();
  overlay = new Overlay(spriteSheet, board);
  overlay.setText("Press Start");
  overlay.setVisible(true);
  board.setOverlay(overlay);

  backgroundColor = spriteSheet.pixels[spriteSheet.width*30 + 1];

  controls = new Controls(spriteSheet, board);
}

void draw() {
  background(backgroundColor);

  board.draw();

  overlay.update();
  overlay.draw();

  controls.update();
  controls.draw();
}

void keyPressed() {
  board.keyPressed(key);
}
void keyReleased() {
  board.keyReleased(key);
}

void mousePressed() {
  controls.mousePressed();
}
void mouseReleased() {
  controls.mouseReleased();
}