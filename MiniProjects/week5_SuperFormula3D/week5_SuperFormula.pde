import peasy.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

FFT fft;
AudioPlayer track;
Minim minim;
PeasyCam cam;

//String audioFileName = "limitless.mp3";
String audioFileName = "short.mp3";


float fps = 60;
PVector[][] globe;


void setup(){
  size(1000,800, P3D);
  smooth(8);
  
  frameRate(fps);
  
  globe = new PVector[total+1][total+1];
  
  minim = new Minim(this);
  track = minim.loadFile(audioFileName, 2048);
  track.loop();
  fft = new FFT(track.bufferSize(), track.sampleRate());
  
  cam = new PeasyCam(this, 0, 0, 0, 800);
}

void draw(){
  
  background(0);
 
  
  cam.beginHUD();
  
  //spectrum
  //mix buffer
  fft.forward(track.mix);
  
  strokeWeight(1);
  for(int i=0; i < fft.specSize(); i++){
    stroke(random(255),random(255),random(255));
    line(i, height, i+30, height - fft.getBand(i)*5);
    line(i+30, height - fft.getBand(i)*5, i+60, height-5);
    line(width-i, 0, width-i-30, fft.getBand(i)*5);
    line(width-i-30, 0 + fft.getBand(i)*5, width-i-60, 5);
  }
  
  stroke(255);
  strokeWeight(6);
  
  for(int i =0; i < track.bufferSize() - 1; i++) {
    line(100 + track.left.get(i)*50, map(i, 0, track.bufferSize(), 0, height), 
    100 + track.left.get(i+1)*50 , map(i+1, 0, track.bufferSize(), 0, height));
    line(width-100 -track.right.get(i)*50, map(i, 0, track.bufferSize(), height, 0), 
    width-100 -track.right.get(i+1)*50, map(i+1, 0, track.bufferSize(), height, 0));
  }
  cam.endHUD();
  
  lights();
  shape();
  
}


void keyPressed(){
  if (track.isPlaying()) {
    track.pause();
  } else {
    track.play();
  }
}
