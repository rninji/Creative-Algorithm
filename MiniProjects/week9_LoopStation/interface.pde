void ui(){
  int k = 0;
  for (int i=0; i<2; i++){
    for (int j=0; j<4; j++){
      stroke(0);
      fill(inst[k].c);
      rect(width/4*j,height/2*i+100*i,width/4,height/2-100);
      fill(0);
      textAlign(CENTER);
      textSize(30);
      textLeading(30);
      text(inst[k].num, width/4*j+width/8, height/2*i+height/4-20);
      text(inst[k].name, width/4*j+width/8, height/2*i+height/4+20);
      k++;
    }
  }
  
  stroke(255);
  strokeWeight(1);
  for(int i = 0; i < in.left.size()-1; i++)
  {
    line(i, height/2 + in.left.get(i)*50, i+1, height/2 + in.left.get(i+1)*50);
    line(i, height/2 + in.right.get(i)*50, i+1, height/2 + in.right.get(i+1)*50);
  }
}
