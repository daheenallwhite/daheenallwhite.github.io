## Escaping Closure

- 함수의 인자로 넘겨진 closure 가, 그 함수가 return 된 이후에 호출되어야 할 때, 해당 클로져는 함수를 escape 했으니까 escaping closure 라고 함
- `@escpaing` 키워드를 argument 앞에 붙이면 됨
- Ex. function 밖에서 선언된 변수에 클로져가 저장되어야 하는 경우/ completion handler 처럼 이미 해당 함수의 호출이 끝난 후, 어떤 처리가 완료되었을 때 실행되어야 하는 클로져
- 일반 클로져는 선언된 곳 주변의 context 를 capturing 함. 따라서 self 를 암묵적으로 참조한다
- 반면에 escaping closure 에서는 self 사용하려면 escaping 필요



## App Life Cycle

UIApplication 

UIApplication main 을 통해 시스템이 앱 객체를 생성한다. 

UIApplicationMain() 함수를 실행하면, UIApplication 객체가 싱클톤 형태로 생성된다.

이 때, main run loop 가 실행되고, main thread 에 연결된다.

main run loop 는 유저 이벤트를 처리하는 프로세스. main run loop 는 view 관련 이벤트나 뷰 업데이트에 활용되며 main thread 에 연결됩니다.

UIApplication 의 역할

- User 이벤트를 받는 가장 첫번째 객체
- 어떤 처리를 할지 결정한다. 
- 사용자 이벤트는 main run loop 에 의해 이벤트 큐에서 하나씩 꺼내져서 옴



### state

- Not running : 아직 시작 안된 상태 혹은 실행되었는데 시스템에 의해 종료된 상태
- inactive : foreground 에서 실행중. event를 받지 ㅇ낳음
- Active: foreground 에서 실행중. event 받음
- background : 백그라운드에서 실행 중. suspended 직전 상태. 코드 실행 중
- suspended: 백그라운드에 있고, 코드 실행 안하는 상태. 시스템이 background에 있는 앱 을 자동으로 이 상태ㅔ 옮겨 놓으며, 상태 전환시 따로 안알려줌. 



### main run loop

사용자관련 이벤트를 처리한다. Uiapplication 객체가 main run loop 를 런치타입에 셋업하고 view 기반 인터페이스를 업데이트 하고 관리하는데 사용한다. 앱의 main thread 에서 실행되고, 사용자 관련 이벤트는 들어온 순서대로 순차적(serial)으로 처리된다.



### AppDelegate

Uiapplication 객체와 같이 일하며, UIApplicationDelegate 를 채택하고, UIResponder 를 상속받은 클래스. Uiapplication delegate 객체로 앱 초기화, 상태 변화 같은 많은 하이레벨 앱 이벤트를 관리합니다. 



## Event handling

### Responder chain

앱은 이벤트를 받고 관리하는데 resonder 객체를 사용한다. responder 객체는 UIResponder 클래스나 그 하위 클래스의 객체를 말한다. Responder 는 이벤트를 받으면 이를 처리하거나 responder 체인의 다음 객체에게 넘긴다. UIKit은 이벤트를 fist responder 에게 넘기는 처리만 하는데, 이는 가장 적절한 responder object를 말한다. 

responder chain 은 해당 view 부터 ~ root view ~ view controller ~ uiwindeow~ uiapplication ~ uiapplicationdelegate 까지 이어진 체인

이벤트 별로 first responder 를 결정하는 기준이 다름. 

touch 이벤트의 경우

uiapplication 객체를 통해 이벤트가 들어오면 각 view의 hitTest 메소드를 통해 가장 먼저 event를 전달 받을 first responder view 를 찾습니다. 해당 view에 sendEvent() 하고, 해당 responder 에 처리하지 못할 경우 responder chain 에 있는 다음 객체로 이벤트 처리를 넘김니다.

이벤트를 처리할 역할을 가진 responder 객체들을 연결한 체인

reponder chain은 uiresonder 의 하위클래스 객체들이 연결된 체인으로 앞에서 처리하지 못한 이벤트를 다음 respoonder 객체로 넘기는 방식입니다. 



## GCD 

### process

현재 수행 중인 프로그램으로 CPU 를 할당받는 단위. 

### thread

한 프로세스를 각각의 실행단위로 세분화 한 작은 일 

프로세스는 부여된 자원의 소유자라면 스레드는 스케쥴링의 단위다. 

(스케줄링 부여된 자원을 어떤 순서대로 배정 받아 사용할 건지 결정하는 문제)

한 프로세스 안의 스레드들은 프로세스의 자원을 공유한다

각 스레드는 자신의 실행환경을 따로 가진다. 



### Concurrent

동시에 여러개가 존재한다는 의미로 동시에 여러 개의 스레드가 실행된다는 의미

