---
layout: post
title:  "Factory Pattern : Factory Method, Abstract Factory, Factory Pattern in Swfit"
date:   2019-05-007 19:19:00
author: Dana Lee
categories: Swift 
tags:    FactoryPattern Swift 
cover:  "/assets/instacode.png"
---
# Factory Pattern

> The *factory* pattern is a way to encapsulate the implementation details of creating objects, which adheres to a common base class or interface. 

객체 생성을 전담하는 struct/class를 만들어 구체적인 생성과정을 그 안에 구현하는 패턴

객체 생성을 다른 struct/class이 전담한다.

&nbsp;

- 목적

  - 객체 생성을 위한 복잡한 과정을 없애기 위함

     (사실상 없애는게 아니라 겉으로 드러나지 않도록 캡슐화해서 사용하도록 함)

  - 객체 생성의 구체적인 구현을 generic하게 객체를 사용하여 분리한다.

- 이럴 때 사용한다

  - 만들 객체의 클래스 종류를 예측할 수 없을 때
  - 만들어야 할 객체의 하위 클래스를 명시하고 싶을 때 

- 종류

  - Factory Method Pattern 
  - Abstract Factory Pattern

&nbsp;

---

## Factory Method Pattern

**한 객체(상품)만 생산함**

Factory method는 단일 상품 생산

> Define an interface for creating an object, but let subclasses decide which class to
> instantiate. Factory Method lets a class defer instantiation to subclasses.

- CoordinateCalculator 에서 사용한 방법

- factory method 1개

- example

  - Product

    ```java
    // product 추상 클래스
    public abstract class Shoes {
      public abstract String getName();
    }
    
    // concrete product 
    public abstract class NikeShoes extends Shoes {
      @Override
      public String getName() {
        return "Nike";
      }
    }
    
    public abstract class PumaShoes extends Shoes {
      @Override
      public String getName() {
        return "Puma";
      }
    }
    
    // product 추상 클래스 Tshirt
    public abstract class Tshirt {
      public abstract String getName();
    }
    
    // concrete product 
    public abstract class NikeTshirt extends Tshirt {
      @Override
      public String getName() {
        return "Nike";
      }
    }
    
    public abstract class PumaTshirt extends Tshirt {
      @Override
      public String getName() {
        return "Puma";
      }
    }
    ```

  - Factory

    ```java
    // Factory 추상 클래스
    public abstract class ShoesFactory {
      public abstract Shoes createShoes(String type);
    }
    
    public class BrandShoesFactory extends ShoesFactory {
      @Override
      public abstract Shoes createShoes(String type) {
        Shoes shoes = null;
        
        switch(type) {
            case("Nike")
              shoes = new NikeShoes();
              break;
            case("Puma")
              shoes = new PumaShoes();
              break;
        }
        
        return shoes;
      }
    }
    
    public abstract class TshirtFactory {
      public abstract Tshirt createTshirt(String type);
    }
    
    public class BrandTshirtFactory extends TshirtFactory {
      @Override
      public abstract Tshirt createTshirt(String type) {
        Tshirt tshirt = null;
        
        switch(type) {
            case("Nike")
              tshirt = new NikeTshirt();
              break;
            case("Puma")
              tshirt = new PumaTshirt();
              break;
        }
        
        return shoes;
      }
    }
    ```

  - Sportsware Factory

    ```java
    public class SportswareFactory {
      public void createSportsware(String type) {
        ShoesFactory shoesFactory = new BrandShoesFactory();
        TshirtFactory tshirtFactory = new BrandTshirtFactory();
          
        shoesFactory.createShoes(type);
        tshirtFactory.createTshirt(type);
      }
    }
    ```

  - Client

    ```java
    public class Client {
      public static void main(String args[]) {
        SportswareFactory factory = new SportswareFactory();
        factory.createSportsware("Nike");
      }
    }
    ```

&nbsp;

---

## Abstract Factory Pattern

**관련된 상품들 여러 개를 생산함** 

**단일 상품을 생산하는 여러 개 factory method를 가진 abstract factory. 상품들은 서로 관련된 family**

> Provide an interface for creating families of related or dependent objects without
> specifying their concrete classes.

- 관련된 객체들을 한꺼번에 캡슐화 하여 팩토리로 만들어서 일관되게 객체를 생성하도록 한다.
- factory method 여러 개 
  - 관련된 객체들을 각각 make()(create)

