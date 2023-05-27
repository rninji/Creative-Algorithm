/* Library *///////////////////////////////////////////////////////////////////////////////////
import oscP5.*;
import netP5.*;
import ddf.minim.*;
import ddf.minim.analysis.FFT;
import processing.sound.*;
import java.util.LinkedList; 

/* OSC Info *//////////////////////////////////////////////////////////////////////////////////
OscP5 oscP5_draw, oscP5_motion;
NetAddress dest;

// Port Number
int portInputMotion = 12000; // motion
int portInputDraw = 13000; // draw
int portOutput = 6449;

// Address Pattern (from wekinator)
String addr_fromMotion = "/wek/outputs_motion";
String addr_fromDraw = "/wek/outputs_draw";

// Address Pattern (to wekinator)
String addr_to = "/wek/inputs";

/* Game Variable */////////////////////////////////////////////////////////////////////////////
// Player //
Player player;

// Controllable Game Setting //
int screenMargin = 50;
int gameStartTime = 0;
int songCnt = 4;

// Game Information //
int frameTime = 0;
int time = 0;
int startTime = 0;
int score = 0;
boolean gameFinished = false;
boolean gameStart = false;
int perfect = 0, good = 0, bad = 0, miss = 0;
int combo = 0, maxCombo = 0;
int songNum = 0;

// Sound Files //
Minim minim;
AudioPlayer blackmamba;
AudioPlayer blackmamba2;
AudioPlayer savage;
AudioPlayer savage2;
AudioPlayer nextlevel;
AudioPlayer nextlevel2;
AudioPlayer girls;
AudioPlayer girls2;
AudioPlayer whoosh;
AudioPlayer gun;
AudioPlayer punch;
AudioPlayer magic;
AudioPlayer menu;
AudioPlayer [] songList = new AudioPlayer [songCnt];
AudioPlayer [] songList2 = new AudioPlayer [songCnt];
FFT fft; 

int volumeSize = 0 ;

// Font //
PFont titleFont;
PFont tFont;
PFont effectFont;

String [] songTitle  = new String [songCnt]; 

// Image Files //
// characters
PImage karina_standing, giselle_standing, winter_standing, ningning_standing; 
PImage karina_attack, giselle_attack, winter_attack, ningning_attack; 
PImage karina_weapon, giselle_weapon, winter_weapon, ningning_weapon; 
PImage mamba_standing, mamba_damaged;

// bakcground
PImage background1, background2;

// drawings
PImage heart, moon, star, butterfly; 

// albums
PImage [] albums = new PImage [songCnt];

// Note //
HitZone hitzone;
LinkedList<Note> noteList = new LinkedList<>();
int noteDelay = 30;
int noteFrame = 0;
int speed = 3;

boolean longChk = false;

// Character //
CharacterClass[] characters = new CharacterClass[4];
Mamba mamba;

// Text Box //
TEXTBOX textbox;
String[] txt;

// Canvas //
PGraphics canvas;

public enum Stage{
  Setting, Select, Prepare, Play, Result;
};

private Stage currentStage = Stage.Setting;

