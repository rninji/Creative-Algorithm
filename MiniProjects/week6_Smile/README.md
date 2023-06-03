### 6. When you smile, I like it too.

<img width="912" alt="스크린샷 2023-06-03 오전 11 36 25" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/a5d4483e-2fca-4e1f-8f8b-5a85a59dac02">

#### 주제 : Machine Learning
###### 22/11/03 ~ 22/11/07

다른 사람의 얼굴 표정, 말투, 목소리, 자세 등을 무의식적으로 모방하고 자신과 일치시키면서 감정적으로 동화되는 감정 전염에 영감을 받아 제작하였습니다.   
화면을 보고 짓는 표정에 따라 화면 속 이모티콘들의 감정도 차례로 변하게 됩니다.   
당신이 웃는다면 우리도 웃을 거예요!   

#### 동작 과정 
<img width="796" alt="스크린샷 2023-06-03 오전 11 40 15" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/dcdcd6f5-2233-408c-a278-002082ffdd5d">

Face Osc를 이용해 사용자의 시선과 표정을 입력합니다.   
poseOrientation 값은 Processing으로 넘어가 시선의 위치로 대치되어 빨간 점으로 나타납니다.   
나머지 값들은 미리 학습 시켜논 Wekinator에서 무표정/웃음/찌뿌림/왼쪽윙크/오른쪽윙크로 구분합니다.   


#### 점수 처리
<img width="869" alt="스크린샷 2023-06-03 오전 11 44 27" src="https://github.com/rninji/Creative-Algorithm/assets/78344310/8997b132-16ec-44a1-8c81-147a9985eafc">

이모티콘의 표정을 바꿀 때마다 표정에 부여된 점수가 축적됩니다. 점수가 높으면 밝은 배경, 점수가 낮으면 어두운 배경이 출력됩니다.
