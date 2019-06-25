---
layout: post
title:  "Swift JSON 관련 라이브러리 - JSONSerialization, JSONEncoder, JSONDecoder, Codable"
date:  2019-06-25 16:54:59
author: Dana Lee
categories: Swift
tags: [JSON, JSONSerialization, JSONEncoder, JSONDecoder, Codable]
---

*Swift Foundation 프레임워크에서 제공하는 JSON 관련 라이브러리*

크게 3가지 파트로 나누어진다.

- JSON 데이터를 담을 자료구조 - Data
- JSON 데이터로 변환될 수 있는 instance type 조건 - Codable protocol
- Encode, Decode 해주는 class - JSONSerialization, JSONEncoder, JSONDecoder

&nbsp;

## Swift 에서 JSON 를 담는 자료구조

Foundation 에서는 JSON 데이터를 그에 맞는 object로 변환하고, 다시 JSON으로 바꾸는 유틸리티 class 를 제공한다.

이 클래스들을에게 일을 맡기기 위해서는 JSON 을 전달해야 한다. JSON 데이터를 그냥 `String` 에 담아서 보내면 될까?

정답은 **NO! 아니다**. :star: JSON 데이터는 `Data` 라는 struct 에 담겨서 전달된다. :star: `String` 을 사용하지 않는다.

```json
{
   "name" : "Pear",
   "points" : 250,
   "description" : "A ripe pear."
 }
```

그럼 `Data` 구조체는 대체 무엇일까?

## Data

> A byte buffer in memory.

```swift
struct Data
```

- byte 단위 버퍼
- `NSData` 와 bridged 됨. (연결, 호환됨)
- 사용자로부터 입력받은 데이터가 `String` 인스턴스에 담겨있다면 `Data` type 으로 변환이 필요하다
- `String` 에 `Data` type 으로 변환하는 method 가 있음 (엄밀히 말하면 `NSString` 에 있음)



### String & Data 관계