/* Setup *///////////////////////////////////////////////////////////////////////////////////
void setup(){
  // Screen Setting //
  size (1080,720);
  //fullScreen();
  frameRate(60);
  
  // Image initialize
  heart = loadImage("image/heart.png");
  moon = loadImage("image/moon.png");
  star = loadImage("image/star.png");
  butterfly = loadImage("image/butterfly.png");
  
  karina_standing = loadImage("image/karina_standing.png");
  giselle_standing = loadImage("image/giselle_standing.png");
  winter_standing = loadImage("image/winter_standing.png");
  ningning_standing = loadImage("image/ningning_standing.png");
  karina_attack = loadImage("image/karina_attack.png");
  giselle_attack = loadImage("image/giselle_attack.png");
  winter_attack = loadImage("image/winter_attack.png");
  ningning_attack = loadImage("image/ningning_attack.png");
  karina_weapon = loadImage("image/karina_weapon.png");
  giselle_weapon = loadImage("image/giselle_weapon.png");
  winter_weapon = loadImage("image/winter_weapon.png");
  ningning_weapon = loadImage("image/ningning_weapon.png");  
  
  mamba_standing = loadImage("image/mamba_standing.png");
  mamba_damaged = loadImage("image/mamba_damaged.png");
  
  background1 = loadImage("image/background1.png");
  background2 = loadImage("image/background2.png");
  
  albums[0] = loadImage("image/blackmamba.jpg");
  albums[1] = loadImage("image/nextlevel.jpg");
  albums[2] = loadImage("image/savage.jpg");
  albums[3] = loadImage("image/girls.jpg");
  
  // Class init //
  player = new Player();
  hitzone = new HitZone();
  textbox = new TEXTBOX(width/2, height/3*2 - 30, width/10*4, 100);
  canvas = createGraphics(width, height);
  
  characters[0] = new CharacterClass(width/100*15, height/10*6, 150*80/100, 400*80/100, karina_standing, karina_attack);
  characters[1] = new CharacterClass(width/100*24, height/10*6 - 40, 150*75/100, 400*75/100, giselle_standing, giselle_attack);
  characters[2] = new CharacterClass(width/100*33, height/10*6 - 80, 150*70/100, 400*70/100, winter_standing, winter_attack);
  characters[3] = new CharacterClass(width/100*42, height/10*6 - 120, 150*65/100, 400*65/100, ningning_standing, ningning_attack);
  mamba = new Mamba();
  
  // Sound initialize
  minim = new Minim(this);
  songList[0] = minim.loadFile("music/blackmamba.mp3");
  songList2[0] = minim.loadFile("music/blackmamba.mp3");
  songList[1] = minim.loadFile("music/nextlevel.mp3");
  songList2[1] = minim.loadFile("music/nextlevel.mp3");
  songList[2] = minim.loadFile("music/savage.mp3");
  songList2[2] = minim.loadFile("music/savage.mp3");
  songList[3] = minim.loadFile("music/girls.mp3");
  songList2[3] = minim.loadFile("music/girls.mp3");
  whoosh = minim.loadFile("music/whoosh.mp3");
  punch = minim.loadFile("music/punch.mp3");
  gun = minim.loadFile("music/gun.wav");
  magic = minim.loadFile("music/magic.wav");
  menu = minim.loadFile("music/menu.mp3");
  
  // Text initialize
  txt = loadStrings("list.txt");
  
  songTitle[0] = "Black Mamba";
  songTitle[1] = "Next Level";
  songTitle[2] = "Savage";
  songTitle[3] = "Girls";
  
  // Font initialize
  tFont = createFont("GoodTimingRg-Bold", 45);
  titleFont = createFont("CROWDEN-Regular", 102);
  effectFont = createFont("CROWDEN-Regular", 102);
  
  // OSC related initialize
  oscP5_motion= new  OscP5(this, portInputMotion); // Input port number from Wekinator1 (motion)
  oscP5_draw= new  OscP5(this, portInputDraw); // Input port number from Wekinator2 (draw)
  dest = new NetAddress("127.0.0.1", portOutput); // Output port number to Wekinatotor
}

/* Draw *///////////////////////////////////////////////////////////////////////////////////
void draw(){
  time = frameTime/60;
  background(0);
  stageSelector();
  frameTime++;
}


/* Custom Function *////////////////////////////////////////////////////////////////////////////
void stageSelector() { // Move on to next step according to current stage
  if (currentStage == Stage.Setting) {
    mainMenu();
  }
  else if (currentStage == Stage.Select) {
    selectMusic();
  }
  else if (currentStage == Stage.Prepare) {
  }
  else if (currentStage == Stage.Play) {
    gameManager();
  }
}

