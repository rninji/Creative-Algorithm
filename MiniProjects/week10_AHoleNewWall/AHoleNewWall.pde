/* Library *///////////////////////////////////////////////////////////////////////////////////
import oscP5.*;
import netP5.*;
import processing.sound.*;

/* OSC Info *//////////////////////////////////////////////////////////////////////////////////
OscP5 oscP5_weki;
NetAddress dest_weki;
OscP5 oscP5_oscHook1;
OscP5 oscP5_oscHook2;
OscP5 oscP5_oscHook3;

// Port Number
int portOsc1 = 4040;
int portOsc2 = 9999;
int portOsc3 = 6449;

// Address Pattern (from phone)
String addrOsc1 = "/oschook";
String addrOsc2 = "/gyrosc/gyro";
String addrOsc3 = "/wek/inputs";

// Address Pattern (to wekinator)
String addrWek_to = "/wek/realinputs";
String addrWek_from = "/wek/outputs";

/* Game Variable */////////////////////////////////////////////////////////////////////////////
// Player //
Player player1, player2, player3;

// Controllable Game Setting //
int screenMargin = 50;
int gameStartTime = 0;
int gameOnceTime = 10;
int gameBreakTime = 3;

int player1Color = 50;
int player2Color = 170;
int player3Color = 280;

// Game Information //
int frameTime = 0;
int time = 0;
int startTime = 0;
int score = 0;
int life = 3;

SoundFile soundfile;
SoundFile bgm;
SoundFile rotate;
SoundFile success;
int volumeSize = 0 ;

Wall wall;
int wallSize = 0;

boolean isHitCheck = false;
boolean isHit = false;

PFont font;

public enum Stage{
  Setting, Prepare, Play;
};
private Stage currentStage = Stage.Setting;

/* Setup *///////////////////////////////////////////////////////////////////////////////////
void setup() {
  size(1920, 1080);
  //fullScreen();
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
  
  // Class init
  player1 = new Player();
  player2 = new Player();
  player3 = new Player();
  wall = new Wall();
  
  // Player Setting
  player1.playerColor = player1Color;
  player2.playerColor = player2Color;
  player3.playerColor = player3Color;
  
  // OSC related initialize
  oscP5_weki = new OscP5(this, 12000); // Input port number from Wekinator
  dest_weki = new NetAddress("127.0.0.1", 6448); // Output port number to Wekinatotor
  oscP5_oscHook1= new  OscP5(this, portOsc1); // Input port number from OscHook
  oscP5_oscHook2= new  OscP5(this, portOsc2); // Input port number from OscHook
  oscP5_oscHook3= new  OscP5(this, portOsc3); // Input port number from OscHook

  // Font initialize
  font = createFont("Gamer.ttf",32);
  
  // Sound initialize
  soundfile = new SoundFile(this, "Rock Moving Sfx 13s.mp3");
  bgm = new SoundFile(this, "minigame3.wav");
  rotate  = new SoundFile(this, "rotate.mp3");
  success  = new SoundFile(this, "success.mp3");
  soundfile.rate(1.3);
}

/* Draw *///////////////////////////////////////////////////////////////////////////////////
void draw() {
  time = frameTime/60;
  background(0, 0, 100);
  pushMatrix();
  noStroke();
  fill(0, 0, 25);
  triangle(0, 0, width/2, height/2, width, 0);
  fill(0, 0, 30);
  triangle(0, 0, width/2, height/2, 0, height);
  triangle(width/2, height/2, width, 0, width, height);
  fill(0, 0, 40);
  triangle(width/2, height/2, 0, height, width, height);
  stroke(0);
  popMatrix();
  stageSelector();
  sendOsc();
  frameTime++;
}