앱 혹은 프로세스는 하나 이상의 스레드를 가진다. Os 스케줄러는 각 스레드를 관리하고, 각 스레드는 concurrent 하게 실행된다. Parallel 은 물리적인 개념이고 concurrent 는 논리적인 개념

single core : time slicing / multi core : parallelism 을 통해 concurrency 를 달성할 수 있다.

parallelism 은 concurrency 전제. 반면에 concurrency 는 항상 병렬처리를 보장하는 것은 아님



### Dispatch Queue

task 가 serial/concurrent 하게 앱의 main/background 스레드에서 처리될 수 있도록 관리해주는 객체. 

디스패치큐에 넣은 work는 시스템에 의해 관리되는 스레드 풀에서 실행된다. main thread 를 지정한 경우를 제외하고는 시스템은 어떤 스레드에서 작업이 실행될 지 확정할 수 없다.

work item 은 syn/async 하게 스케줄 할 수 있다. - sync: work item 끝날 때까지 코드가 기다린다 / async : work item 끝나는걸 기다리지 ㅇ낳고 계속 수행해 나간다

block of code(closure, 함수), unit of work(작업단위) == work item

work item 을 dispatch queue 에 넣으면 GCD 가 어느 스레드에서 그게 실행될 건지 결정한다.

queue ; FIFO

dispatch queue는 thread safe == 여러개의 스레드가 dispatch queue에 동시에 접근 가능하다는 의미.



queue 종류 - serial / concurrent

Dispatch queue 는 serial / concurrent 하게 작업을 처리할 수 있다. queue에 들어간 task은 항상 FIFO 순서로 처리된다. 

serial dispatch queue : 한번에 한개의 task 만 처리하고, 한 task 가 끝나야 다음 task 를 시작할 수 있다.

concurrent dispatch queue : 가능한 많은 task 를 동시에 실행할 수 있다. 시작되는 순서는 queue 의 fifo 순서대로. 중요한건 다른 task 가 끝나길 기다릴 필요 없다. 끝나는 걸 기다릴 필요 없이 다음 작업을 실행할 수 있음



GCD 는 세가지 queue 타입을 제공한다.

1. Main queue : main thread 에서 task 실행하는 전역적으로 사용가능한  **serial** 큐
   - UIApplicationMain() 실행시 시스템에 의해 자동으로 만들어져 메인 스레드에 연결된다.
   - ui 관련 처리를 담당하는 스레드 == main thread
   - ui 관련 처리 이외에는 어떤 스레드에서 실행될지 확정 못함. GCD에 의해 적절한 스레드에서 처리 - completion handler 를 main thread 에서 처리할지 아닐지 아무도 장담 못함
   - 따라서 네트워킹 완료 후, reponse를 ui에 반영하고 싶다면 main 스레드에서 이를 처리하라고 명시적으로 알려줘야 함 -`DispatchQueue.main.async()`
2. global queue : concurrent. 전체 시스템에서 공유하는 queue. 백그라운드에서 동작하는 큐
   - quality of service : 중요도 표시 
3. custom queue: 직접 만들어 사용가능. serial/concurrent



### sync / async function

sync : task 가 다 완료된 후에 caller(호출자)에 control 을 넘긴다. 

async: 완료될 때까지 기다리지 않고, 바로 return. task 를 지시한 후, 바로 return. 

백그라운드에서 실행 후, 완료되면 알림을 보냄

따라서 async function 은 현재 스레드가 다음 함수를 실행하는 것을 막지 않음. 

```swift
DispatchQueue.sync( work item)

DispatchQueue.async ( work item)
```



> Asynchronous functions have been present in operating systems for many years and are often used to initiate tasks that might take a long time, such as reading data from the disk. When called, an asynchronous function does some work behind the scenes to start a task running but returns before that task might actually be complete.
> Typically, this work involves acquiring a background thread, starting the desired task on that thread, and then sending a notification to the caller (usually through a callback function) when the task is done.

비동기 함수란 주로 시간이 꽤 걸리는, 디스크로부터 데이터를 읽는 등의 작업을 시작하는데 사용된다. 비동기 함수는 호출되면 뒤에서 작업을 시작하고 해당 작업이 다 완료되기 전에 return 한다. 

주로 이런 일은 background thread 를 얻어 처리되는데, 백그라운드 스레드에서 원하는 작업을 시작하고, 작업이 완료되면 caller 에게 알림을 보낸다(주로 callback 함수를 통해서) - completion handler or delegate method

과거에는 이런 비동기 함수를 직접 만들고, 스레드도 직접 만들어 사용해야 했지만, 이제는 ios/os x 가 thread 를 직접 관리하지 않고도 어떤 작업이든 비동기적으로 수행할 수 있도록 가능한 기술을 제공한다. 그게 바로 GCD

