class Face{
  int x, y; // position
  int exp; // 0:normal, 1:smile, 2:mad, 3:sad, 4:love
  int t; // duration time
  int fav; // favorability
  
  //constructor
  Face(int _x, int _y){
    x=_x;
    y=_y;
    exp=0;
    t=0;
    fav=0;
  }
  
  //func
  void img(){
    if (exp==0){
      image(normal, x, y, facesize, facesize);
      fav = 0;
    }
    else if(exp==1){
      image(smile, x, y, facesize, facesize);
      fav = 5;
    }
    else if(exp==2){
      image(mad, x, y, facesize, facesize);
      fav = -10;
    }
    else if(exp==3){
      image(sad, x, y, facesize, facesize);
      fav = -5;
    }
    else{
      image(love, x, y, facesize, facesize);
      fav = 15;
    }
    
    if (t==0){
      exp=0;
    }
    t--;
  }
  
  void changeExp(int e){
    exp=e;
    t=150;
    img();
  }
}
