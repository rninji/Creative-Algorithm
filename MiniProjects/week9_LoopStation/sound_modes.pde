void sinMode(){
  if (keyPressed&&key==' '){
      sine.play();
      float freq=map(ML_Out, 0, 1, 80.0, 1000.0);
      sine.freq(freq);
  }
}

void sqrMode(){
  if (keyPressed&&key==' '){
      square.play();
      float freq=map(ML_Out, 0, 1, 80.0, 1000.0);
      square.freq(freq);
  }
}

void triMode(){
  if (keyPressed&&key==' '){
      triangle.play();
      float freq=map(ML_Out, 0, 1, 80.0, 1000.0);
      triangle.freq(freq);
  }
}

void sawMode(){
  if (keyPressed&&key==' '){
      saw.play();
      float freq=map(ML_Out, 0, 1, 80.0, 1000.0);
      saw.freq(freq);
  }
}

void kickMode(){
  if (hit){
    kickPlayer.rewind();
    kickPlayer.play();
  }
  hit = false;
}

void snareMode(){
  if (hit){
    snarePlayer.rewind();
    snarePlayer.play();
  }
  hit = false;
}

void hatClMode(){
  if (hit){
    hatClPlayer.rewind();
    hatClPlayer.play();
  }
  hit = false;
}

void hatOpMode(){
  if (hit){
    hatOpPlayer.rewind();
    hatOpPlayer.play();
  }
  hit = false;
}
