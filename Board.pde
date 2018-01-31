class Board {

  PImage blocks;
  private int blocksize = 30 ;
  private final int BOARDWIDTH = 10, BOARDHEIGHT = 20, BLOCKSPRITESIZE = 30;
  private int[][] board = new int[BOARDHEIGHT][BOARDWIDTH];


  private Shape[] possibleShapes = new Shape[7];
  private Shape currentShape; 

  private int score;
  private int POINTSPERLINE = 1;

  private boolean gameOver = false;
  private Overlay overlay;

  public Board(PImage sprite) {
    blocks = sprite;
    blocksize = width/BOARDWIDTH;
    intiShapes();

    setNextShape();
  }

  public void update() {
    checkLines();
    currentShape.update();
  }

  public void draw() {
    if (!gameOver) {
      update();
      currentShape.render();
    }

    //drawGrid();
    drawArrivedShapes();
  }

  private void drawGrid() {
    for (int i = 0; i <= BOARDHEIGHT; i++) {
      line(0, i * blocksize, BOARDWIDTH * blocksize, i * blocksize);
    }
    for (int j = 0; j <= BOARDWIDTH; j++) {
      line(j * blocksize, 0, j * blocksize, BOARDHEIGHT * blocksize);
    }
  }

  private void drawArrivedShapes() {
    for (int row = 0; row < board.length; row++) {
      for (int col = 0; col < board[row].length; col++) {
        if (board[row][col] != 0) {
          int colorIndex = board[row][col] -1;
          image(blocks.get(colorIndex * blocksize, 0, blocksize, blocksize), col * blocksize, row * blocksize);
        }
      }
    }
  }

  private void intiShapes() {
    possibleShapes[0] = new Shape(blocks.get(0, 0, BLOCKSPRITESIZE, BLOCKSPRITESIZE), new int [][] {
      {1, 1, 1, 1} //I-Shape
      }, this, 1);

    possibleShapes[1] = new Shape(blocks.get(BLOCKSPRITESIZE, 0, BLOCKSPRITESIZE, BLOCKSPRITESIZE), new int [][] {
      {1, 1, 0}, 
      {0, 1, 0}, 
      {0, 1, 1}//Z-Shape
      }, this, 2);

    possibleShapes[2] = new Shape(blocks.get(2 * BLOCKSPRITESIZE, 0, BLOCKSPRITESIZE, BLOCKSPRITESIZE), new int [][] {
      {0, 1, 1}, 
      {0, 1, 0}, 
      {1, 1, 0}//S-Shape
      }, this, 3);

    possibleShapes[3] = new Shape(blocks.get(3 * BLOCKSPRITESIZE, 0, BLOCKSPRITESIZE, BLOCKSPRITESIZE), new int [][] {
      {1, 1, 1}, 
      {0, 0, 1}//J-Shape
      }, this, 4);

    possibleShapes[4] = new Shape(blocks.get(4 * BLOCKSPRITESIZE, 0, BLOCKSPRITESIZE, BLOCKSPRITESIZE), new int [][] {
      {1, 1, 1}, 
      {1, 0, 0}//L-Shape
      }, this, 5);

    possibleShapes[5] = new Shape(blocks.get(5 * BLOCKSPRITESIZE, 0, BLOCKSPRITESIZE, BLOCKSPRITESIZE), new int [][] {
      {1, 1, 1}, 
      {0, 1, 0}//T-Shape
      }, this, 6);

    possibleShapes[6] = new Shape(blocks.get(6 * BLOCKSPRITESIZE, 0, BLOCKSPRITESIZE, BLOCKSPRITESIZE), new int [][] {
      {1, 1}, 
      {1, 1}//O-Shape
      }, this, 7);
  }

  public void setNextShape() {
    int index = (int)random(possibleShapes.length);
    currentShape = new Shape(possibleShapes[index].getBlock(), possibleShapes[index].getCoords(), this, index + 1);
  }

  private void checkLines() {

    ArrayList<int[]> newBoard = new ArrayList();

    for (int row = 0; row < board.length; row++) {
      int blockCounter = 0;
      for (int col = 0; col < board[row].length; col++) {
        if (board[row][col] > 0) {
          blockCounter++;
        }
      }
      if (blockCounter < BOARDWIDTH) {
        newBoard.add(board[row]);
      }
    }

    int deletedLines = board.length -newBoard.size();
    score += POINTSPERLINE * deletedLines;

    for (int i = 0; i < deletedLines; i++) {
      newBoard.add(0, new int[BOARDWIDTH]);
    }




    //write changes to board    
    for (int i = 0; i < board.length; i++) {
      board[i] = newBoard.get(i);
    }
  }

  public int getBlockSize() {
    return blocksize;
  }

  public int getBoardWidth() {
    return BOARDWIDTH;
  }

  public int getBoardHeight() {
    return BOARDHEIGHT;
  }

  public int[][] getMatrix() {
    return board;
  }

  public void setMatrix(int[][] board) {
    this.board = board;
  }
  
   public void setOverlay(Overlay overlay) {
    this.overlay = overlay;
  }
  
  public int getScore() {
    return score;
  }
  
  public Shape getCurrentShape() {
    return currentShape;
  }

  public void keyPressed(int key) {
    if (key == CODED) {
      if (keyCode == UP) {
        currentShape.rotate();
      } else if (keyCode == DOWN) {
        currentShape.moveDownFaster();
      } else if (keyCode == LEFT) {
        currentShape.setDeltaX(-1);
      } else if (keyCode == RIGHT) {
        currentShape.setDeltaX(+1);
      }
    }
  }

  public void keyReleased(int key) {
    if (key == CODED) {
      if (keyCode == DOWN) {
        currentShape.moveDownNormalSpeed();
      }
    }
  }

  public void endGame(boolean won) {
    if (won) {
      overlay.setText("Winner");
    } else {
      overlay.setText("Looser");
    }
    overlay.setVisible(true);
    gameOver = true;
  }

  public void startGame() {
    overlay.setVisible(false);
    board = new int[BOARDHEIGHT][BOARDWIDTH];
    score = 0;
    gameOver = false;
  }

  public void pauseGame() {
  }

  public void continueGame() {
  }

  public void stopGame() {
    gameOver = true;
  }
}