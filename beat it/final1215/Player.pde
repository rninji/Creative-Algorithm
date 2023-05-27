class Player{
  float hori = 0, verti = 0;
  int action, action_prev; // 1 : forward, 2 : left, 3 : right, 4 : up
  float x, y;
  boolean acc, acc_prev;
  int drawingChk1, drawingChk2, drawingChk3, drawingChk4; // 1 : on the line, 2 : out of the line
  
  Player(){
    
  }
  
  void pointer() {
    this.x = map(hori, 0, 10, 0, width);
    this.y = map(verti, 0, 10, 0, height);
  }
  
  void act(){
     if (this.action == 4){
      // change screen
      if (currentStage == Stage.Setting){
         currentStage = Stage.Select;
         menu.rewind();
         menu.play();
      }
      
      else if (currentStage == Stage.Select){
        for(int i = 0; i < songCnt; i++) {
          songList[songNum].rewind();
          songList[songNum].pause();
        }
         gameStartTime = frameTime;
         menu.rewind();
         menu.play();
         currentStage = Stage.Play;
         fft = new FFT(songList[songNum].bufferSize(), songList[songNum].sampleRate());
         songList[songNum].play();
         songList[songNum].setGain(-100);
      }
      else{
        // gun
          if(noteList.size()>0){
            if (noteList.get(noteList.size()-1).active==true && noteList.get(noteList.size()-1).skill==2){
                  noteList.get(noteList.size()-1).shortJudge();
                  gun.rewind();
                  gun.play();
            }
          }
        }
      }
    
    
    // left
    if (this.action == 2 && this.action_prev == 1 && currentStage == Stage.Select){
       songList[songNum].rewind();
       songList[songNum].pause();
       if (songNum == 0) songNum = songCnt-1;
       else songNum --;
       whoosh.rewind();
       whoosh.play();
    }
    
    // right
    if (this.action == 3 && this.action_prev == 1 && currentStage == Stage.Select){
      songList[songNum].rewind();
      songList[songNum].pause();
      if (songNum == songCnt-1) songNum = 0; 
      else songNum ++;
      whoosh.rewind();
      whoosh.play();
    }
    
  }
  
  void punch(){
    if(noteList.size()>0){
      // punch
      if (this.acc == true){
        if (noteList.get(noteList.size()-1).active==true && noteList.get(noteList.size()-1).skill==0){
              noteList.get(noteList.size()-1).shortJudge();
              punch.rewind();
              punch.play();
        }
      }
      
    }
  }
  
  void actionManager(){
    if (this.action != this.action_prev){
      act();
    }
    action_prev = action;
    
    if (this.acc != this.acc_prev ){
      punch();
    }
    this.acc_prev = this.acc;
  }
  
  void draw(){
    actionManager();
  }
  
}
