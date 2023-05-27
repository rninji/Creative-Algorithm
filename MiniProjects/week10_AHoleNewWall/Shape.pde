class Shape {
  ArrayList<Collider> colliders;
  float x, y;
  int size;
  int shapeColor;
  
  // Constructor
  Shape() {
    this.x = width/2;
    this.y = height/2;
    this.size = 80; 
    colliders = new ArrayList<Collider>();
    for(int i = 0; i < 4; i++) {
      colliders.add(new Collider(this.size));
    }
  }
  
  void moveShape(float _x, float _y) {
    this.x =  _x;
    this.y = _y;
  }
  
  void draw (int num) {
    pushMatrix();
    shapeSelector(num);
    popMatrix();
  }
  
  void drawAim () {
    pushMatrix();
    rectMode(CENTER);
    noStroke();
    fill(shapeColor, 100,100);
    rect(this.x, this.y, 100, 10);
    rect(this.x, this.y, 10, 100);
    popMatrix();
  }
  
  // Decides which shapes to draw
  void shapeSelector(int i) {
    switch(i) {
      case 0:
      //   []
      // [][][]
      //
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x + this.size, this.y);
        colliders.get(3).moveCollider(this.x, this.y - this.size);
        break;
      case 1:
      //   []
      //   [][]
      //   []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x + this.size, this.y);
        colliders.get(2).moveCollider(this.x, this.y + this.size);
        colliders.get(3).moveCollider(this.x, this.y - this.size);
        break;
      case 2:
      //
      // [][][]
      //   []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x + this.size, this.y);
        colliders.get(3).moveCollider(this.x, this.y + this.size);
        
        break;
      case 3:
      //   []
      // [][]
      //   []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x, this.y + this.size);
        colliders.get(3).moveCollider(this.x, this.y - this.size);
        break;
        
      case 10:
      // []
      // [][][]
      // 
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x - this.size, this.y - this.size);
        colliders.get(3).moveCollider(this.x + this.size, this.y);
        break;
      case 11:
      //   [][]
      //   []
      //   []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y - this.size);
        colliders.get(2).moveCollider(this.x + this.size, this.y - this.size);
        colliders.get(3).moveCollider(this.x, this.y + this.size);
        break;
      case 12:
      // 
      // [][][]
      //     []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x + this.size, this.y);
        colliders.get(3).moveCollider(this.x + this.size, this.y + this.size);
        break;
      case 13:
      //   []
      //   []
      // [][]
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y - this.size);
        colliders.get(2).moveCollider(this.x - this.size, this.y + this.size);
        colliders.get(3).moveCollider(this.x, this.y + this.size);
        break;
        
        ////
      case 20:
      //     []
      // [][][]
      //
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x + this.size, this.y);
        colliders.get(3).moveCollider(this.x + this.size, this.y - this.size);
        break;
      case 21:
      //   []
      //   []
      //   [][]
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y - this.size);
        colliders.get(2).moveCollider(this.x, this.y + this.size);
        colliders.get(3).moveCollider(this.x + this.size, this.y + this.size);
        break;
      case 22:
      //     
      // [][][]
      // []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x + this.size, this.y);
        colliders.get(3).moveCollider(this.x - this.size, this.y + this.size);
        break;
      case 23:
      // [][]    
      //   []
      //   []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y - this.size);
        colliders.get(2).moveCollider(this.x, this.y + this.size);
        colliders.get(3).moveCollider(this.x - this.size, this.y - this.size);
        break;
        
      case 30:
      //   []
      //   [][]
      //     []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x + this.size, this.y);
        colliders.get(2).moveCollider(this.x, this.y - this.size);
        colliders.get(3).moveCollider(this.x + this.size, this.y + this.size);
        break;
      case 31:
      //   
      //   [][]
      // [][]  
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x + this.size, this.y);
        colliders.get(2).moveCollider(this.x - this.size, this.y + this.size);
        colliders.get(3).moveCollider(this.x, this.y + this.size);
        break;
      case 32:
      // []
      // [][]
      //   []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x - this.size, this.y - this.size);
        colliders.get(3).moveCollider(this.x, this.y + this.size);
        break;
      case 33:
      //   [][]
      // [][]
      //   
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x + this.size, this.y - this.size);
        colliders.get(3).moveCollider(this.x, this.y - this.size);
        break;
        
      case 40:
      //   []
      // [][]
      // []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x - this.size, this.y + this.size);
        colliders.get(3).moveCollider(this.x, this.y - this.size);
        break;
      case 41:
      // [][]
      //   [][]
      //   
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x + this.size, this.y);
        colliders.get(2).moveCollider(this.x - this.size, this.y - this.size);
        colliders.get(3).moveCollider(this.x, this.y - this.size);
        break;
      case 42:
      //     []
      //   [][]
      //   []
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x + this.size, this.y);
        colliders.get(2).moveCollider(this.x + this.size, this.y - this.size);
        colliders.get(3).moveCollider(this.x, this.y + this.size);
        break;
      case 43:
      //   
      // [][]
      //   [][]
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x - this.size, this.y);
        colliders.get(2).moveCollider(this.x, this.y + this.size);
        colliders.get(3).moveCollider(this.x + this.size, this.y + this.size);
        break;
        
      case 50:
      // [][]
      // [][]
      // 
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y - this.size);
        colliders.get(2).moveCollider(this.x - this.size, this.y);
        colliders.get(3).moveCollider(this.x - this.size , this.y - this.size);
        break;
      case 51:
      //   [][]
      //   [][]
      // 
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y - this.size);
        colliders.get(2).moveCollider(this.x + this.size, this.y);
        colliders.get(3).moveCollider(this.x + this.size , this.y - this.size);
        break;
      case 52:
      // 
      //   [][]
      //   [][]
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y + this.size);
        colliders.get(2).moveCollider(this.x + this.size, this.y);
        colliders.get(3).moveCollider(this.x + this.size , this.y + this.size);
        break;
      case 53:
      // 
      // [][]
      // [][]
        colliders.get(0).moveCollider(this.x, this.y);
        colliders.get(1).moveCollider(this.x, this.y + this.size);
        colliders.get(2).moveCollider(this.x - this.size, this.y);
        colliders.get(3).moveCollider(this.x - this.size , this.y + this.size);
        break;
    }
    for(int j = 0; j < 4; j++) {
      pushMatrix();
      translate(colliders.get(j).x, colliders.get(j).y);
      rectMode(CENTER);
      stroke(0,0,95);
      strokeWeight(3);
      fill(shapeColor, 80,100);
      rect(0, 0, this.size, this.size ); // wall
      popMatrix();
    }
  }
}
