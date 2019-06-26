---
layout: post
title:  "[Swift] JSON parser 구현하기"
date:  2019-06-25 17:48:59
author: Dana Lee
categories: Swift
tags: [JSON, JSON parser]

---

## 전체 구조

### 실행 순서

1. 입력 : `InputView` 
2. JSON 형식 체크 : `GrammarChecker` - regex pattern로 체크
3. 의미 단위로 나누기 : `Tokenize` - 공백 기준으로 나누고 String 배열로 반환
4. 토큰 파싱 : `Parser` - 재귀 호출로 구현
5. 출력 : `OutputView` - 모든 출력을 담당하는 구조체



### 그외 유틸리티

- `TokenReader` : tokenize 완료된 token 배열을 순서대로 읽어줌. Parser 에서 사용
- `RegexPattern` : regex 패턴 조합하는 역할
- `TypeCounter` : TypeCountable protocol을 준수하는 타입이 가진 value의 타입과 그 개수를 센다
- `JSONValueFactory`: JSON Value 를 생성하는 팩토리 패턴 구조체
- `JSONParserError` : json parser 에서 발생하는 error 는 채택해야 하는 protocol 
- `JSONSymbols` : json 에서 사용되는 기호를 담은 struct
- `StringInterpolation` : string interpolation `appendInterpolation()` extend



### JSON 데이터 담을 자료구조

`JSONValue` protocol 에 JSON 데이터의 자격요건을 명시하고, 다음 타입에서 준수한다. 

- `Bool`, `String`, `Int`(Number)
- `Array`
- `Dictionary` - JSON object

`Array`, `Dictionary`(object) 는 compound type으로 JSON value 를 자신의 속성으로 다시 담을 수 있는 중첩구조이다. 

이 타입들은 `TypeCountable` protocol 을 구현해서 그 안의 element 를 반환한다.



## uml

![]({{site.url}}/assets/post-image/jsonparser-class-diagram.png)



## source code

 [📎 swift jsonparser](https://github.com/daheenallwhite/swift-jsonparser/tree/daheenallwhite/JSONParser)



## Featured Code

### TypeCountable & TypeCounter

`Array`, `Dictionary` 가 `JSONValue` 를 가지고 있을 때, 채택하는 `TypeCountable` protocol

```swift
protocol TypeCountable {
    var elementCount: Int { get }
    var elements: [JSONValue] { get }
}

extension Array: TypeCountable where Element == JSONValue {
    var elementCount: Int {
        return self.count
    }
    var elements: [JSONValue] {
        return self
    }
}

extension Dictionary: TypeCountable where Key == String, Value == JSONValue {
    var elementCount: Int {
        return self.count
    }
    var elements: [JSONValue] {
        return Array(self.values)
    }
}
```



TypeCounter 는 [typeDescription : count] 를 반환한다. 

- typeDescription : "부울", "문자열", "배열" 같은 json value 타입에 대한 설명

```swift
struct TypeCounter {
    static func getTotalTypeCount(of value: JSONValue & TypeCountable) -> [String : Int] {
        let elements = value.elements
        var typeCount = [String : Int]()
        for element in elements {
            typeCount[element.typeDescription, default: 0] += 1 
        }
        return typeCount
    }
}
```



Dictionary 에서 `[] subscript` 와 default value 넣기

key에 해당하는 value를 반환하는데, 해당하는 key에 대해 value 가 없다면 default value와 페어링해서 넣는다.

```swift
subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value { get set }

dictionary[key: key, default: defaultValue] // 이렇게 씀
```

> Accesses the value with the given key. If the dictionary doesn’t contain the given key, accesses the provided default value as if the key and default value existed in the dictionary. ([documentation](https://developer.apple.com/documentation/swift/dictionary/2894528-subscript))



### 다형성(Polymorphism) 이용한 JSON 포맷대로 출력하기

- `JSONValue` 에 `formatted()` method 를 명시한다
- 채택한 타입에서 `formatted()` 구현한다
- `Array`, `Dictionary` 의 경우, element, value 에 대해 `formatted()` method 다시 재귀적으로 호출한다
- `OutputView`에서 `jsonvalue.formatted()` 호출시 재귀호출 이용하여 보기좋은 형태로 json 문자열을 반환해준다.
- [JSONValue.swift](https://github.com/daheenallwhite/swift-jsonparser/blob/daheenallwhite/JSONParser/JSONParser/JSONValue.swift)