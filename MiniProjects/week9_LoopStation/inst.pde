// background colors
color def = #d3d3d3;
color rec = #d92121;
color fin = #03C04A;

int p = 0;

class Inst{
  int num;
  String name;
  color c;
  PImage icon;
  int state; // 1 : default, 2 : record, 3 : finish
  
  Inst(int _num, String _name){
    num = _num;
    name = _name;
    c = def;
    state = 1;
  }
  
  void record(){
    state = 2;
    c = rec;
    if(p==0) recorder1.beginRecord();
    else if(p==1) recorder2.beginRecord();
    else if(p==2) recorder3.beginRecord();
    else if(p==3) recorder4.beginRecord();
    else if(p==4) recorder5.beginRecord();
    else if(p==5) recorder6.beginRecord();
    else if(p==6) recorder7.beginRecord();
    else recorder8.beginRecord();
  }
  
  void finish(){
    state = 3;
    c = fin;
    
    if (p==0){
      recorder1.endRecord();
      
      player1 = new FilePlayer( recorder1.save() );
      player1.patch( out );
      player1.loop();
    }
    
    else if (p==1){
      recorder2.endRecord();
      
      player1.unpatch( out );
      player1.close();
      
      player2 = new FilePlayer( recorder2.save() );
      player2.patch( out );
      player2.loop();
    }
    
    else if (p==2){
      recorder3.endRecord();
      
      player2.unpatch( out );
      player2.close();
      
      player3 = new FilePlayer( recorder3.save() );
      player3.patch( out );
      player3.loop();
    }
    
    else if (p==3){
      recorder4.endRecord();
      
      player3.unpatch( out );
      player3.close();
      
      player4 = new FilePlayer( recorder4.save() );
      player4.patch( out );
      player4.loop();
    }
    
    else if (p==4){
      recorder5.endRecord();
      
      player4.unpatch( out );
      player4.close();
      
      player5 = new FilePlayer( recorder5.save() );
      player5.patch( out );
      player5.loop();
    }
    
    else if (p==5){
      recorder6.endRecord();
      
      player5.unpatch( out );
      player5.close();
      
      player6 = new FilePlayer( recorder6.save() );
      player6.patch( out );
      player6.loop();
    }
    
    else if (p==6){
      recorder7.endRecord();
      
      player6.unpatch( out );
      player6.close();
      
      player7 = new FilePlayer( recorder7.save() );
      player7.patch( out );
      player7.loop();
    }
    
    else {
      recorder8.endRecord();
      
      player7.unpatch( out );
      player7.close();
      
      player8 = new FilePlayer( recorder8.save() );
      player8.patch( out );
      player8.loop();
    }
    p++;
  }
}
