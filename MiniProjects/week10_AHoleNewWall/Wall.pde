class Wall {
  float sizeRatio = 1.0;
  int rows = 16;
  int columns = 9;
  int mapNum = 1;
  int mapNum_prev = 0;
  float cellSize = width*sizeRatio/rows;
  ArrayList<Collider> wallColliders;
  boolean[][] grid = new boolean[rows][columns];
  int [][] hole;
  
  // Constructor
  Wall() {
    wallColliders = new ArrayList<Collider>();
    int colliderNum = 0;
    for (int row = 0; row < grid.length; row++) {
      for (int column = 0; column < grid[row].length; column++) {
        wallColliders.add(new Collider(this.cellSize));
        wallColliders.get(colliderNum).moveCollider((0.5+row)*cellSize, (0.5+column)*cellSize);
        colliderNum++;
        grid[row][column] = true; // obstacle
      }
    }
    hole = makeHole(player1.shapeNum, player2.shapeNum, player3.shapeNum);
  }

  void mapSelector(int mapNum) {
    for (int row = 0; row < grid.length; row++) {
      for (int column = 0; column < grid[row].length; column++) {
        grid[row][column] = true; // obstacle
      }
    }
    // if you want to make hole, disable the cell by setting value to false
    // most left - most top is grid[0][0]
    // horizontally, add up array number of the front:  grid[0][0], grid[1][0]. grid[2][0],...
    // vertically, add up array number of the back:  grid[0][0], grid[0][1]. grid[0][2],...
    switch(mapNum) {
      case 1:
        for (int row = 0; row < grid.length; row++) {
          for (int column = 0; column < grid[row].length; column++) {
            if (hole[row][column]==1){
              grid[row][column] = false;
            }
        }
    }
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
  
  void newHole(){
    hole = makeHole(player1.shapeNum, player2.shapeNum, player3.shapeNum);
  }
  
  void draw () {
    wallColliders = new ArrayList<Collider>();
    cellSize = width*sizeRatio/rows;
    //println(cellSize);
    mapSelector(mapNum);
    int colliderNum = 0;
    for (int row = 0; row < grid.length; row++) {
      for (int column = 0; column < grid[row].length; column++) {
        if (grid[row][column]){
          wallColliders.add(new Collider(this.cellSize));
          wallColliders.get(colliderNum).moveCollider((0.5+row)*cellSize, (0.5+column)*cellSize);
          pushMatrix();
          translate((width/2)*(1-sizeRatio), (height/2)*(1-sizeRatio));
          translate((0.5+row)*cellSize, (0.5+column)*cellSize);
          rectMode(CENTER);
          noStroke();
          fill(11, 36, 50);
          rect(0, 0, cellSize, cellSize ); // wall
          if (column % 2 == 0) {
            if ( (column * 16 + row) % 2 == 1) {
              strokeWeight(sizeRatio * 4);
              stroke(0, 0, 85);
              noFill();
              beginShape();
              translate(-cellSize/2, -cellSize/2);
              vertex(cellSize, 0);
              vertex(0, 0);
              vertex(0, cellSize);
              vertex(cellSize, cellSize);
              endShape();
              noStroke();
              translate(cellSize/2, cellSize/2);
            }

            if ( (column * 16 + row) % 2 == 0) {
              strokeWeight(sizeRatio * 4);
              stroke(0, 0, 85);
              noFill();
              beginShape();
              translate(-cellSize/2, -cellSize/2);
              vertex(0, 0);
              vertex(cellSize, 0);
              vertex(cellSize, cellSize);
              vertex(0, cellSize);
              endShape();
              noStroke();
              translate(cellSize/2, cellSize/2);
            }
          }

          if (column % 2 == 1) {
            if ( (column * 16 + row) % 2 == 0) {
              strokeWeight(sizeRatio * 4);
              stroke(0, 0, 85);
              noFill();
              beginShape();
              translate(-cellSize/2, -cellSize/2);
              vertex(cellSize, 0);
              vertex(0, 0);
              vertex(0, cellSize);
              vertex(cellSize, cellSize);
              endShape();
              noStroke();
              translate(cellSize/2, cellSize/2);
            }

            if ( (column * 16 + row) % 2 == 1) {
              strokeWeight(sizeRatio * 4);
              stroke(0, 0, 85);
              noFill();
              beginShape();
              translate(-cellSize/2, -cellSize/2);
              vertex(0, 0);
              vertex(cellSize, 0);
              vertex(cellSize, cellSize);
              vertex(0, cellSize);
              endShape();
              noStroke();
              translate(cellSize/2, cellSize/2);
            }
          }

          popMatrix();
          colliderNum++;
        }
      }
    }
    
  }
}