void mainMenu(){
  imageMode(CENTER);
  image(background2, width/2, height/2, width, height);
  pushMatrix();
  textAlign(CENTER, CENTER);
  
  textSize(150);
  textFont(titleFont);
  fill(#3d3d77);
  for (int x = -5; x < 6; x++) {
    text("SYNK AESPA", width/2 + x, height/2 - 70);
    text("SYNK AESPA", width/2, height/2 + x - 70);
  }
  fill(#d7e0ed);
  text("SYNK AESPA", width/2, height/2 - 70);
  
  
  textSize(20);
  textFont(tFont);
  fill(#d9e6e7);
  noStroke();
  text("TURN YOUR PHONE UP\nTO START!", width/2, height/2 + 120);
  popMatrix();
  
  player.pointer();
  fill(255,0,0);
  circle(player.x, player.y, 10);
  player.draw();
}

void selectMusic(){
  imageMode(CENTER);
  image(background2, width/2, height/2, width, height);
  
  player.draw();
  
  pushMatrix();
  // left 
  if (songNum == 0){
    image(albums[songCnt - 1], 200, height/2, 300, 300);
  } else {
    image(albums[songNum - 1], 200, height/2, 300, 300);
  }
  
  // right
  if (songNum == songCnt - 1){
    image(albums[0], width - 200, height/2, 300, 300);
  } else {
    image(albums[songNum + 1], width - 200, height/2, 300, 300);
  }
  
  // center
  image(albums[songNum], width/2, height/2, 500, 500);
  rectMode(CENTER);
  fill(255, 160);
  rect(width/2, height - 100, textWidth(songTitle[songNum])+80, 60, 50);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(50);
  textFont(tFont);
  text(songTitle[songNum], width/2, height - 105);
  
  rectMode(CENTER);
  fill(0, 160);
  rect(135, 40, textWidth("Select Music")+60, 50);
  textAlign(LEFT, CENTER);
  textSize(40);
  fill(255);
  text("Select Music", 30, 35);
  
  if (songList[songNum].isPlaying()==false) songList[songNum].play();
  
  popMatrix();
}

void gameManager(){
  if(gameFinished==false){
    systemManager();
    //test();
  }
  else gameResult();
}

void systemManager(){
  // Play music after delay
  if (frameTime - gameStartTime > (width-hitzone.x-hitzone.x)/speed) {
    songList2[songNum].play();
    
    gameStart = true;
  }
  
  fft.forward(songList[songNum].mix);
  
  // Generate note //
  if(fft.getFreq(1)>10 && noteFrame > noteDelay){
    if (longChk == false){
      float n = random(1);
      if (n > 0.6) {
        Note note = new Note(0);
      }
      else if (n > 0.2) {
        Note note = new Note(2);
      }
      else if (n > 0.1) {
        Note note = new Note(1);
      }
      else {
        Note note = new Note(3);
      }
      noteFrame = 0;
    }
  }
  noteFrame++;
  
  // Draw background //
  imageMode(CENTER);
  image(background2, width/2, height/2, width, height);
  
  // Draw mamba //
  rectMode(CORNER);
  stroke(0);
  strokeWeight(2);
  fill(150);
  rect(width/2, height - hitzone.y, width/2 - screenMargin, 30);
  noStroke();
  fill(255,30,30);
  rect(width/2 + 1, height - hitzone.y + 1, map(mamba.hp, 0, mamba.maxHp, 0, width/2 - screenMargin - 2), 28);
  textAlign(RIGHT, CENTER);
  fill(0);
  textFont(tFont);
  textSize(35);
  text("Black Mamba", width - screenMargin, height - hitzone.y - 30);
  mamba.draw();
  
  // draw characters
  for (int i = characters.length - 1; i>=0; i--){
    characters[i].draw();
  }
  
  // Draw ui //
  // hitzone
  noStroke();
  fill(255,255,255,70);
  arc(width - hitzone.x, hitzone.y, hitzone.size, hitzone.size, -HALF_PI, HALF_PI);
  rectMode(CENTER);
  rect(width/2, hitzone.y, width - hitzone.x*2, hitzone.size);
  hitzone.draw();
  
  // score
  textAlign(LEFT, CENTER);
  textFont(effectFont);
  textSize(50);
  fill(255);
  text(score, hitzone.x - hitzone.size, height-hitzone.y);
  
  // combo
  textAlign(CENTER, CENTER);
  textFont(effectFont);
  textSize(50);
  fill(#fffc06);
  if (combo>0) text(str(combo)+"combo", width/2, hitzone.y - 70);
  
  // Draw notes //
  for (int i = noteList.size() - 1; i >= 0; i--) {
     Note note = noteList.get(i);
     note.draw();
  }
  
  player.draw();
  
  if (gameStart == true && songList2[songNum].isPlaying() == false) gameFinished = true;
}

//void test(){
//  player.pointer();
  
//  int drawingNum = 3;
  
//  imageMode(CENTER);
//    if (drawingNum == 0){ // heart
//      image(heart, width/2, height/2, width/10*6, width/10*6*2/3);
//    }
//    else if (drawingNum ==1){ // moon
//      image(moon, width/2, height/2, width/10*6, width/10*6*2/3);
//    }
//    else if (drawingNum ==2){ // star
//      image(star, width/2, height/2, width/10*6, width/10*6*2/3);
//    }
//    else { // butterfly
//      image(butterfly, width/2, height/2, width/10*6, width/10*6*2/3);
//    }
  
//  if (drawingNum == 0 && player.drawingChk1 == 2) {
//        canvas.stroke(0, 255, 0);
//      }
//      else if (drawingNum == 1 && player.drawingChk2 == 2){
//        canvas.stroke(0, 255, 0);
//      }
//      else if (drawingNum == 2 && player.drawingChk3 == 2) {
//        canvas.stroke(0, 255, 0);
//      }
//      else if (drawingNum == 3 && player.drawingChk4 == 2) {
//        canvas.stroke(0, 255, 0);
//      }
//      else {
//        canvas.stroke(255, 0, 0);
//      }
      
//  canvas.beginDraw();
//  canvas.strokeWeight(10);
//  canvas.fill(255,0,0);
//  canvas.rect(width/2, height/2, 100, 100);
//  canvas.circle(player.x, player.y, 10);
//  canvas.endDraw();
//  image(canvas, width/2, height/2);
  
//  stroke(0,100,100);
//  point(player.x, player.y, 10);
//  circle(player.x, player.y, 10);
//  player.draw();
//  println(player.x, player.y);
  
//  sendOsc();
//}

void gameResult(){
  textFont(tFont);
  String finalScore = "Your Score : ";
  finalScore += str(score);
  String maxComboScore = "Max Combo : ";
  maxComboScore += str(maxCombo);
  String karinaScore = "Karina : ";
  karinaScore += str(characters[0].point);
  String giselleScore = "Giselle : ";
  giselleScore += str(characters[1].point);
  String winterScore = "Winter : ";
  winterScore += str(characters[2].point);
  String ningningScore = "Ningning : ";
  ningningScore += str(characters[3].point);
  String perfectScore = "Perfect : ";
  perfectScore += str(perfect);
  String goodScore = "Good : ";
  goodScore += str(good);
  String badScore = "Bad : ";
  badScore += str(bad);
  String missScore = "Miss : ";
  missScore += str(miss);

  imageMode(CENTER);
  image(background2, width/2, height/2, width, height);
  
  pushMatrix();
  fill(255, 80);
  stroke(0);
  rectMode(CENTER);
  rect(width/2, height/2, width/10*8, height/10*9);
  
  textAlign(CENTER,CENTER);
  textSize(80);
  if (mamba.state == 2) {
    fill (#24d612);
    text ("Mission Complete", width/2, height*1/7);
  }
  else {
    fill (#fa1f1f);
    text ("Mission Failed", width/2, height*1/7);
  }
  
  textFont(tFont);
  fill(255);
  textSize(65);
  text(finalScore, width/2, height*2/7);
  
  textSize(45);
  textAlign (LEFT, CENTER);
  fill(#efd43d);
  text(maxComboScore, width/10*1 + 50, height*4/10 + 10);
  
  fill(0);
  text(karinaScore, width/10*1 + 50, height*5/10 + 10);
  text(giselleScore, width/10*1 + 50, height*6/10 + 10);
  text(winterScore, width/10*1 + 50, height*7/10 + 10);
  text(ningningScore, width/10*1 + 50, height*8/10 + 10);
  
  stroke(0);
  strokeWeight(3);
  line(width/2, height/2 - 5 , width/2, height*9/10 - 30);
  
  text(perfectScore, width/10*5 + 50, height*5/10 + 10);
  text(goodScore, width/10*5 + 50, height*6/10 + 10);
  text(badScore, width/10*5 + 50, height*7/10 + 10);
  text(missScore, width/10*5 + 50, height*8/10 + 10);
  popMatrix();
}

/* OSC Related *///////////////////////////////////////////////////////////////////////////////////
void sendOsc() {
  OscMessage msg = new OscMessage(addr_to);
  msg.add(player.x); 
  msg.add(player.y);
  oscP5_draw.send(msg, dest);
}

// automatically called whenever osc message is received
void oscEvent(OscMessage m) {
  // Motion Data from Wekinator_Motion
  if (m.checkAddrPattern(addr_fromMotion)==true) {
     player.hori = m.get(0).floatValue();
     player.verti = m.get(1).floatValue();
     
     if (m.get(2).floatValue() > 8) player.acc = true;
     else player.acc = false;
     
     player.action = int(m.get(3).floatValue());
  }
  
  // Drawing classification from Wekinator_Draw
  if (m.checkAddrPattern(addr_fromDraw)==true) {
    player.drawingChk1 = int(m.get(0).floatValue());
    player.drawingChk2 = int(m.get(1).floatValue());
    player.drawingChk3 = int(m.get(2).floatValue());
    player.drawingChk4 = int(m.get(3).floatValue());
  }
  
}

void keyPressed(){
  //if(noteList.size()>0){
  //  // Punch
  //  if (noteList.get(noteList.size()-1).active==true){
  //        noteList.get(noteList.size()-1).shortJudge();
  //  }
  //}
  
  //if(currentStage == Stage.Setting){
  //  if (key == ' ') {
  //    gameStartTime = frameTime;
  //    currentStage = Stage.Select;
  //  }
  //}
  //else if (currentStage == Stage.Select){
  //  if (key == ' ') {
  //       for(int i = 0; i < songCnt; i++) songList[songNum].pause();
  //       gameStartTime = frameTime;
  //       currentStage = Stage.Play;
  //       fft = new FFT(songList[songNum].bufferSize(), songList[songNum].sampleRate());
  //       songList[songNum].play();
  //       songList[songNum].setGain(-100);
  //    }
  //}
  
  textbox.KEYPRESSED(key, (int)keyCode);
}
