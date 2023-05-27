import oscP5.*;
import netP5.*;

OscP5 oscP5;
OscP5 woscP5;
NetAddress dest;

int found;
PVector poseOrientation;

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;

float ballX = width/2;
float ballY = height/2;

int hue = int(random(360));
int s = 50;
int b = 0;
//randomSeed(0);
int w =1200, h = 800;

int facesize = 100;
int facecnt_x = int(w/(facesize*1.2));
int facecnt_y = int(h/(facesize*1.2));

Face[][] faces = new Face[facecnt_y][facecnt_x];
  
PImage normal, smile, mad, sad, love;

int chg = 3;
int sm=0, md=0, lw=0, rw=0, cl=0;

int total_fav = 0;

void setup(){
  size(1200, 800);
  colorMode(HSB);
  
  // Port
  oscP5 = new OscP5(this, 8338); // faceosc input port number
  woscP5 = new OscP5(this, 12000); //weki input port number
  dest = new NetAddress("127.0.0.1", 6448); // output port number 
  
  //Face OSC
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  poseOrientation = new PVector();

  //load Iimages
  normal = loadImage("normal.png");
  smile = loadImage("smile.png");
  mad = loadImage("mad.png");
  sad = loadImage("sad.png");
  love = loadImage("love.png");
  
  // Make faces array
  for (int i = 0; i<facecnt_y; i++){
    for (int j = 0; j<facecnt_x; j++){
      faces[i][j] = new Face(width/facecnt_x*j, height/facecnt_y*i);
      faces[i][j].img();
  }
  }
  
}

void draw(){
  // Convert total favorability to background color
  colorMode(HSB);
  b = int(map(total_fav, -facecnt_x*facecnt_y, facecnt_x*facecnt_y, 50, 100));
  print(b);
  background(color(hue,s,b));
  total_fav = 0;
  
  // ball position
  if (found > 0) {
    if (poseOrientation.y>0.25) {
      ballX=width;
    }
    else if (poseOrientation.y<-0.25) {
      ballX=0;
    }
    else{
      if (poseOrientation.x>0.3) {
        ballY=height;
      }
      else if (poseOrientation.y<-0.2) {
        ballY=0;
      }
      else {
        ballX = map(poseOrientation.y, -0.25, 0.25, 0, width);
        ballY = map(poseOrientation.x, -0.2, 0.3, 0, height);
      }
    }
  }
  
  // draw faces
  float d = width+height;
  int adx=0, ady=0;
  for (int i = 0; i<facecnt_y; i++){
    for (int j = 0; j<facecnt_x; j++){
      faces[i][j].img();
      total_fav += faces[i][j].fav;
     
      // Find adjacent faces
      if (d > abs(faces[i][j].x-ballX) + abs(faces[i][j].y-ballY)){
        adx = i;
        ady = j;
        d = abs(faces[i][j].x-ballX) + abs(faces[i][j].y-ballY);
      }
    }
  }
    
  // draw a ball
  ellipseMode(CENTER);
  noStroke();
  colorMode(RGB);
  fill(255,0,0);
  ellipse(int(ballX),int(ballY),10, 10);
  
  //if (mousePressed==true) 
  sendOsc();
  
  if (sm>chg){
    sm=0;
    md=0;
    lw=0;
    rw=0;
    cl=0;
    println("smile");
    if (adx != 0) faces[adx-1][ady].changeExp(1);
    else if (adx != facecnt_x) faces[adx+1][ady].changeExp(1);
    if (ady != 0) faces[adx][ady-1].changeExp(1);
    else if (adx != facecnt_y) faces[adx+1][ady].changeExp(1);
    faces[adx][ady].changeExp(1);
  }
  else if (md>chg){
    sm=0;
    md=0;
    lw=0;
    rw=0;
    cl=0;
    println("mad");
    float r = random(1);
    if (r>0.5) faces[adx][ady].changeExp(2);
    else faces[adx][ady].changeExp(3);
  }
  else if (lw>chg){
    sm=0;
    md=0;
    lw=0;
    rw=0;
    cl=0;
    println("lw");
    faces[adx][ady].changeExp(4);
  }
  else if (rw>chg){
    sm=0;
    md=0;
    lw=0;
    rw=0;
    cl=0;
    println("rw");
    faces[adx][ady].changeExp(4);
  }
  else if (cl>120){
    sm=0;
    md=0;
    lw=0;
    rw=0;
    cl=0;
    println("close");
    reset();
  }
}

//void keyPressed(){
//  reset();
//}

void reset(){
  for (int i = 0; i<facecnt_y; i++){
    for (int j = 0; j<facecnt_x; j++){
      faces[i][j].changeExp(0);
    }
  }
}