/* Custom Function *////////////////////////////////////////////////////////////////////////////
void stageSelector() { // Move on to next step according to current stage
  if (currentStage == Stage.Setting) {
    mainMenu();
  }
  else if (currentStage == Stage.Prepare) {
  }
  else if (currentStage == Stage.Play) {
    gameManager();
    if(bgm.isPlaying()==false) bgm.play();
  }
}

void mainMenu() {
  player1.pointer();
  player1.drawTest();
  player2.pointer();
  player2.drawTest();
  player3.pointer();
  player3.drawTest();
  pushMatrix();
  textAlign(CENTER);
  fill(255);
  textFont(font);
  textSize(160);
  text("A HOLE NEW WALL", width/2, height/3);
  textSize(80);
  text("PRESS 'SPACE' TO START!", width/2, height*2/3);
  popMatrix();
}

boolean textTimer(String text, int startTime, int endTime) {
  if (time < startTime) return false;
  int lastingTime = endTime - startTime;
  if(time < lastingTime + startTime) {
    pushMatrix();
    textAlign(CENTER);
    fill(255);
    textFont(font);
    textSize(60);
    text(text, width/2, height/3);
    textSize(120);
    text(endTime-time, width/2, height*2/3);
    popMatrix();
    return true;
  }
  else {
    return false;
  }
}

void gameManager() {
  if(life > 0) {
    systemManager();
  }
  else gameOver();
}

void systemManager() {
  if (gameTimer(gameStartTime, gameStartTime + gameOnceTime)){
    wall.sizeRatio = wallSize / (60.0 * 10.0);
    wall.draw();
    
    // Sound
    if (wallSize ==0 & soundfile.isPlaying() == false) {
      soundfile.play();
      volumeSize = 0;
    }
    if (wallSize > 595) {
      soundfile.stop();
    }
    soundfile.amp(map (volumeSize, 0, 600, 0, 1 ));
    volumeSize++;
    
    player1.pointer();
    player1.draw();
    player2.pointer();
    player2.draw();
    player3.pointer();
    player3.draw();
    wallSize++;
  }
  else if (!isHitCheck) {
    wall.draw();
    player1.pointer();
    player1.draw();
    player2.pointer();
    player2.draw();
    player3.pointer();
    player3.draw();
    collisionMaster();
    isHitCheck = true;
  }
  else if (gameTimer(gameStartTime + gameOnceTime, gameStartTime + gameOnceTime + gameBreakTime)) {
    if (!isHit) { // Success!
      //println("Success!!");
      displayUI(1);
    }
    else if (isHit) { // Fail...
      //println("Fail...");
      displayUI(2);
    }
    player1.pointer();
    player1.draw();
    player2.pointer();
    player2.draw();
    player3.pointer();
    player3.draw();
  }
  else {
    gameStartTime += gameOnceTime + gameBreakTime; 
    if (!isHit) { // Success!
      score++;
    }
    else if (isHit) { // Fail...
      life--;
    }
    isHitCheck = false;
    isHit = false;
    wallSize = 0;
    wall.newHole();
  } 
}

boolean gameTimer(int startTime, int endTime) {
  if (time < startTime) return false;
  int lastingTime = endTime - startTime;
  if(time < lastingTime + startTime) {
    String leftTime = "TIME LEFT: ";
    leftTime += endTime-time;
    String currentScore = "SCORE: ";
    currentScore += score;
    String currentLife = "LIFE: ";
    currentLife += life;
    
    textAlign(LEFT,TOP);
    fill(255);
    textFont(font);
    textSize(60);
    text(leftTime, 20, 100);
    text(currentScore, 20, 140);
    text(currentLife, 20, 180);
    return true;
  }
  else {
    return false;
  }
}

void gameOver() {
  String finalScore = "Your Score: ";
  finalScore += str(score);

  pushMatrix();
  textAlign(CENTER,CENTER);
  fill(255);
  textFont(font);
  textSize(160);
  text("GAME OVER", width/2, height*2/5); 
  textSize(80);
  text(finalScore, width/2, height*4/5);
  popMatrix();
}

