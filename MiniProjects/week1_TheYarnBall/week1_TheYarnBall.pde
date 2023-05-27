/*
Project #1 by Minji Kil

Points that form a circle (diameter 600cm) are randomly designated 
and connected. The color and thickness of the lines are also randomly 
specified. 
*/

void setup(){
    background(147,169,209);
    size(800,800);
}

int size = 600;
int radius = size/2;

int line_num = 500;
int rs = 1;

void draw(){
     translate (width/2, height/2);
     randomSeed(rs);
     
     //Coordinates of the starting point
     float x = random(-radius,radius);
     float y =(float)Math.sqrt(radius*radius-x*x);
     y *= random(1)<0.5 ? 1 : -1;
     
     for (int i=0; i<line_num; i++){
       //Coordinates of the next point
       float next_x = random(-radius,radius);
       float next_y =(float)Math.sqrt(radius*radius-next_x*next_x);
       next_y *= random(1)<0.5 ? 1 : -1;
       
       //Specify the color and thickness of the line
       stroke(random(255),random(255),random(255));
       strokeWeight(random(20));
  
       //Draw a line
       line(x,y,next_x,next_y);
       
       x=next_x;
       y=next_y;
     }
}
