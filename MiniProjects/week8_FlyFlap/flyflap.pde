import oscP5.*;
import netP5.*;
import processing.sound.*;

OscP5 oscP5;
NetAddress dest;

PImage floor, bug_left, bug_right, flap;
SoundFile wheek, kill;

int score = 0, time = 60;
int screen =0;

int start_time, now_time;

int w, h;
float fw, fh, fz, fs = 2;

boolean smash;
int cnt=0, hit=5;
int fx=0, fy=0;

int bugcnt =10, b=0;
Bug[] bugs = new Bug[bugcnt];

void setup(){
  size(1200,800,P3D);
  w=width;
  h=height;
  
  fh = height*0.5;
  fz = 2000;
  camera();
  
  floor = loadImage("floor.jpg");
  bug_right = loadImage("bug_right.png");
  bug_left = loadImage("bug_left.png");
  flap = loadImage("flap.png");
  
  wheek = new SoundFile(this, "wheek.mp3");
  kill = new SoundFile(this, "kill.mp3");
  
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6448);
  
  imageMode(CENTER);
  
  // Make faces array
  for (int i = 0; i<bugcnt; i++){
    bugs[i] = new Bug();
  }
  bugs[b].birth();
  b++;
}

void draw(){
  background(255);
  
  if (screen == 0){
    main();
  }
  else if (screen == 1){
    game();
  }
  else {
    score();
  }
}

void main(){
  textMode(CENTER);
  textAlign(CENTER);
  textSize(128);
  fill(0);
  text("Fly Flap", width/2, height/2 - 100); 
  fill(0, 408, 612, 90);
  textSize(70);
  text("Press Any Key", width/2, height/2 + 100);
}

void game(){
  //time
  time = 60 - (millis() - start_time)/1000;
  textMode(LEFT);
  textAlign(LEFT);
  textSize(90);
  fill(0, 408, 612);
  String t = "Time : " + time;
  text(t, 40, 120); 
  
  
  //score
  textMode(RIGHT);
  textAlign(RIGHT);
  textSize(100);
  fill(0);
  text(score, width-40, 120);
  
  // floor
  beginShape();
  noStroke();
  texture(floor);
  vertex(-width*1.5, height, 0);
  vertex(width*2.5, height, 0);
  vertex(width*2.5, 0, -fz);
  vertex(-width*1.5, 0, -fz);
  endShape();
  
  // bugs
  if (frameCount % 80 == 0){
    bugs[b].birth();
    b++;
    if (b==bugcnt) b=0;
  }
  
  for (int i = 0; i<bugcnt; i++){
    if (bugs[i].death == false){
      bugs[i].display();
      bugs[i].move();
      if (bugs[i].d==0 && bugs[i].x>width) bugs[i].dead();
      else if (bugs[i].d==1 && bugs[i].x<0) bugs[i].dead();
    }
  }
  
  // fly flap
  pushMatrix();
  translate(width/2, height-100);
  
  //smashing
  if (smash==true){
    if (cnt<hit){ // down
    rotateX(cnt * 0.25);
    }
    else if (cnt==hit){ // hit
      for (int i = 0; i<bugcnt; i++){
        if (bugs[i].x-width/2<fx+80 && bugs[i].x-width/2>fx-80 && bugs[i].y-height+100<fy-100 && bugs[i].y-height+100>fy-300){
          bugs[i].dead();
          kill.play();
          score++;
        }
      }
    }
    else {
      cnt=-1;
      smash=false;
    }
    cnt++;
  }
  
  // moving
  if (keyPressed){
    if (key=='a'){
      if (fx>80-width/2) fx-=5;
    }
    else if (key == 'd'){
      if (fx<width/2-80) fx+=5;
    }
    else if (key == 'w'){
      if (fy>-200) fy-=5;
    }
    else if (key == 's'){
      if (fy<200) fy+=5;
    }
  }
  image(flap, fx, fy, 320, 640);
  //hitbox
  //quad(fx+80,fy-100,fx-80,fy-100,fx-80,fy-300,fx+80,fy-300);
  popMatrix();
  
  if (time==0) screen = 2; //game->score
}

void score(){
  textMode(CENTER);
  textAlign(CENTER);
  textSize(128);
  fill(0);
  String s = "Your Score : " + score;
  text(s, width/2, height/2 - 100); 
  fill(0, 408, 612, 90);
  textSize(70);
  text("Press Any Key", width/2, height/2 + 100);
}

void mousePressed(){
  smash = true;
  wheek.play();
}

void keyPressed(){
  if (screen==0) { //main->game
    screen=1;
    start_time = millis();
  }
  else if (screen==2) { // score->main
    screen=0;
    score=0;
    time=60;
  }
}

void oscEvent(OscMessage m) {
  // message from wekinator to processing
  if (m.checkAddrPattern("/output_1")==true) {
    println("smash");
    if (smash==false) {
      smash = true;
      wheek.play();
    }
  }
}
