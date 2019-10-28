# iOS 에서 observing 에서 필요한 모든 것.



### KVO

Key-Value Observing 의 줄임말



### KeyPath

keypath는 어떤 객체의 특정 property 로 접근하는 길을 알려주는 일종의 모델이다.

정말 말그대로 path 이다. 

예전에는 string identifier를 썼었는데 이게 문제가 많으니까 KeyPath 라는 모델을 만들어 이걸로 어떤 타입의 어떤 value 로 가라고 친절하게 알려준다.



### NotificationCenter

observer pattern 에서 observer - subject 사이에 옵저빙과 notification post 을 전담하는 센터를 두어 한 단계더 추상화 시킨 클래스

앱마다 디폴트로 하나씩 있고, 커스텀하여 새로 만들어서 사용할 수도 있다