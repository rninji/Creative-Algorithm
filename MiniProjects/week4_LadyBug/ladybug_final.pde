import peasy.*;
import controlP5.*;

PeasyCam cam;

PGraphics pg;

ControlP5 cp5;
Slider dotSizeSl, dotCntSl, dotDisXSl, dotDisYSl, bugRatSl, dotRatSlX, dotRatSlY;
ColorPicker dotColSl, backColSl;

PVector[][] bug;
int total = 100;

float bugRat = 0;
float dotRatX = 1;
float dotRatY = 1;
int dotSize = 0;
int dotCnt = 0;
float dotDisX = 0;
float dotDisY = 0;
color dotCol = color(0,0,0);
color backCol = color(0, 0, 0);

float rot = 0;

void setup(){
  size(1000,800,P3D);
  guiSetting(); 
  cam = new PeasyCam(this, 0, -100, 0, 500);
  
  bug = new PVector[total+1][total+1];
  pg = createGraphics(width, height);
}

void draw(){
  background(0);
  
  // get values from sliders
  bugRat = bugRatSl.getValue();
  dotSize = int(dotSizeSl.getValue());
  dotCnt = int(dotCntSl.getValue());
  dotDisX = dotDisXSl.getValue();
  dotDisY = dotDisYSl.getValue();
  dotRatX = dotRatSlX.getValue();
  dotRatY = dotRatSlY.getValue();
  dotCol = dotColSl.getColorValue();
  backCol = backColSl.getColorValue();
  
  lights();
  stroke(255);
  rotateZ(-HALF_PI);
  rotateX(HALF_PI);
  
  //body
  lady();
  
  //pattern
  pattern();
  
  //gui 
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
}
