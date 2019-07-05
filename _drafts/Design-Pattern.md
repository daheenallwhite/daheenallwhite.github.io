



Pattern Language - 건축학에서 패턴

이 패턴 랭귀지를 컴퓨터 공학에 적용해봄

사용자의 사용 패턴을 파악해서 공통적인 패턴을 찾아나가자



자주 사용되는 설계 방식에 이름을 붙인 것이 design pattern

설계 방법에 대한 추상화

mvc, delegate

딱 정해진 정답은 없음. 꼭 사용해야만 한다는 것은 없고.

이런 문제에는 이 패턴 사용하면 장단점이 뭐가 있고 좋더라 라는 제안

컨셉은 같은데 구현은 조금씩 다를 수 있음

컨셉과 구현은 다름



`NSNotificationCenter` (observer pattern)

옵저버 패턴을 구현해 놓은 구현체

중간에 indirection 을 하나 넣어서 더 유연한 구조를 만듬

subject 가 직접 주던 notification 을 중간에 nsnotificationcenter 가 주도록함

subject - nsnotificationcenter - observers

(publisher)subject 가 누가 구독했는지의 정보를 몰라도 됨.

그저 바뀌면 notification 센터에 넘김



유투버 사례도 유투버가 직접 알려주지 않고, 유투브 서비스가 담당해서 알려줌



publisher 는 nscenter 에 알려줘 라고 일 시키고, 자기는 다른 일 할 수 있음

일 시키고, 다 하면 알려줘~



끝날 때 까지 기다리는 작업은 동기 작업



이런 구조로 만들면 비동기로 작업 가능

일 시키고, 난 다른일 하고, 다 끝나면 알려줘



publisher -> noti center 에 전달하는 방식 - 옵션이 있음. 2가지 선택지가 있음

- 동기 - pushNotification - 보내는거 끝날 때까지 기다림
- 비동기 - queue 에 넣는다 - 안기다림. 



observer 의 조건

- notification name - 어떤 알림을
- sender - 어떤 객체가
- 값이 nil 이면 상관없이 다 받는다는 의미

이 두가지 정보를 가지고 noticenter 가 어느 observer 에 보낼지 판단함

각 observer 가 설정한 두 조건에 다 부합하는 observer 에만 noti를 받음



Mvc 패턴에서

상위 모듈 - 컨트롤러

하위 모듈 - 모델

모델은 어디서 자신이 사용되는지 모름. 몰라도 됨

모델에 변화가 있으면 알려주는 일을 누가 담당해줘야 됨

알려주는일을 nsnotificationcenter에 넘기면 옵저버 등록된 애들에게 알려줌. 받는대상이 컨트롤러 혹은 뷰도 될 수 있음



컨트롤러와 뷰는 긴밀한 관계

모델(하위)는 어떤 컨트롤러가 자신을 사용하는지 모름



inputview -> 자료구조 변경 -> 출력

입력을 받아서 어떤 모델을 변경할건지 판단해서 처리 하고, 변경이 끝나면 notify 줘서 알려준뒤, 그걸 처리하는 컨트롤러가 다시 그에 맞는 뷰를 업데이트한다



예시

좋아요 누름 -> 백엔드 서버에 알려줌 -> 내 팔로워가 내가 좋아요 누른걸 안다

​                        notificationcenter



입력-처리-출력으로 모든 시스템을 만들 수 있음



설계와 구현패턴을 구분해봐야 한다

- 설계 패턴
- 구현 패턴 - 언어마다 그 설계 구현을 위해 어떤 구조, 어떤 타입을 사용하는지



publisher-subscriber pattern 와 observer pattern 이 다른 점

- publisher 는 subscriber 가 못받은 메시지를 queue에 넣고 있다가 다시 전해주는 동작도 더 필요. 주로 메시지 관련 프로그램. 네트워크쪽, 통신쪽에서 많이 씀
- observer 가 더 구조적으로 나뉘어져 있고, publisher 는 더 메시지 관련…?
- 기본적인 아이디어는 동일



Strategy pattern



Dependency Injection



http://public.codesquad.kr/jk/Feedback-20181129.pdf