작업을 비동기적으로 수행하는 기술 중 한가지로 Grand Central Dispatch 가 있다. 이 기술은 일반적으로 작성된 앱 코드를 system level 로 다운시켜준다. 그저 우리가 할 일은 실행시키고 싶은 작업을 정의하여, 적절한 dispatch queue에 넣으면 된다. GCD 가 필요한 스레드를 생성하고 만든 작업을 그 스레드에서 처리되도록 스케줄링하는걸 다 관리해준다. 



Dispatch Queue : async / sync 하게 임의의 코드 블럭을 실행할 수 있게 해준다. 

serial/concurrent 로 작업 수행한다. 



### GCD

**멀티코어 프로세스를 위한 Thread 관련 프로그래밍을 자동으로 관리/분배해주는 low level api.**

기존의 스레드 관리는 직접 스레드를 만들고 관리해야 했지만, GCD 를 통해서는 스레드를 직접 관리하지 않고도 어떤 작업이든 비동기 적으로 실행할 수 있도록 가능하게 해주는 기술이다. 

thread 관련 관리 

Concurrent(병행) operation 관리를 위한 low level api 로, 비교적 오래 걸리는 작업들을 백그라운드에서 실행시켜 앱의 반응속도를 높여준다. 

개발자가 직접 스레드를 생성하고 lock 을 관리할 필요 없음. GCD 가 필요한 스레드를 생성하고, queue 에 넣은 작업을 적절한 스레드에서 처리되도록 스케줄링 하는걸 다 관리해줌



### Thread concurrency 관련 고려 사항

뷰 관련된 작업은 앱의 main thread 에서 일어나야 한다. 

시간이 긴 작업들은 백그라운드 스레드에서 실행되어야 한다. - network, file access 같은 작업들 은 GCD 사용해서 asyn 비동기적으로 처리되어야 한다.

URLSession 혹은 location 매니저는 오래 걸리니까 백그라운드에서 비동기적으로 실행 후, 완료되었음을 각각 completion handler 호출 / delegae method 호출로 알려준다. 



## ARC

ARC 는 필요한 동안만 메모리에 인스턴스를 머무르도록 하는 메모리 관리 방법입니다. 필요를 측정하는 방법으로 reference counting, 즉, 해당 인스턴스를 참조하는 카운트를 사용합니다. 더이상 해당 인스턴스가 필요하지 않을 때, 즉 reference count가 0이 될 때 메모리 공간을 회수합니다. ARC는 컴파일러가 컴파일 타임에 각 인스턴스의 reference count 를 계산하여 관리해줍니다. 

ARC 를 사용해도 여전히 메모리 누수 (memory leak)가 발생할 가능성이 있는데, reference cycle이라 함. reference 에도 종류가 있는데 reference count 를 증가시키는 참조를 strong reference 라고 합니다. reference cycle 은 두 인스턴스가 서로 강한 참조로 서로를 가리킨 채로, 어디서도 접근할 수 없고, 메모리에 계속 살아있는 상태를 말합니다. 이는 예상치 못한 메모리 공간의 낭비를 초래합니다.

이런 strong reference cycle 을 방지하기 위한 방법으로 weak, unowned reference 가 있는데 이는 참조하는 인스턴스의 reference count를 증가시키지 않는 방법입니다.



## Value type / Reference Type

struct 는 value/ class reference 

value type 은 변수에 할당되거나, 함수의 인자로 넘겨질 때, 값을 복사하여 사용합니다. 반면에 reference type은 해당 인스턴스가 있는 메모리 주소를 참조합니다. 한개의 인스턴스를 공유

value type 은 컴파일 될 때 필요한 스택 메모리 공간을 계산할 수 있어요. 예측이 가능 - safe

하지만 Reference type은 런타임, 즉 실행시간에 메모리 공간의 크기가 결정되니까 상대적으로 예측하기가 힘듭니다.





## Extension 언제 쓰이는가

extension 은 기존의 있는 **class, struct, enum, protocol 타입에 기능을 추가하는 방법**이다. 이는 원래 소스코드에 접근 불가능한 타입도 확장할 수 있다. 상속과는 다르게 원래 있던 타입에 기능을 추가하는 수평확장 기법이다.

1. type의 수평 확장
   - computed instance/type property 추가하기
   - instance/type method 추가
   - intializer 추가
   - subscript 추가
   - nested type 추가
2. protocol 채택, default implementation
   - 기존에 있던 타입을 프로토콜 채택하기
   - protocol extension : default implementation
     - 준수하는 타입이 아닌 프로토콜에서 정의
     - 채택 가능한 타입의 제약 추가 가능 - generic where clause
3. 상속?
4. 분리



## 차이점 : as / as? / as!

as : type casting 하는 방법

