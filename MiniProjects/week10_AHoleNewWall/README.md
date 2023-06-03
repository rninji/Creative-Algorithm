## 10. A Hole New Wall

<img width="867" alt="스크린샷 2023-06-03 오후 7 24 55" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/c940a754-8469-454b-9fcb-abaa6e1030b7">

### 주제 : Machine Learning
###### 22/11/24 ~ 22/11/28 길민지, 김호진, 서영진 

테트리스 블럭을 회전하고 이동시켜 벽의 구멍을 통과하는 협동 게임입니다.

#### 게임 방법 
<img width="852" alt="스크린샷 2023-06-03 오후 7 47 09" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/65fc93b4-b61b-4c40-9c14-883775cb1ba7">

1. 핸드폰이 향한 곳으로 블럭을 이동시킬 수 있습니다.   
2. 핸드폰을 세로 방향으로 회전시키면 블럭이 회전합니다. 
3. 블럭을 4번 회전시키면 다른 블럭으로 바꿀 수 있습니다.  
4. 인트로 화면에서 모드를 선택해 난이도를 조절할 수 있습니다. 
5. 3번 벽과 부딪혀서 실패하면 게임이 종료됩니다.


#### 프로세스
<img width="959" alt="스크린샷 2023-06-03 오후 8 00 55" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/a54d1460-a212-4ac1-8659-6e796c348775">|<img width="937" alt="스크린샷 2023-06-03 오후 8 00 02" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/35ddbfde-5065-40e2-bb85-b1262803dd8e">|<img width="966" alt="스크린샷 2023-06-03 오후 8 00 11" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/ac4a5224-3923-4126-814f-257b593dddf7">
| --- | --- | --- |


#### 주요 기술

1. 충돌 체크
<img width="968" alt="스크린샷 2023-06-03 오후 7 52 18" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/4999e4db-b31f-4dd5-a7c9-1de8ecaca1c5">

두 Collision의 거리를 계산해 충돌 여부를 확인합니다.

2. 벽에 구멍 생성
<img width="962" alt="스크린샷 2023-06-03 오후 7 52 58" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/3efe6ebe-88df-452a-8db7-9fe8755b4efa">

각 블럭의 모양을 담은 배열을 만들어 사용했습니다.  
중앙에 블럭 하나를 배치하고 상하좌우에서 블럭을 2개 더 붙여 나온 모양대로 구멍을 생성합니다.  

3. 2D 그래픽으로 3D 효과 내기
<img width="969" alt="스크린샷 2023-06-03 오후 7 53 10" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/9c757c66-d1d1-4c88-b5b2-f4244a7b3d3f">

원근감을 느끼게 하는 배경 이미지에 더불어, 블럭이 점점 커지게 해서 다가오는 느낌을 형성합니다.

#### 시연 영상
