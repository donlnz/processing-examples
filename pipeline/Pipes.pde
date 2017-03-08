class Pipes {
  Pipe[][] pipes;
  int scale;
  int rows, cols;
  
  Pipes(int cols, int rows, int scale) {
    this.rows = rows;
    this.cols = cols;
    this.pipes = new Pipe[cols][rows];
    this.scale = scale;
  }
  
  void spawn() {
    boolean found = false;
    int x_, y_;
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        if (pipes[x][y] == null)
        
      }
    }
  }
}