class Note{
  float x, y;
  int skill; // 0 : punch, 1 : xeno, 2 : gun, 3 : draw
  //int frameNum;
  int judgementResult; // 0 : perfect, 2 : good, 3 : bad, 4 : miss
  int size;
  boolean active;
  float activeZone;
  boolean judgement;
  int judgementDelay;
  
  int duration;
  int leng;
  int mistake;
  int drawingNum;
  
  int textNum;
  String [] randomText;
  
  color backColor;
  
  Note(int _skill){
    this.x = width - hitzone.x;
    this.y = hitzone.y;
    this.skill = _skill;
    this.size = 70;
    this.active = false;
    this.activeZone = (this.size + hitzone.size)/2*1.2;
    this.judgement = false;
    this.judgementDelay = 0;
    if (this.skill == 0) {
      this.duration = 0;
      this.backColor = color(200,255,255,80);
    }
    else if (this.skill == 2) {
      this.duration = 0;
      this.backColor = color(200,200,255,80);
    }
    else if (this.skill == 1){
      this.duration = int(random(100,250))*3;
      longChk = true;
      this.backColor = color(255,255,200,80);
    }
    else {
      this.duration = int(random(50,100))*3;
      longChk = true;
      this.backColor = color(255,200,200,80);
    }
    this.leng = duration;
    this.mistake = 0;
    this.drawingNum = int(random(4));
    
    this.textNum = int(random(txt.length));
    this.randomText = txt[textNum].split(", ");
    
    noteList.add(0, this);
  }
  
