/*
  Project2.L-System
  Bloom
  by Minji Kil, 2022
 */

String S = "F";
String Rule_F = "F[+F[-F]]F[-F[+F]]FF";
String _S = S;
float angleOffset = radians(30);
int rs = 0;

void setup() {
  size(900, 600); 
  stroke(0);
  rectMode(CENTER);
}

void draw() {
  background(0);           
  translate(width/2, height);
  rotate( -HALF_PI );
  float branchLen = map(mouseY, 0, height, 50, 0.1);
  randomSeed(rs);
  render( S, branchLen );
}

void render(String S, float branchLen) {
  // iterate over each symbol of S and render appropriately
  
  strokeWeight(3);
  
  boolean leaf = false;
  int l = 0;
  
  for (int i = 0; i< S.length(); i++){
    stroke(255, 175);
    char c = S.charAt(i);
    
    if (c=='F'){ // Draw forward
      line(0,0,branchLen,0);
      translate(branchLen, 0);
      
      if (leaf == true){ //Draw leaves
        for (int j=0; j<random(5);j++) {
          noStroke();
          fill(random(255),random(255),random(255),130);
          circle(random(0,30*log(l+1)),random(-40*log(l+1),40*log(l+1)),branchLen*random(1,2)*log(l+1)*0.6);
        }
      }
      l++;
    }
    else if (c=='+'){ //Turn right by angleOffset
      rotate(angleOffset);
    }
    else if (c=='-'){ //Turn left by angleOffset
      rotate(-angleOffset);
    }
    else if (c=='['){ // Save current position and angle
      pushMatrix();
      leaf = true;
    }
    else if (c==']'){ // Resotre position and angle
      popMatrix();
      leaf = false;
    }
  }
}

void mousePressed() {
  S = ApplyRule( S );
}

int cnt = 0;

String ApplyRule( String str ) {
  // Replace 'F' in a given string with a Rule string and return the result
  if (cnt<5){
    str = str.replaceAll("F", Rule_F);
    cnt++;
  }
  else{ //reset
    str=_S;
    cnt=0;
    rs++;
  }
  return str;
}
