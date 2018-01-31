class Shape {
  PImage block;
  int[][] coords;
  private Board board;
  int deltaX = 0, x, y, colorIndex;

  private long lastTime;
  private final float NORMALSPEED = 600, FASTSPEED = 60;
  private float currentSpeed;

  private boolean arrived = false;

  public Shape(PImage block, int[][]coords, Board board, int colorIndex) {
    this.block = block;
    this.coords = coords;
    this.board = board;
        this.colorIndex = colorIndex;


    x = 3; 
    y = 0;
    currentSpeed = NORMALSPEED;
  }


  public void update() {
    moveOnYAxis();
    moveOnXAxis();

    if (arrived) {
       //check for game end
      if(y == 1){
        board.endGame(false);
      }
      
      
      int[][] newBoard = board.getMatrix();
      for (int row = 0; row < coords.length; row++) {
        for (int col = 0; col < coords[row].length; col++) {
          if (coords[row][col] != 0) {
             newBoard[y + row][x + col] = colorIndex;             
          }
        }
      }
      board.setMatrix(newBoard);
      //for (int row = 0; row < board.getMatrix().length; row++) {
      //  for (int col = 0; col < board.getMatrix()[row].length; col++) {
      //    print(board.getMatrix()[row][col]);
      //  }
      //  println();
      //}

      board.setNextShape();
      
     
    }
  }

  public void render() {
    for (int row = 0; row < coords.length; row++) {
      for (int col = 0; col < coords[row].length; col++) {
        if (coords[row][col] != 0) {
          image(block, (col + x)* board.getBlockSize(), (row + y) * board.getBlockSize(),board.getBlockSize(),board.getBlockSize() );
        }
      }
    }
  }

  public void setDeltaX(int deltaX) {
    this.deltaX = deltaX;
  }

  private void moveOnXAxis() {
     //collides left or right?
    for (int row = 0; row < coords.length; row++) {
        for (int col = 0; col < coords[row].length; col++) {
          if (coords[row][col] != 0) {
            int nextXStep = x + deltaX + col;
             if(nextXStep < 0 || nextXStep >= board.getBoardWidth() || board.getMatrix()[y + row][nextXStep] > 0){
               deltaX = 0;
               return;
             }           
          }
        }
      }
    
    
    if (!arrived) {
      x += deltaX;
    }
    //dont go out left
    while (x + coords[0].length > board.getBoardWidth()) {
      x--;
    }
    //dont go out right
    while (x  < 0) {
      x++;
    }
    
   
    
    
    deltaX = 0;
  }

  private void moveOnYAxis() {
    if (y < board.getBoardHeight() - coords.length) {//stop at the bottom
      //if other piece is there
      for (int row = 0; row < coords.length; row++) {
        for (int col = 0; col < coords[row].length; col++) {
          if (coords[row][col] != 0) {
             if(board.getMatrix()[y + row + 1][x + col] > 0){
               arrived = true;
             }           
          }
        }
      }
      if (millis() > lastTime + currentSpeed) {
        y++;
        lastTime = millis();
      }
    } else {
      arrived = true;
    }
  }

  public void moveDownFaster() {
    currentSpeed = FASTSPEED;
  }

  public void moveDownNormalSpeed() {
    currentSpeed = NORMALSPEED;
  }

  public void rotate() {
    if (!arrived) {
      int[][] rotatedMatrix = transpose(coords);
      rotatedMatrix = reverse(rotatedMatrix);
      
      for(int row = 0; row < rotatedMatrix.length; row++){
        for(int col = 0; col < rotatedMatrix[row].length; col++){
          if(board.getBoardWidth() > x + col && board.getMatrix()[y + row][x + col] != 0){
            return;
          }
        }
      }
      coords = rotatedMatrix;
    }
  }

  private int[][] transpose(int[][] matrix) {
    int[][] tmp = new int[matrix[0].length][matrix.length];
    for (int i = 0; i < matrix.length; i++) {
      for (int j = 0; j < matrix[i].length; j++) {
        tmp[j][i] = matrix[i][j];
      }
    }
    return tmp;
  }

  private int[][] reverse(int[][] matrix) {
    int middleRow = matrix.length/2;
    for (int i = 0; i < middleRow; i++) {
      int[] tmp = matrix[i];
      matrix[i] = matrix[matrix.length-i-1];
      matrix[matrix.length-i-1] = tmp;
    }
    return matrix;
  }

  public PImage getBlock() {
    return block;
  }

  public int[][] getCoords() {
    return coords;
  }
}