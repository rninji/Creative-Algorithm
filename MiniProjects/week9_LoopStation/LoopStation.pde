import ddf.minim.*;
import ddf.minim.ugens.*;
import processing.sound.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

SinOsc sine;
TriOsc triangle;
SawOsc saw;
SqrOsc square;

Minim minim;
AudioPlayer kickPlayer;
AudioPlayer snarePlayer;
AudioPlayer hatClPlayer;
AudioPlayer hatOpPlayer;
String kickFileName = "kick.wav";
String snareFileName = "snare.wav";
String hatClFileName = "hatCl.mp3";
String hatOpFileName = "hatOp.wav";

// for recording
AudioInput in;
AudioRecorder recorder1, recorder2, recorder3, recorder4, 
recorder5, recorder6, recorder7, recorder8;

// for playing back
AudioOutput out;
FilePlayer player1, player2, player3, player4, player5, 
player6, player7, player8;

String saveFileName = "results.wav";

int mode = 0;
boolean hit = false;
float ML_Out = 0; 

int chkLength = 5;
boolean chk[] = new boolean[chkLength];

Inst inst[] = new Inst[8];

void setup(){
  size(1080, 720);
  
  /* start oscP5, listening  for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6448);
  
  minim = new Minim(this);
  
  // set wave sounds
  sine = new SinOsc(this);
  sine.amp(1);
  triangle = new TriOsc(this);
  triangle.amp(1);
  saw = new SawOsc(this);
  saw.amp(1);
  square = new SqrOsc(this);
  square.amp(1);
  
  // set drum soundfiles
  kickPlayer = minim.loadFile(kickFileName, 2048);
  snarePlayer = minim.loadFile(snareFileName, 2048);
  hatClPlayer = minim.loadFile(hatOpFileName, 2048);
  hatOpPlayer = minim.loadFile(hatClFileName, 2048);
 
 // get a stereo line-in
  in = minim.getLineIn(Minim.STEREO, 2048);
  // create an AudioRecorders
  recorder1 = minim.createRecorder(in, saveFileName);
  recorder2 = minim.createRecorder(in, saveFileName);
  recorder3 = minim.createRecorder(in, saveFileName);
  recorder4 = minim.createRecorder(in, saveFileName);
  recorder5 = minim.createRecorder(in, saveFileName);
  recorder6 = minim.createRecorder(in, saveFileName);
  recorder7 = minim.createRecorder(in, saveFileName);
  recorder8 = minim.createRecorder(in, saveFileName);
  
  // get an output we can playback the recording on
  out = minim.getLineOut( Minim.STEREO );
  
  // initialize check array
  for (int i=0; i<chkLength; i++){
    chk[i] = false;
  }
  
  // create inst objects
  inst[0] = new Inst(1, "sine");
  inst[1] = new Inst(2, "square");
  inst[2] = new Inst(3, "triangle");
  inst[3] = new Inst(4, "saw");
  inst[4] = new Inst(5, "kick");
  inst[5] = new Inst(6, "snare");
  inst[6] = new Inst(7, "hi-hat\nopened");
  inst[7] = new Inst(8, "hi-hat\nclosed");
}

void draw(){
  background(0);
  
  ui();
  
  if (mode==1){
    sinMode();
  }
  else if (mode==2){
    sqrMode();
  }
  else if (mode==3){
    triMode();
  }
  else if (mode==4){
    sawMode();
  }
  else if (mode==5){
    kickMode();
  }
  else if (mode==6){
    snareMode();
  }
  else if (mode==7){
    hatClMode();
  }
  else if (mode==8){
    hatOpMode();
  }
  
}

void keyPressed(){
  sine.stop();
  square.stop();
  triangle.stop();
  saw.stop();
  
  // change modes
  if (key=='1'){ //sine
    if (inst[0].state==1){
      mode=1;
      inst[0].record();
    }
    else if(inst[0].state==2){
      mode=0;
      inst[0].finish();
    }
  }
  else if (key=='2'){ //square
    if (inst[1].state==1){
      mode=2;
      inst[1].record();
    }
    else if(inst[1].state==2){
      mode=0;
      inst[1].finish();
    }
  }
  else if (key=='3'){ //triangle
    if (inst[2].state==1){
      mode=3;
      inst[2].record();
    }
    else if(inst[2].state==2){
      mode=0;
      inst[2].finish();
    }
  }
  else if (key=='4'){ //saw
    if (inst[3].state==1){
      mode=4;
      inst[3].record();
    }
    else if(inst[3].state==2){ 
      mode=0;
      inst[3].finish();
    }
  }
  else if (key=='5'){ //kick
    if (inst[4].state==1){
      mode=5;
      inst[4].record();
    }
    else if(inst[4].state==2){ //snare
      mode=0;
      inst[4].finish();
    }
  }
  else if (key=='6'){ //snare
    if (inst[5].state==1){
      mode=6;
      inst[5].record();
    }
    else if(inst[5].state==2){
      mode=0;
      inst[5].finish();
    }
  }
  else if (key=='7'){ //hi-hat opened
    if (inst[6].state==1){
      mode=7;
      inst[6].record();
    }
    else if(inst[6].state==2){
      mode=0;
      inst[6].finish();
    }
  }
  else if (key=='8'){ //hi-hat closed
    if (inst[7].state==1){
      mode=8;
      inst[7].record();
    }
    else if(inst[7].state==2){
      mode=0;
      inst[7].finish();
    }
  }
  
}

void keyReleased(){
  sine.stop();
  square.stop();
  triangle.stop();
  saw.stop();
}

// automatically called whenever osc message is received
void oscEvent(OscMessage m) {

  /* check if theOscMessage has the address pattern we are looking for. */
  if (m.checkAddrPattern("/wek/outputs")==true) {

    /* check if the typetag is the right one. */
    if (m.checkTypetag("ff")) {

      /* extract the values from the osc message */
      ML_Out = m.get(0).floatValue();  // get the first osc argument
      //println(ML_Out);
      
      // update chk array
      hit = true;
      for (int i=0; i<chkLength; i++){
        if (i==chkLength-1){
          if((int)m.get(1).floatValue()==1){
            chk[i] = true;
          }
          else {
            chk[i] = false;
            hit = false;
          }
        }
        else{
          chk[i] = chk[i+1];
          if (chk[i]==true) hit = false;
        }
      }
      
    }
  }
}
