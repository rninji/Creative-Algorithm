class Mamba{
  int x, y, w, h;
  PImage img_stand, img_damaged;
  int state; // 0 : stand, 1 : damaged, 2 : death
  int damagedDelay;
  int maxHp, hp;
  
  Mamba(){
    this.x = width/100*78;
    this.y = width/100 * 35;
    this.w = 450;
    this.h = 450;
    this.maxHp = 100;
    this.hp = maxHp;
  }
  
  void draw(){
    imageMode(CENTER);
    if (this.state == 0) { // stand
      image(mamba_standing, this.x, this.y, this.w, this.h);
    }
    else if (this.state == 1){ // attack
      image(mamba_damaged, this.x, this.y, this.w, this.h);
      this.damagedDelay++;
    }
    else{
      
    }
    
    hp = maxHp - score;
    if (hp<=0) {
      hp = 0;
      this.dead();
    }
    
    if (this.damagedDelay > 30) this.changeState();
  }
  
  void changeState(){
    // to damaged
    if (this.state == 0) {
      this.state = 1;
    }
    // to stand
    else {
      this.state = 0;
      this.damagedDelay = 0;
    }
  }
  
  void dead(){
    this.state = 2;
  }
}
