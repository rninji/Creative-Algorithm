int xsize = 100;
int ysize = 100;

int [][] patternArr = new int[xsize][ysize];
int [][] patternArr2 = new int[xsize][ysize];

int rs = 0;

void pattern() { 
    randomSeed(rs);
    makeP();
}

void makeP() {
  for(int y=0;y<ysize;y++) {
    for(int x=0;x<xsize;x++) {
      patternArr[x][y] = 0; //전부 0으로 초기화
      patternArr2[x][y] = 0; //전부 0으로 초기화
    }
  }
  int leftpcount = dotCnt;
    if(dotCnt%2==1) { //dotCnt가 홀수 일때 - 중앙 점 배치
      int midx =  xsize/2;
      int centerCount = int(random(1, (dotCnt+1)/3));
      int check = 0;
      while(check<centerCount){
        int randy = int(random(0,ysize));
        if(patternArr[midx][randy] == 0) { //중복 확인
          int cy = int(randy + (ysize/2 - randy)*dotDisY);
          patternArr[midx][cy] = 1; //점이 놓이는 지점 = 1
          check++;
        }
      }
      leftpcount = dotCnt-centerCount;//dotCnt는 짝수 (홀수 - 홀수 = 짝수)
    }
    int pcheck = 0;
    while(pcheck<leftpcount/2) {
      int xs = int(random(0, xsize/2));
      int ys = int(random(0, ysize));
      if(patternArr[xs][ys] !=1) { //중복 점 여부 확인
        int cx = int(xs + (xsize/2 - xs)*dotDisX);
        int cy = int(ys + (ysize/2 - ys)*dotDisY);
        patternArr[cx][cy] = 1; 
        patternArr[xsize-cx][cy] = 1; //x축 대칭 점
        pcheck++;
      }
    }

    // 원에 속하는 좌표
    for(int y=0;y<ysize;y++){
      for(int x=0;x<xsize;x++){
        if(patternArr[x][y] == 1)
        {
          for(int yy=0;yy<ysize;yy++)
          {
            for(int xx=0;xx<xsize;xx++)
            {
                if( pow(xx-x, 2) / pow(dotSize*dotRatX,2) + pow(yy-y,2) / pow(dotSize*dotRatY,2) <= 1) //타원 방정식
                {
                  patternArr2[xx][yy] = 1; //색칠할 영역으로 지정
                }
              
            }
          }
        }
      }
    }
}

void keyPressed() { 
  rs++;
}
