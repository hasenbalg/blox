class Overlay {
  protected boolean isVisible;
  String text = "XXXXXX";
  Board board;

  PImage sprite;
  PVector textPos, buttonPos;
  
  PFont font;

  public Overlay(PImage _sprite, Board board) {
    this.board = board;
    this.sprite = _sprite.get(0, 35, 80, 32);
    buttonPos = new PVector(width/2 - sprite.width/2, height/2 - 100);


    buttonPos = new PVector(width/2 - sprite.width/2, height/2);
    
    font =  loadFont("Slabo27px-Regular.vlw");
    textFont(font);
  }

  public void draw() {
    textAlign(RIGHT);
    textSize(32);
    text(board.getScore(), width, 32);


    if (!isVisible) {
      return;
    }
    textAlign(CENTER);
    textSize(52);

    text(text, width/2, 100);
    image(sprite, buttonPos.x, buttonPos.y);
  }

  public void update() {
    if (isVisible 
      && mouseX > buttonPos.x
      && mouseX< buttonPos.x + sprite.width
      && mouseY > buttonPos.y
      && mouseY< buttonPos.y + sprite.height
      && mousePressed) {

      if (text == "Looser") {
        board.startGame();
      } else if (text == "Winner") {
      } else if (text == "Pause") {
      } else {
        board.startGame();
      }
    }
  }

  public void setVisible(boolean isVisible) {
    this.isVisible = isVisible;
  }

  public void setText(String text) {
    this.text = text;
  }
}