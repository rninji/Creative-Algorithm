int mode = 2; // 0 : only position, 1 : add rotation, 2 : change block
int rows = 16;
int columns = 9;

int[][] makeHole(int b1, int b2, int b3){
  
  // init grid
  int[][] grid = new int[rows][columns];
  for (int row = 0; row < grid.length; row++) {
      for (int column = 0; column < grid[row].length; column++) {
        grid[row][column] = 0; 
      }
  }
  
  for (int i=0; i<3; i++){
    int x=0, y=0; // position
    int r; // set rotation
    if (mode == 0) r = 0;
    else r = int(random(4));
    
    int b; // set block shape
    if (mode == 2) b = int(random(6));
    else b = (i==0) ? b1 : ((i==1) ? b2 : b3);
    b = b%10;
    
    // block[b][r][ ][]
    if (i==0){ // first block -> center
      x = rows/2 - 1;
      y = columns/2 - 1;
      for (int j=0; j<3; j++){
        for (int k=0; k<3; k++){
          if (block[b][r][j][k] == 1) grid[x+k][y+j] = 1;
          else grid[x+k][y+j] = 0;
        }
      }
    }
    
    else{ // 2nd, 3rd block - Check collision location
      int direction = int(random(4)); // 0 : left, 1 : right, 2 : bottom, 3 : left
      boolean chk = false;
      while(true){
        direction = int(random(4));
        chk = false;
        switch (direction){
          case(0): // left to right
         
          y = columns/2 - 1;
          x = rows - 3;
          for (int d = 0; d<grid.length-2; d++){
            for (int k=0; k<3; k++){
              for (int j=0; j<3; j++){
                if (block[b][r][j][k] == 1 && grid[d+k][y+j] == 1) { // collision
                  x = d - 1;
                  chk = true;
                  break;
                }
              }
            }
            if (chk == true) break;
            
          }
          break;
          
          case(1): // top to bottom
          x = rows/2 - 1;
          y = columns - 3;
          for (int d = 0; d<grid[x].length-3; d++){
            for (int k=0; k<3; k++){
              for (int j=0; j<3; j++){
                if (block[b][r][j][k] == 1 && grid[x+k][d+j] == 1) { // collision
                  y = d - 1;
                  chk = true;
                  break;
                }
              }
              if (chk == true) break;
            }
            if (chk == true) break;
          }
          
          break;
          
          case(2) : // right to left
          y = columns/2 - 1;
          x = 0;
          for (int d = grid.length-3; d>=0; d--){
            for (int k=0; k<3; k++){
              for (int j=0; j<3; j++){
                if (block[b][r][j][k] == 1 && grid[d+k][y+j] == 1) { // collision
                  y = d + 1;
                  chk = true;
                  break;
                }
              }
              if (chk == true) break;
            }
            if (chk == true) break;
          }
          break;
          
          default: // bottom to top
          x = rows/2 - 1;
          y = columns - 3;
          for (int d = grid[x].length-3; d>=0; d--){
            for (int k=0; k<3; k++){
              for (int j=0; j<3; j++){
                if (block[b][r][j][k] == 1 && grid[x+k][d+j] == 1) { // collision
                  y = d + 1;
                  chk = true;
                  break;
                }
              }
              if (chk == true) break;
            }
            if (chk == true) break;
          }
          
          break;
        }
      if (x>=0&&y>=0&&x<rows-3&&y<columns-3) break;
    }
      
       //Add the block at the collision location
      for (int j=0; j<3; j++){
        for (int k=0; k<3; k++){
          if (block[b][r][j][k] == 1) grid[x+k][y+j] = 1;
        }
      }
      
     }
  }
  return grid;
}