타입 캐스팅이란, 한 타입의 인스턴스를 다른 타입의 인스턴스로 취급하는 방법이다. 이때, 다른 타입은 같은 클래스 계층구조 혹은 프로토콜 채택 관계에 있어야 한다. 

타입 캐스팅 하는 이유

1. 어떤 타입의 인스턴스인지 확인
2. 같은 클래스 계층 구조내에 있는 다른 클래스 타입으로 캐스팅 하려고
3. 프로토콜 준수 여부 확인



as : 타입 캐스팅에 항상 성공한다 - upcasting

as? as! : 타입 캐스팅에 실패할 가능성이 있다 - downcasting 

as ? 실패시 nil 반환

As! Forced type casting 실패시 에러.



## optional

absence of value

### optional chaining

property 를 호출하는 일련의 과정으로 체인의 한 요소라도 nil이라면 전체 체인도 nil



## MVC / MVVM

### Model - view - controller

model : 프로그램에서 사용되는 데이터와 관련된 조작 로직을 처리하는 부분

View : 사용자에게 보여지는 ui 부분

controller : 뷰와 모델 객체 사이 사용자 입력과 데이터 변화에 대한 연결해주는 중재자 역할

view와 model 간의 의존관계를 줄여 변경에 유연하게 대처하기 위한 구조

Ios 에서는 view-view controller 간의 연결이 강함. massive view controller 라는 말이 있듯이컨트롤러의 과중한 역할.



### Model - view(view controller) - view model

view model : view 를 표현하기 위한 view 만을 위한 model

> MVVM은 두가지 디자인 패턴을 사용합니다. 바로 Command패턴과 Data Binding 인데요.
>
> 이 두가지 패턴으로 인해 View와 ViewModel은 의존성이 완전히 사라지게 됩니다.
>
> MVP와 마찬가지로 View에서 입력이 들어오구요. 입력이 들어오면 Command 패턴을 통해 ViewModel에 명령을 내리게 되고 Data Binding으로 인해 ViewModel의 값이 변화하면
>
> 바로 View의 정보가 바뀌어져 버리게 됩니다.
>
> 정리를 하자면!
>
> 1. View에 입력이 들어오면 Command 패턴으로 ViewModel에 명령을 합니다.
> 2. ViewModel은 필요한 데이터를 Model에 요청 합니다.
> 3. Model은 ViewModel에 필요한 데이터를 응답 합니다.
> 4. ViewModel은 응답 받은 데이터를 가공해서 저장 합니다.
> 5. View는 ViewModel과의 Data Binding으로 인해 자동으로 갱신 됩니다.



## Singleton pattern

메모리에 해당 타입의 인스턴스가 딱 한개만 존재하도록 보장하는 패턴. 해당 인스턴스에 대한 글로벌 접근 포인트를 가짐. 

장점 - 전역 인스턴스 - 데이터 공유가 쉽다. 메모리 낭비 방지

단점 - 멀티스레드 환경에서 동기화 처리 없다면 인스턴스가 두개가 되는 경우 발생 가능



## Auto Layout

content hugging ...

priority



## Delegate

하나의 객체가 모든 일을 처리하지 않고, 처리할 일 중 일부를 다른 객체에게 넘기는 것을 뜻한다. 같이 협력!

주 객체에서 중요하다고 생각하는 몇가지 경우에서 delegate 의 관련 메소드를 호출

Delegate 는 protocol 타입으로 명시 - delegate protocol 을 준수한 어떤 타입이라도 올 수 있음~

protocol 에서 원하는 구현 함

장점 : subclassing 없이 나만의 기능을 구현할 수 있다. /  책임을 delegate 에 넘겨 유연한 구조를 만들 수 있다. 

> a delegate is any object that should be notified when something interesting has happened.



## NSCache

Caching object 도와주는 class

mutable dictionary 처럼 행동하는 클래스.

디바이스가 메모리 부족을 겪을 때 이 캐시에 있는 인스턴스의 메모리 공간을 자동으로 회수함.





## Hash

hash function -> 결과로 한번에 찾기 시간복잡도 O(1) (big oh 1)





## 클래스/객체

객체는 실제 세계에 있는 대상으로 소프트웨어에서 구현할 대상을 의미합니다.

이를 구현하기 위해 추상화 시킨 틀을 class 라고 하고, 클래스를 바탕으로 소프트웨어 세계에 구현된 구체적인 실체를 인스턴스라고 한다. 



## 프레임워크 / 라이브러리

프레임워크는 소프트웨어 개발을 위한 개발 환경 및 토대, 기반시설을 제공합니다. 앱의 운영을 위해 필수적으로 갖춰야 할 기반 요소 기능을 미리 만들어 둔 것

라이브러리는 공통으로 사용될 수 잇는 특정 기능들을 모듈화 한 것입니다.

둘의 가장 큰 차이점은 이것 없이도 앱이 동작할 수 있는지의 여부입니다. 