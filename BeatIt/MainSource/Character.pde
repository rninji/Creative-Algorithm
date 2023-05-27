class CharacterClass {
  int x, y, w, h;
  PImage img_stand, img_attack;
  int state; // 0 : stand, 1 : attack
  int attackDelay;
  int point;
  
  CharacterClass(int _x, int _y, int _w, int _h, PImage img1, PImage img2){
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;
    this.img_stand = img1;
    this.img_attack = img2;
    this.attackDelay = 0;
    this.point = 0;
  }
  
  void draw(){
    imageMode(CENTER);
    if (this.state == 0) { // stand
      image(this.img_stand, this.x, this.y, this.w, this.h);
    }
    else { // attack
      image(this.img_attack, this.x, this.y, this.w, this.h);
      this.attackDelay++;
    }
    
    if (this.attackDelay > 30) this.changeState();
  }
  
  void changeState(){
    // to attack
    if (this.state == 0) {
      this.state = 1;
      this.x = this.x + 100;
    }
    // to stand
    else {
      this.state = 0;
      this.x = this.x - 100;
      this.attackDelay = 0;
    }
  }
  
}
