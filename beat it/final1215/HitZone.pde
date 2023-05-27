class HitZone{
  float x, y;
  int size;
  
  HitZone(){
    this.x = width/100*15;
    this.y = height/10*9;
    this.size = 70;
  }
  
  void draw(){
    stroke(255);
    strokeWeight(5);
    fill(0);
    circle(x, y, size);
  }
}
