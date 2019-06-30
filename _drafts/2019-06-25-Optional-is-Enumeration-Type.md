# Optional 은 어떻게 구현되어 있을까?

> Optional : A type that represents either a wrapped value or `nil`, the absence of a value.

## Optional 은 enum type 이다

```swift
enum Optional<Wrapped> {
  case none // nil
  case some(Wrapped)
}
```

```swift
let short: Int? = 2
let long: Optional<Int> = 2
```



## :pushpin: Reference

- [Optional\<Wrapped> source code](https://github.com/apple/swift/blob/master/stdlib/public/core/Optional.swift)
- [documentation - optional](https://developer.apple.com/documentation/swift/optional)