class Player {
  //FloatList data_right, data_left, data_top, data_bottom;
  //float right = 0, left = 0, top = 0, bottom = 0;
  float receivedVar1 = 0, receivedVar2 = 0, receivedVar3 = 0;
  float hori = 0, verti = 0, roll = 0;
  float roll_prev;
  float x, y;
  int playerColor;
  Shape shape;
  int shapeNum = 0;
  int shapePoolMinNum = 0;
  int shapePoolMaxNum = 50;

  // Constructor
  Player () {
    this.x = width/2;
    this.y = height/2;
    shape = new Shape();
  }
  
  // XY coordinate where user is pointing
  void pointer() {
    this.x = map(hori, 0, 10, screenMargin, width - screenMargin);
    this.y = map(verti, 0, 10, screenMargin, height - screenMargin);
  }
  
  int shapeRoller(int i) {
    int tempShapeNum = i;
    int shapeNum = int(i/10) * 10;
    int maxShapeNum = shapeNum + 3;
    if(roll == 3) { // clockwise
      if(i >= maxShapeNum) {
        if(i >= shapePoolMaxNum +3) {
          return shapePoolMinNum; // back to first shape
        }
        else return shapeNum += 10; // or to next shape
      }
      else return ++tempShapeNum; // else, rotate shape
    }
    else if(roll == 1) { // counter-clockwise
      if(i <= shapeNum) {
        if(i <= shapePoolMinNum) {
          return shapePoolMaxNum + 3; // back to last shape
        }
        else return shapeNum -= 10; // or to next shape
      }
      else return --tempShapeNum; // else, rotate shape
    }
    else return tempShapeNum; // stay
  }
  
  void shapeManager() {
    if(roll != 2 && roll != 0) {
      if(roll_prev != roll) {
        shapeNum = shapeRoller(shapeNum);
        rotate.play();
      }
    }
    roll_prev = roll;
  }
  
  void draw () {
    pushMatrix();
    rectMode(CENTER);
    shape.shapeColor = playerColor;
    shape.moveShape(this.x, this.y);
    shapeManager();
    shape.draw(shapeNum);
    popMatrix();
  }
  
  void drawTest () {
    pushMatrix();
    rectMode(CENTER);
    shape.shapeColor = playerColor;
    shape.moveShape(this.x, this.y);
    shape.drawAim();
    popMatrix();
  }
}
