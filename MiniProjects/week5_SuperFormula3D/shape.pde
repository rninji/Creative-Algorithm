float a = 1;
float b = 1;
int total = 100;
float offset = 0;

float n1= 0.5, n2=1.7, n3=1.7;

float supershape(float theta, float m, float n1, float n2, float n3){
  float t1 = abs((1/a)*cos(m * theta / 4));
  t1 = pow(t1, n2);
  float t2 = abs((1/b)*sin(m * theta / 4));
  t2 = pow(t2, n3);
  float t3 = t1 + t2;
  float r = pow(t3, -1 / n1);
  return r;
}

void shape(){
  float r = 200;
  // Create the coordinates of the ellipsoid
  for (int i = 0; i < total+1; i++){
    float fi = map(fft.getBand(i), 0, fft.specSize()/50, 0, 1);
    float m = map(mouseX, 0, width, 0, 20)*fi;
    float lat = map(i, 0, total, -HALF_PI, HALF_PI);
    float r2 = supershape(lat, m, n1, n2, n3);
    for (int j = 0; j < total+1; j++){
      float lon = map(j, 0, total, -PI, PI);
      float fj = map(fft.getFreq(j), 0, fft.specSize()/50, 0, 1);
      m = map(mouseX, 0, width, 0, 20)*fj;
      float r1 = supershape(lon, m, n1, n2, n3);
      float x = r * r1 * cos(lon) * r2 * cos(lat) * map(mouseY,height,0,1,2);
      float y = r * r1 * sin(lon) * r2 * cos(lat) * map(mouseY,height,0,1,2);
      float z = r * r2 * sin(lat);
      globe[i][j] = new PVector (x,y,z);
    }
  }
  
  // Shape the coordinates
  noStroke();
  //fill(70);
  offset += 5;
  for (int i = 0; i < total; i++){
    float hu = map(i, 0, total, 0, 255*6);
    int rgb = int(random(3));
    if (rgb==0){
      fill ((hu+offset)%255, 255, 255);
    }
    else if (rgb==1){
      fill (255, (hu+offset)%255, 255);
    }
    else {
      fill (255, 255, (hu+offset)%255);
    }
    
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j<total+1; j++){
      PVector v1 = globe[i][j];
      vertex(v1.x,v1.y,v1.z);
      PVector v2 = globe[i+1][j];
      vertex(v2.x,v2.y,v2.z);
    }
    PVector v1 = globe[i][0];
    vertex(v1.x,v1.y,v1.z);
    PVector v2 = globe[i+1][0];
    vertex(v2.x,v2.y,v2.z);
    endShape();
  }
}
