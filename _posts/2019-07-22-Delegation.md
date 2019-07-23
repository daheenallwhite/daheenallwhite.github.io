---
layout: post
title:  "[iOS] Delegation - 너가 좋아할만할 일이 생겨서 알려주려고"
date:  2019-07-22 01:45:59
author: Dana Lee
categories: iOS
tags: [Delegation, Delegate, UITextFieldDelegate, did/should/will, Protocol]
lastmod : 2019-07-23 16:49:59
sitemap :
  changefreq : weekly
  priority : 1.0
---



object 의 책임을 넘기는 design pattern으로 sublassing 없이 객체를 재사용할 수 있다. 책임을 넘겨 유연한 구조를 만들 수 있다.

이렇게 설명하면 솔직히 한번에 이해하기가 어렵다. 그래서 찾아보던 중 맘에 드는 설명을 발견했다.

> a delegate is any object that should be notified when something interesting has happened.<br>
>
> 흥미로운 일이 생길 때, 알림 받아야 하는 객체가 delegate 이다.

delegate pattern 은 Foundation, UIKit, Cocoa Touch 등 애플 프레임워크에서 광범위하게 활용되고 있다. 

&nbsp;

### 왜 사용할까?

**서브클래싱(subclassing) 없이 나만의 기능을 구현 (resuing controls without subclassing)**

클라이언트, 즉 delegate 에 일을 맡기는 쪽에서는 protocol 로 선언된 delegate 의 자격요건만 알고 protocol 의 메소드만 사용한다. delegate 객체는 delegate protocol을 준수한 구체적인 타입으로 클라이언트의 속성에 참조되어 사용된다. 

클라이언트의 기능을 구체적으로 구현하기 위해 클라이언트 클래스의 하위클래스를 만들 필요 없이, delegate protocol 을 채택하는 delegate 가 될 구체적인 클래스에서 구체적 구현을 완료하여 클라이언트의 delegate 속성에 참조시키기만 하면 된다.

delegate 패턴의 목적은 subclass - 수직 상속 없이 각 객체의 event 에 대한 응답, 혹은 어떤 처리 방법을 각자 다르게 구현하기 위해서이다. Delegate protocol 을 준수하는 class or struct 에서 각 event 에 대해 응답하는 메소드를 구체적으로 구현하면 된다. delegate 가 없다면 각 이벤트마다 불릴 메소드를 하위 클래스에서 override 해야 한다. Delegate 의 자격 요건만 알고, 구체적인 동작은 몰라도 됨

delegator는 delegate 의 common interface 를 활용하여 일을 위임, 대신 맡긴다

&nbsp;

### 구현

- Delegate : protocol 로 구현

  - 특정 class or struct 가 넘길 책임을 처리하는 자격요건을 명시한 protocol 을 선언한다. 

  - Method 의 첫번째 인자로는 클라이언트를 받는다.

    Ex. `UITextFieldDelegate` 의 method 의 첫번째 argument는 `UITextField` 객체

    ```swift
    protocol UITextFieldDelegate {
    	// 대리자에게 특정 텍스트 필드의 문구를 편집해도 되는지 묻는 메서드
      func textFieldShouldBeginEditing(UITextField)
    }
    ```

    

- 책임을 넘길 class or struct 에서 `delegate` property 를 사용한다
  - 주로 `weak var delegate?` 로 선언된다.
  - 이 속성을 참조하여 delegate 에 대신 물어보고, 대신 처리하라고 지시함
  - 먼저 메모리에서 사라질 수 있기 때문에

- 주로 **user interface 관련 객체의 delegate 가 인터페이스 제어에 관련된 권한을 위임받아 처리**한다.

&nbsp;

### did/should/will

특정 상황에 대한 메시지를 Delegate 에게 전달하고, 그에 맞는 적절한 응답을 받기 위해 메소드에 주로 다음의 표현이 자주 사용된다.

- **did, should, will** : delegate 의 method 에 붙는 표현들
- did : 어떤 일 이미 일어났는데 그 뒤에 해야될 일 하라고 알려줌. 이미 완료되었다.
- should : 주로 **어떤 일을 해도 되는지 delegate 에게 물어볼 때** 사용됨
- will : 곧 어떤 일 일어날 건데 그 전에 완료되어야 할 일들 처리하라고 알려줄 때

![]({{site.url}}/assets/post-image/Delegation-1.jpg)

&nbsp;

### Example : 주사위 게임

주사위 게임 - 시작/끝/주사위 굴릴 때, delegate 에게 알려줌

- 주사위 클래스 

```swift
class Dice {
    let sides: Int // 몇 개의 면을 가진 주사위 인지 나타내는 속성
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
```

- 주사위 게임 클래스

```swift
protocol DiceGame {
	var dice: Dice { get }
  func play()
}

protocol DiceGameDelegate: AnyObject { // Class-Only Protocol
  func gameDidStart(_ game: DiceGame)
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
  func gameDidEnd(_ gmae: DiceGame)
}
```

- Snake and Ladders game : 게임판 주사위 굴려서 마지막 까지 가는 게임

```swift
class SnakeAndLadders: DiceGame {
  let finalSquare = 25
  let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
  var square = 0
  var board: [Int]
  init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
  weak var delegate: DiceGameDelegate?
  
  func play() {
    squre = 0
    delegate?.gameDidStart(self)
    gameLoop: while squre != finalSqure {
      let diceRoll = dice.roll()
      delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
      
      switch square + diceRoll {
        case finalSquare:
        	break gameLoop
        case let newSquare where newSquare > finalSqure:
        	continue gameLoop
        default:
        	square += diceRoll
        	square += board[square]
      }
    }
    delegate?.gameDidEnd(self)
  }
}
```

- DiceGameTracker : delegate 채택한 클래스. 각 단계 track 

```swift
class DiceGameTracker: DiceGameDelegate {
  var numberOfTurns = 0
  
  func gameDidStart(_ game: DiceGame) {
    numberOfTurns = 0
    if game is SnakesAndLadders {
       print("Snakes and Ladders 새 게임 시작")
    }
    print("이 게임은 \(game.dice.sides)개 면 주사위를 사용합니다.")
  }
  
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
    numberOfTurns += 1
    print("주사위 굴림 : \(diceRoll)")
  }
  
  func gameDidEnd(_ gmae: DiceGame) {
    print("\(numberOfTurns) 번만에 게임 종료")
  }
}
```



---

## 📌 Reference

- [Protocol - Delegation - Swift.org](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID276)
- [Delegation - Boostcourse iOS](https://www.edwith.org/boostcourse-ios/lecture/16856/)
- [UITextFieldDelegate](https://developer.apple.com/documentation/uikit/uitextfielddelegate)
- [What is a delegate in iOS? - Hacking with Swift](https://www.hackingwithswift.com/example-code/language/what-is-a-delegate-in-ios)