- example

  - Product - shoes, tshirt

    ```java
    // product 추상 클래스 Shoes
    public abstract class Shoes {
      public abstract String getName();
    }
    
    // concrete product 
    public abstract class NikeShoes extends Shoes {
      @Override
      public String getName() {
        return "Nike";
      }
    }
    
    public abstract class PumaShoes extends Shoes {
      @Override
      public String getName() {
        return "Puma";
      }
    }
    
    // product 추상 클래스 Tshirt
    public abstract class Tshirt {
      public abstract String getName();
    }
    
    // concrete product 
    public abstract class NikeTshirt extends Tshirt {
      @Override
      public String getName() {
        return "Nike";
      }
    }
    
    public abstract class PumaTshirt extends Tshirt {
      @Override
      public String getName() {
        return "Puma";
      }
    }
    ```

    

  - Factory interface

    ```java
    public interface SportswareFactory {
      public Shoes createShoes();
      public Tshirt createTshirt();
    }
    
    public class NikeFactory implements SportswareFactory {
      @Override
      public Shoes createShoes() {
        return new NikeShoes();
      }
      @Override
      public Tshirt createTshirt() {
        return new NikeTshirt();
      }
    }
    
    public class PumaFactory implements SportswareFactory {
      @Override
      public Shoes createShoes() {
        return new PumaShoes();
      }
      @Override
      public Tshirt createTshirt() {
        return new PumaTshirt();
      }
    }
    ```

  - Factory of Factory

    ```java
    public class SportswareFactoryCreator {
      public void createSportswareFactoryOf(String type) {
        SportswareFactory factory = null;
        
        switch(type) {
          case "Nike":
            factory = new NikeFactory();
            break;
          case "Puma":
            factory = new PumaFactory();
            break;
        }
        
        factory.createShoes();
        factory.createTshirt();
      } 
    }
    ```

  - Client

    ```java
    public class Client {
    	public static void main(String args[]) {
        SportswareFactoryCreator factoryCreator = new SportswareFactoryCreator();
        factoryCreator.createSportswareFactoryOf("Puma");
      }
    }
    ```

&nbsp;

## 공통점 & 차이점

### 공통점

1. 구조: factory, product 가 필요함 
   - Factory(Creator) : 객체 종류를 판단하고 생성 
   - Product : Factory에서 생성되는 객체의 공통 조상. Factory에서 생성되는 객체는 product를 상속받거나, 채택한 type이다.
2. 생성을 factory 에서 맡아서 함 - factory method에서 객체 생성 담당
   - factory method 인자에 따라 생성되는 객체가 결정된다.
3. 실제 구현대상인 concreate class/struct와 client 간의 결합도를 낮춘다.

&nbsp;

### 차이점

|                    | Factory Method                 | Abstract Factory                                         |
| ------------------ | ------------------------------ | -------------------------------------------------------- |
| 생성범위           | 한 Factory에 make() **한 개**  | 한 Factory 당, 연관된 **여러 종류(개)**의 make() 지원    |
| 객체 종류 결정     | 인자에 따라 객체 종류가 결정됨 | 인자에 따라 객체 생성을 담당하는 Factory의 종류가 결정됨 |
| 결합도 낮추는 대상 | ConcreteProduct & Client       | ConcreteFactory & Client                                 |
| Focus              | factory method 레벨에 집중     | Abstract Factory 레벨에 집중                             |
| 추상화 level       | method                         | class                                                    |

[참조](https://defacto-standard.tistory.com/42)

![factory method](https://i.stack.imgur.com/S4QMP.jpg)

![Abstract Factory](https://i.stack.imgur.com/C2F8L.jpg)

&nbsp;

#### Design Pattern

> Design patterns are blueprints which outline the best practices that create re-usable object oriented code, solving common software problems.

- best practice(모범사례) to solve sw problem

- Software Design Pattern - 크게 4가지로 구분된다 ([참조](https://en.wikipedia.org/wiki/Software_design_pattern#Creational_patterns))
- Creational Pattern : Factory Pattern이 소속된 카테고리
  - 객체 생성의 복잡도를 낮추는 모든 것을 다룬다.

&nbsp;

---

## Factory Pattern in Swift

- Protocol 사용 : Product 공통 조상 type으로 사용. 자격의 의미로 좀 더 유연하게 사용 가능

- Naming : swift api guidline - **팩토리 메소드 이름은** "make"로 시작하라. 예시) `x.makeIterator()`

- ex. Payable protocol & Card Factory

```swift
struct CardOwner {
    let name: String
    let cardtype: CardType
    
    enum CardType {
        case check, credit, prepaid
    }
}

protocol Payable {
    func pay()
}

struct CheckCard: Payable {
    let owner: CardOwner
    func pay() {
        print("\(owner.name) pays with check card")
    }
}

struct CreditCard: Payable {
    let owner: CardOwner
    func pay() {
        print("\(owner.name) pays with credit card")
    }
}

struct PrepaidCard: Payable {
    let owner: CardOwner
    func pay() {
        print("\(owner.name) pays with prepaid card")
    }
}

struct CardFactory {
    static func makeCard(for owner: CardOwner) -> Payable {
        switch owner.cardtype {
        case .check:
            return CheckCard(owner: owner)
        case .credit:
            return CreditCard(owner: owner)
        case .prepaid:
            return PrepaidCard(owner: owner)
        }
    }
}

let newCard = CardFactory.makeCard(for: CardOwner(name: "Diana", cardtype: .check))
newCard.pay()

```

