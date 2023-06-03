## 9. Loop Station

<img width="1463" alt="스크린샷 2023-06-03 오후 7 21 58" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/7a0e804a-4443-4765-a648-fcdac84d00cd">

### 주제 : Machine Learning - Instruments
###### 22/11/17 ~ 22/11/22

트랙을 반복해서 음악을 쌓아하는 루프 스테이션을 구현해보았습니다.


#### 1. 파형(Waveforms)
<img width="878" alt="스크린샷 2023-06-03 오후 7 26 29" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/cb4fdfbe-4104-45c8-a2d1-5bb5857923c1">

신디사이저의 기본인 네가지 파형을 사용해 소리를 만들었습니다. 소리는 진동수에 따라 피치가 바뀌게 되는데, 핸드폰을 기울여서 부드럽게 피치를 조절할 수 있도록 하였습니다.

#### 2. 드럼 
<img width="1342" alt="스크린샷 2023-06-03 오후 7 30 55" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/4654771f-4136-4eda-b1ec-57c14fbdc2ba">

비트의 핵심이 되는 드럼의 경우, 실제 드럼을 치는 느낌과 유사하게 핸드폰을 드럼 스틱처럼 휘두르면 소리를 나도록 하였습니다.

#### 3. 제스쳐 학습
<img width="853" alt="스크린샷 2023-06-03 오후 7 32 04" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/7f5a2a60-7c32-4bc9-affe-c9f97b5e028d">

핸드폰의 기울기는 파형을 나타내는 연속적인 값으로 대치되고, 핸드폰의 가속도 값은 드럼을 치는 행위에 대한 구분으로 출력되도록 학습시켰습니다.

#### 4. 사용 기술
<img width="909" alt="스크린샷 2023-06-03 오후 7 34 30" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/e4d35e76-bded-4e0f-84cb-b2f4857259e4">

소리를 재생하고 녹음하는 데에는 Minim Library를 사용하였습니다. 
또한 내부 소리를 녹음하고, 외부로 소리를 출력하기 위해 Black Hole audio driver를 사용했습니다.

#### 5. 사용법
<img width="893" alt="스크린샷 2023-06-03 오후 7 36 23" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/89a7d736-6e8a-4579-90c3-4e480ac732fa">

1. 1~8의 숫자키를 입력해 각 악기의 녹음을 시작합니다. 박스가 빨간색으로 변하면 녹음이 시작된 것입니다.
2. 숫자키를 다시 누르면 녹음이 끝나고 박스가 초록색으로 바뀝니다. 
3. 녹음된 소리는 계속해서 반복되고, 사용자는 소리를 계속해서 쌓을 수 있습니다.

#### 6. 시연 영상
[![Video Label](https://img.youtube.com/vi/cWpwSxcpnpk/0.jpg)](https://youtu.be/cWpwSxcpnpk)
