void lady(){
  float r = 200;
  
  // Create the coordinates of the ellipsoid
  for (int i = 0; i < total+1; i++){
    float lat = map(i, 0, total, -HALF_PI, HALF_PI);
    for (int j = 0; j < total+1; j++){
      float lon = map(j, 0, total, 0, PI);
      float x = r * sin(lon) * cos(lat);
      float y = r * sin(lon) * sin(lat) ;
      float z = r * cos(lon) * bugRat;
      bug[i][j] = new PVector (x,y,z);
    }
  }
  
  // Shape the coordinates (head)
  noStroke();
  fill(70);
  for (int i = 0; i < total; i++){
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j<total/7*2+1; j++){
      PVector v1 = bug[i][j];
      vertex(v1.x,v1.y,v1.z);
      PVector v2 = bug[i+1][j];
      vertex(v2.x,v2.y,v2.z);
    }
    endShape();
  }
  
  // Shape the coordinates (body)
  fill(backCol);
  for (int i = 0; i < total; i++){
    beginShape(TRIANGLE_STRIP);
    for (int j =total/7*2; j<total+1; j++){
      PVector v1 = bug[i][j];
      int newi = int(map(i, 0, total, 0, xsize-1)); //좌표 동기화
      int newj = int(map(j, total/7*2, total, 0, ysize-1)); //좌표 동기화 (하단부를 정사각형 패턴에 매칭)
      PVector v2 = bug[i+1][j];
      if(patternArr2[newi][newj] == 1) //새로 만들어둔 원에 속하는 좌표 배열 확인
      {
        fill(dotCol);
      }
      else
      {
        fill(backCol);
      }
      vertex(v1.x,v1.y,v1.z,v2.x-v1.x,v2.y-v1.y);
      vertex(v2.x,v2.y,v2.z,v1.x-v2.x,v2.y-v2.y);
    }
    endShape();
  }
  
 
  // Fill bottom (head)
  fill(70);
  beginShape();
  for (int j = 0; j<total/7*2+1; j++){
    PVector v1 = bug[0][j];
    vertex(v1.x,v1.y,v1.z);
  }
  for (int j = total/7*2; j>=0; j--){
    PVector v2 = bug[total][j];
    vertex(v2.x,v2.y,v2.z);
  }
  endShape();
  
  // Fill bottom (body)
  fill(backCol);
  beginShape();
  for (int j = total/7*2; j<total+1; j++){
    PVector v1 = bug[0][j];
    vertex(v1.x,v1.y,v1.z);
  }
  for (int j = total; j>=total/7*2; j--){
    PVector v2 = bug[total][j];
    vertex(v2.x,v2.y,v2.z);
  }
  endShape();
  
}
