class Controls {
  Board board;
  PImage sprite;
  PVector[] buttons;
  boolean buttonPressFinished = true;

  public Controls(PImage spriteSheet, Board board) {
    this.sprite = spriteSheet.get(240, 30, 60, 60);
    this.board = board;

    buttons = new PVector[4];
    buttons[0] = new PVector(0, height - sprite.height);
    buttons[1] = new PVector((width/4), height - sprite.height);
    buttons[2] = new PVector(width/ 2, height - sprite.height);
    buttons[3] = new PVector((width/4) * 3, height - sprite.height);
  }

  public void draw() {
    for (int i = 0; i < buttons.length; i++) {
      pushMatrix();
      translate(buttons[i].x, buttons[i].y);
      translate(width/8, width/8);
      rotate(HALF_PI * i);
      translate(-width/8, -width/8);
      image(sprite, 0, 0, width/4, width/4);
      popMatrix();
    }
  }

  public void update() {
    println(buttonPressFinished);
  }

  void mouseReleased() {
    buttonPressFinished = true;
    board.getCurrentShape().moveDownNormalSpeed();
  }
  void mousePressed() {
    if (buttonPressFinished) {
      buttonPressFinished = false;
      for (int i = 0; i < buttons.length; i++) {
        if ( 
          mouseX > buttons[i].x
          && mouseX< buttons[i].x + sprite.width
          && mouseY > buttons[i].y
          && mouseY< buttons[i].y + sprite.height
          ) {

          switch(i) {
          case 3:
            board.getCurrentShape().rotate();
            break;
          case 2:
            board.getCurrentShape().setDeltaX(-1);
            break;
          case 0:
            board.getCurrentShape().setDeltaX(+1);
            break;
          case 1:
            board.getCurrentShape().moveDownFaster();
            break;
          }
        }
      }
    }
  }
}