void displayUI(int num) {
  switch(num) {
    case 1:
      pushMatrix();
      textAlign(CENTER);
      fill(240,100,80);
      textFont(font);
      textSize(60);
      text("YOU MADE IT!!!", width/2, height/3);
      popMatrix();
      if(success.isPlaying()==false) success.play();
      break;
    case 2:
      pushMatrix();
      textAlign(CENTER);
      fill(0,100,80);
      textFont(font);
      textSize(60);
      text("TRY AGAIN...", width/2, height/3);
      popMatrix();
      break;
    case 3:
      break;
  }
}

void collisionMaster() {
  int maxCollider = wall.wallColliders.size();
  for(int colliderNum = 0; colliderNum < 4; colliderNum++) {
    for(int cellNum = 0; cellNum < maxCollider; cellNum++) {
      if(wall.wallColliders.get(cellNum).checkCollision(player1.shape.colliders.get(colliderNum))){
        isHit = true;
      }
    }
  }
}

void keyPressed() {
  if(currentStage == Stage.Setting){
    if (key == ' ') {
      gameStartTime = time;
      currentStage = Stage.Play;
    }
  }
}

/* OSC Related *///////////////////////////////////////////////////////////////////////////////////
void sendOsc() {
  OscMessage msg = new OscMessage(addrWek_to);
  msg.add(player1.receivedVar1);
  msg.add(player1.receivedVar2);
  msg.add(player1.receivedVar3);
  msg.add(player2.receivedVar1);
  msg.add(player2.receivedVar2);
  msg.add(player2.receivedVar3);
  msg.add(player3.receivedVar1);
  msg.add(player3.receivedVar2);
  msg.add(player3.receivedVar3);
  oscP5_weki.send(msg, dest_weki);
}

// automatically called whenever osc message is received
void oscEvent(OscMessage m) {
  
  if (m.checkAddrPattern(addrOsc1)==true) { // If data from OscHook1
    // Receive sensor data(orientation) from OscHook
    player1.receivedVar1 = m.get(0).floatValue();
    player1.receivedVar2 = m.get(1).floatValue();
    player1.receivedVar3 = m.get(2).floatValue();
    //println("Received 1: " + player1.receivedVar1 + "/" + player1.receivedVar2 + "/" + player1.receivedVar3);
  }
  
  if (m.checkAddrPattern(addrOsc2)==true) { // If data from OscHook2
    // Receive sensor data(orientation) from OscHook
    player2.receivedVar1 = m.get(0).floatValue();
    player2.receivedVar2 = m.get(1).floatValue();
    player2.receivedVar3 = m.get(2).floatValue();
    //println("Received 2: " + player2.receivedVar1 + "/" + player2.receivedVar2 + "/" + player2.receivedVar3);
  }
  
  if (m.checkAddrPattern(addrOsc3)==true) { // If data from OscHook3
    // Receive sensor data(orientation) from OscHook
    player3.receivedVar1 = m.get(0).floatValue();
    player3.receivedVar2 = m.get(1).floatValue();
    player3.receivedVar3 = m.get(2).floatValue();
    //println("Received 3: " + player3.receivedVar1 + "/" + player3.receivedVar2 + "/" + player3.receivedVar3);
  }
  
  if (m.checkAddrPattern(addrWek_from)==true) { // If data from Wekinator,
    // Receive machine-learned data from Wekinator
    // android1
    player1.hori = m.get(0).floatValue();
    player1.verti = m.get(1).floatValue();
    player1.roll = m.get(2).floatValue();
    // ios1
    player2.hori = m.get(3).floatValue();
    player2.verti = m.get(4).floatValue();
    player2.roll = m.get(5).floatValue();
    // ios2
    player3.hori = m.get(6).floatValue();
    player3.verti = m.get(7).floatValue();
    player3.roll = m.get(8).floatValue();
  }
}
