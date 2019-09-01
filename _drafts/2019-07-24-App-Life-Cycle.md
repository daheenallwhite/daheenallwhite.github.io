

# App Life Cycle

## Life Cycle

어떤 것의 life cycle이 존재한다  = state 의 변화가 있다

App Life Cycle ==  앱이 실행되는 전 과정, 즉, launching ~ 종료까지의 state 변화와 응답을 이해하는 것이 핵심

App Life Cycle 은 System, 즉, os 와 긴밀하게 연관되어 있다. app 의 state 는 os 가 관리?

 

## App 구동 원리

![]({{site.url}}/assets/post-image/app-main-run-loop.png)

![](https://dl.dropbox.com/s/i6ed655jlzrizs1/IMG_1006.PNG)



## app state 의 변화에 누가 이를 관리하고 처리하는가?

관리 단위

~ios 12 : Application - UIApplication, UIApplicationDelegate

Ios13~ : Scene - UISceneDelegate



## App State

foreground - inactive / active

background & suspended

![](https://dl.dropbox.com/s/wpmf59gfnaiuafr/IMG_1008.PNG)

### 생명주기

user 가 app icon 을 누름

시스템이 app 을 forground inactive 로 만듬

완료시 



app life cycle event == app state 를 변화시키는 이벤트



## main thread

