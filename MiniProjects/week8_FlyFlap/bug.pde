int bugsize = 50;

class Bug {
  float x, y, d; // position and direction
  int speed;
  boolean death;
  
  Bug(){
    x=0;
    y=0;
    d=0;
    speed = 0;
    death = true;
  }
  
  void display(){
    if (d==0){ // right direction
      image(bug_right, x, y, bugsize, bugsize);
    }
    else{ // left direction
      image(bug_left, x, y, bugsize, bugsize);
    }
  }
  
  void move(){
    if (d==0){
      x+=speed;
    }
    else{
      x-=speed;
    }
  }
  
  void birth(){
    death = false;
    d = int(random(2));
    y=int(random(500,750));
    if (d==0){ // right direction
      x=-100;
    }
    else { // left direction
      x=1300;
    }
    speed = int(random(1,6));
  }
  
  void dead(){
    x=0;
    y=0;
    d=0;
    speed = 0;
    death = true;
  }
}