- `String` 은 performance 를 위해 [***copy-on-write***](https://daheenallwhite.github.io/swift/2019/06/04/copy-on-write/) 를 채택하는 타입이다 

- 문자열 데이터를 버퍼에 저장하고, 복사시엔 이 버퍼의 주소를 참조해서 여러 변수에서 공유한다.

- String 은 lazily copied - 변형이 필요할 때만 복사된다 (cow) 

  - 변형이 필요한 때 == 한 개 이상의 string 이 같은 버퍼를 사용할 때

- String :left_right_arrow: Data 가능

- `String` 은 `NSString` 과 bridged 됨

- `NSString` 에 `Data` 타입으로 변환하는 method 가 있음

  ```swift
  func data(using encoding: String.Encoding, allowLossyConversion: Bool = false) -> Data?
  ```

- String → Data 변환하기

  ```swift
  let data = "hello".data(using: .utf8) // Optional(Data)
  ```

&nbsp;

---

## JSONEncode,  JSONDecoder

Encode : 암호화한다. 변환한다. / Decode : 해독한다. 푼다

| JSONEncoder     | JSONDecoder     |
| --------------- | --------------- |
| instance → JSON | JSON → instance |

&nbsp;

### JSONEncooder

*JSON Data로 변환한다*

- `Codable (Encodable)` protocol 을 준수한 type 만 JSON 으로 인코딩 가능 (encodable as JSON)

- 방법

  1. `JSONEcoder` instance 생성

  2. `encode` method - 변환될 object(Codable 준수) 를 넘기면 `Data` 타입의 JSON 을 반환

     ```swift
     func encode<T>(_ value: T) throws -> Data where T : Encodable
     ```

     > Returns a JSON-encoded representation of the value you supply.

     

- *Example*

  ```swift
  struct Point: Codable {
    let x, y : Int
  }
  
  let origin = Point(x: 0, y: 0)
  
  // 1. encoder instance 생성
  let encoder = JSONEncoder()
  encoder.outputFormatting = .prettyPrinted // 출력용 설정
  
  // 2. encode method 로 Codable 준수하는 타입의 instance 넘기기
  let data = try encoder.encode(origin)
  
  print(String(data: data, encoding: .utf8)!) 
  //optional forced unwrapping
  
  /* 출력 결과
  {
    "x" : 0,
    "y" : 0
  }
  */
  ```

  

### JSONDecoder

*JSON Data 기반으로 인스턴스를 생성한다*

> An object that decodes instances of a data type from JSON objects.

- Codable (Decodable) protocol 을 준수한 type 만 JSON 데이터를 기반으로 object를 생성할 수 있음

- 방법

  1. JSON 데이터를 Data 인스턴스로 생성한다

  2. JSONDecoder instance 생성

  3. decode method - 타입과 JSON Data instance를 넘긴다.

     ```swift
     func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
     ```

- *Example : JSON Data → Point instance* 

  ```swift
  let jsonString = """
  {
      "x" : 10,
      "y" : 10
  }
  """
  
  // 1. JSON 데이터를 담은 Data 인스턴스 생성 
  let jsonData = jsonString.data(using: .utf8)!
  
  // 2. decoder 인스턴스 생성
  let decoder = JSONDecoder()
  
  // 3. 타입과 json data 를 decode method 에 넘기면 Point 인스턴스 반환
  let point = try decoder.decode(Point.self, from: jsonData)
  
  
  print(point)
  /* 출력 결과
  Point(x: 10, y: 10)
  */
  ```

  

## Codable = Encodable & Decodable

- JSONEcoder 를 사용해서 JSON object 로 변환(encode)될 수 있는 타입 : `Encodable` protocol 을 준수하는 타입

- JSONDecoder 를 사용해서 JSON 데이터를 기반으로 인스턴스를 생성하려면 그 타입은 `Decodable` protocol 을 준수해야 함



`Codable` : composition of protocol `Encodable` & `Decodable`

> A type than can convert inself into and out of an external representation

```swift
typealias Codable = Encodable & Decodable
```

&nbsp;

## JSONSerialization

> An object that converts between JSON and the equivalent Foundation objects

```swift
class JSONSerialization : NSObject
```

JSON :left_right_arrow: Foundation objects : 양방향 변환 가능



### Foundation objects 는 다음 속성을 따라야 한다

다음 특성을 따라야지 JSONSerialization 으로 JSON 혹은 원래 object로 변환 가능

- The top level object is an [`NSArray`](apple-reference-documentation://hs6kPwmYay) or [`NSDictionary`](apple-reference-documentation://hshyUEelwn).
- All objects are instances of [`NSString`](apple-reference-documentation://hsdPnFRdoM), [`NSNumber`](apple-reference-documentation://hsUmJk5ebq), [`NSArray`](apple-reference-documentation://hs6kPwmYay), [`NSDictionary`](apple-reference-documentation://hshyUEelwn), or [`NSNull`](apple-reference-documentation://hssr67HlQF).
- All dictionary keys are instances of [`NSString`](apple-reference-documentation://hsdPnFRdoM).
- Numbers are not NaN or infinity.



### :pencil2: 중요 메소드

#### Encoding : object to JSON Data 

```swift
class func data(withJSONObject: Any, options: JSONSerialization.WritingOptions) -> Data
//Returns JSON data from a Foundation object.

class func writeJSONObject(Any, to: OutputStream, options: JSONSerialization.WritingOptions, error: NSErrorPointer) -> Int
// Writes a given JSON object to a stream.
```



#### 인스턴스가 JSON Data 로 변환될 수 있는 타입인지 확인하기

```swift
class func isValidJSONObject(Any) -> Bool
// Returns a Boolean value that indicates whether a given object can be converted to JSON data.
```



#### Decoding : JSON to object  (Creating JSON object)

```swift
class func jsonObject(with: Data, options: JSONSerialization.ReadingOptions) -> Any
//Returns a Foundation object from given JSON data.

class func jsonObject(with: InputStream, options: JSONSerialization.ReadingOptions) -> Any
// Returns a Foundation object from JSON data in a given stream.
```

&nbsp;

---

## :pushpin: Reference

- [ZeddiOS 블로그 - 왕초보를 위한 JSON parsing 2](https://zeddios.tistory.com/148)
- Apple Developer Documentation
- [swift source code - JSONEncoder](https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/JSONEncoder.swift)
- [swift source code - JSONSerialization](https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/JSONSerialization.swift)

&nbsp;