  void draw(){
    pushMatrix();
    this.chkActive();
    
    // Display judgement result
    if (judgement){
      textFont(tFont);
      textSize(40);
      textAlign(CENTER);
      if (judgementResult == 0){
        fill(#03c1ff);
        text("Perfect", hitzone.x, hitzone.y - 50);
      }
      else if (judgementResult == 1){
        fill(#ffc703);
        text("Good", hitzone.x, hitzone.y - 50);
      }
      else if (judgementResult == 2){
        fill(#b049eb);
        text("Bad", hitzone.x, hitzone.y - 50);
      }
      else {
        fill(#f80612);
        text("Miss", hitzone.x, hitzone.y - 50);
      }
      judgementDelay++;
      
      // Remove note
      if (judgementDelay > 20) {
        noteList.remove(noteList.size()-1);
      }
    }
    
    // Draw the note (circle)
    else{
      // long note
      if (skill == 1 || skill == 3) {
        //for (float i = this.leng; i>=0; i-=speed*2){
        //  if (this.x+i > hitzone.x && this.x+i < width - hitzone.x){
        //    fill(this.backColor);
        //    noStroke();
        //    circle(this.x+i, this.y, size);
        //  }
        //}
        
        fill(this.backColor);
        noStroke();
        rectMode(CORNER);
        if (this.x > hitzone.x && this.x+this.leng < width - hitzone.x){
          arc(this.x, this.y, this.size, this.size, HALF_PI, HALF_PI + PI);
          rect(this.x, this.y-this.size/2, this.leng, this.size);
          arc(this.x+this.leng, this.y, this.size,this.size, -HALF_PI, HALF_PI);
        }
        else if (this.x > hitzone.x && this.x+this.leng >= width - hitzone.x){
          arc(this.x, this.y, this.size, this.size, HALF_PI, HALF_PI + PI);
          rect(this.x, this.y-this.size/2, width - hitzone.x - this.x, this.size);
          arc(width - hitzone.x, this.y, this.size, this.size, -HALF_PI, HALF_PI);
        }
        else if (this.x <= hitzone.x && this.x+this.leng < width - hitzone.x && this.x+this.leng > hitzone.x) {
          arc(hitzone.x, hitzone.y, this.size, this.size, HALF_PI, HALF_PI + PI);
          rect(hitzone.x, this.y-this.size/2, this.leng + this.x - hitzone.x, this.size);
          arc(this.x+this.leng, this.y, this.size, this.size, -HALF_PI, HALF_PI);
        }
   
        if (this.x > hitzone.x) {
          if(skill == 1) image(giselle_weapon, this.x, this.y, this.size, this.size);
          else image(ningning_weapon, this.x, this.y, this.size, this.size);
        }
        
        if (this.x + this.leng <= width-hitzone.x && this.x + this.leng > width-hitzone.x - speed) {
          longChk = false;
          noteFrame = 0;
        }
      }
      
      // short note
      else {
        fill(this.backColor);
        noStroke();
        circle(this.x, this.y, size);
        if(skill == 0) image(karina_weapon, this.x, this.y, this.size, this.size);
        else image(winter_weapon, this.x, this.y, this.size, this.size);
      }
    }
    popMatrix();
    
    // Move the note
    x-=speed;
  }
  
  void chkActive (){
    
    // long note
    if (skill == 1 || skill == 3){
      //if (this.x <= hitzone.x && this.x + this.duration > hitzone.x){
        if (this.x <= hitzone.x && this.duration >= 0){
          if (skill == 1){ // text
            textEntering();
          }
          else if (skill == 3){ // drawing
            drawing();
          }
      }
    }
    
    // short note
    else {
      if (abs(this.x - hitzone.x) < this.activeZone) { // active
        this.active = true;
      }
      else if(abs(this.x - hitzone.x) > this.activeZone && this.active == true){ // miss
        judgementResult = 3;
        addScore();
      }
    }
  }
  
  void textEntering(){
    // presenting word
    textFont(tFont);
    fill(255, 70);
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    rect(width/2, height/2 - 90, width/2, 150);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(80);
    text(randomText[0], width/2, height/2 - 90);
    
    // textbox
    textAlign(LEFT, CENTER);
    rectMode(CORNER);
    textbox.DRAW();
    textJudge();
  }
  
  void drawing(){
    imageMode(CENTER);
    if (this.drawingNum == 0){ // heart
      image(heart, width/2, height/2, width/10*6, width/10*6*2/3);
    }
    else if (this.drawingNum ==1){ // moon
      image(moon, width/2, height/2, width/10*6, width/10*6*2/3);
    }
    else if (this.drawingNum ==1){ // star
      image(star, width/2, height/2, width/10*6, width/10*6*2/3);
    }
    else { // butterfly
      image(butterfly, width/2, height/2, width/10*6, width/10*6*2/3);
    }
    
    drawingJudge();
  }
  
  void shortJudge(){
    if(judgement==false){
      if (abs(this.x - hitzone.x) < activeZone/4) { // perfect
        judgementResult = 0;
      }
      else if (abs(this.x - hitzone.x) < activeZone/3) { // good
        judgementResult = 1;
      }
      else {// bad
        judgementResult = 2;
      }
      addScore();
    }
  }
  
  void textJudge(){
    duration-=speed;
    if (duration < 0){
      if (textbox.Text.equals(randomText[1])) {
        judgementResult = 0; // perfect
        magic.rewind();
        magic.play();
      }
      else {
        judgementResult = 3; // miss
      }
      judgement = true;
      textbox.DELETE();
      addScore();
    }
  }
  
  void drawingJudge(){
    duration-=speed;
    sendOsc();
    
    // final judge
    if (duration <= 0){
      if (mistake < leng/speed*0.3) {
        judgementResult = 0; // perfect
        magic.rewind();
        magic.play();
      }
      else if (mistake < leng/speed*0.5) {
        judgementResult = 1; // good
        magic.rewind();
        magic.play();
      }
      else if (mistake < leng/speed*0.7) {
        judgementResult = 2; // bad
        magic.rewind();
        magic.play();
      }
      else {
        judgementResult = 3; // miss
      }
      judgement = true;
      canvas.beginDraw();
      canvas.clear();
      canvas.endDraw();
      addScore();
    }
    
    else {
      player.pointer();
      
      canvas.beginDraw();
      if (this.drawingNum == 0 && player.drawingChk1 == 2) {
        mistake++;
        canvas.fill(255, 0, 0);
      }
      else if (this.drawingNum == 1 && player.drawingChk2 == 2){
        mistake++;
        canvas.fill(255, 0, 0);
      }
      else if (this.drawingNum == 2 && player.drawingChk3 == 2) {
        mistake++;
        canvas.fill(255, 0, 0);
      }
      else if (this.drawingNum == 3 && player.drawingChk4 == 2) {
        mistake++;
        canvas.fill(255, 0, 0);
      }
      else {
        canvas.fill(0, 255, 0);
      }
      
      canvas.circle(player.x, player.y, 10);
      canvas.endDraw();
      image(canvas, width/2, height/2);
    }
  }
  
  void addScore(){
    if (judgementResult == 0){
      combo++;
      score += 100 * ((combo)/20+1);
      characters[this.skill].point += 100;
      characters[this.skill].changeState();
      perfect++;
      mamba.changeState();
    }
    else if (judgementResult == 1){
      combo++;
      score += 50 * ((combo)/20+1);
      characters[this.skill].point += 50;
      characters[this.skill].changeState();
      good++;
      mamba.changeState();
    }
    else if (judgementResult == 2){
      score += 20 * ((combo)%20+1);
      characters[this.skill].point += 20;
      characters[this.skill].changeState();
      bad++;
      combo = 0;
      mamba.changeState();
    }
    else {
      miss++;
      combo = 0;
    }
    
    if (maxCombo < combo) maxCombo = combo;
    judgement = true;
  }
  
  
}
