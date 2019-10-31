---
layout: post
title:  "[iOS] Promise 로 Delegate 패턴 대체하기"
date:  2019-10-31 20:54:59
author: Dana Lee
categories: [iOS]
tags: [google promises, promises, 비동기]
lastmod : 2019-10-31 20:54:59
sitemap :
  changefreq : weekly
  priority : 1.5
---

# Promises 로 Delegate 패턴 대체하기

## Promises 란?

Swift 에서 비동기 처리를 Promise 라는 객체로 묶어서 그 상태 값이 결정되면(resolved) 다음 동작을 할 수 있게끔 구현한 구조이다. 

### Swift 에서의 비동기 처리

Swift에서는 비동기 처리를 주로 completion handler 와 delegate 를 사용해서 처리한다. 작업을 맡긴 후, 완료가 되면 completion handler가 호출되거나, 해당 event를 delegate 에 알려서 delegate 가 그에 맞는 추가 처리를 하도록 한다.

비동기 처리에 모두 Promises 를 적용해볼 수 있다.

이런 비동기 처리는 가독성이 떨어진다. 특히  중첩 레벨이 늘어나면서 가독성이 현저히 늘어간다. Promises 는 이런 비동기 처리에서의 가독성과 퍼포먼스를 높여준다.

특히 다른 thread 에서 처리하다가 main thread 에서 ui 업데이트를 할 때, 다음과 같은 코드가 꼭 들어가야 하는데 이게 if 문안에 있다면 일단 tab을 세번 들어가니 지저분해 보이기 시작한다.

```swift
if success {
	DispatchQueue.main.async {
		self.textField.text = "completed"
	}
}
```

&nbsp;

## Delegate 패턴

Delegate 패턴의 핵심은 내가 지금 하고 있는 일을 관심있어하는 delegate 에게 알려주는 것이다. 그럼 그에 맞는 처리는 delegate 에서 한다.

&nbps;

## Deleate -> Promises로 전환하기

나는 날씨앱 클론 프로젝트에서 ViewController 의 생명주기에 Promise 를 적용해보기로 했다.

도시 검색을 하는 ViewController 에서 유저가 리스트에서 특정 도시를 입력하면 리스트에 해당 위치가 저장되고, 해당 VC 는 dismiss 되면 되기 때문에 가장 적절하다고 생각했다. Promise 는 pending 상태에서 resolved (fulfill or reject) 되면 그 다음 then operator 나 catch operator 를 탈 수 있기 때문이다.

기존 구조에서는 두 ViewController 간에 delegate를 사용해서 데이터를 주고 받았다.

&nbsp;

앱의 전체 구조는 다음과 같다.

![](https://github.com/daheenallwhite/WeatherApp/raw/master/images/implementation-1.jpeg)

여기서 SearchViewController 는 특정 도시가 선택되면 dismiss 되므로 이 때, promise 객체가 **pending → fulfill** 로 상태를 바꿔주면 된다. promise 가 **resolved** 되면서 **location** 을 LocationListViewController로 넘겨주면 된다.

🔗 해당 프로젝트 코드는 [여기](https://github.com/daheenallwhite/WeatherApp/tree/promises)에서 볼 수 있다. 

&nbsp;

### 1. SearchViewController 에 promise property 추가하고 delegate 없애기

`SearchViewController` 내에 promise property 를 추가한다. 이는 Location 객체를 감싸는 형태이다. 

처음 시작할 땐, Location 이 어떤 상태의 객체인지 모르므로 pending 으로 생성해준다.

```swift
// SearchViewController.swift

class SearchViewController: UIViewController {
    static let identifier = "SearchViewController" 
    private let searchTableCellIdentifier = "searchResultCell"
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var searchResultTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var promise: Promise<Location> = Promise<Location>.pending() 
  	// pending 상태의 promise를 정의와 함께 생성해줌
...
```

&nbsp;

### 2. location search 가 완료되면 이제 promise를 fulfill 하자

사용자가 테이블 특정 row 선택하면 그에 맞는 위치를 search 했다. 이 search 완료되면, 관련된 delegate 의 method 를 불렀다. 

이제는 `SearchViewController` 가 가진 promise 를 결과 location 객체로 fulfill 해주면 된다. 원하지 않는 결과일 땐, error 와 reject 을 처리하면 된다.

```swift
// SearchViewController.swift
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else { //원하지 않는 결과일 땐, error 와 reject 을 처리하면 됨
                self.promise.reject(LocationError.localSearchRequstFail)
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                self.promise.reject(LocationError.localSearchRequstFail) 
                return
            }
            let coordinate = Coordinate(coordinate: placeMark.coordinate)
            let locationName = "\(placeMark.locality ?? selectedResult.title)"
            let location = Location(coordinate: coordinate, name: locationName)
            self.promise.fulfill(location)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
```

&nbsp;

### 3. LocationListViewController 에서 SearchViewController를 부를 type method 를 정의한다

자기 자신 객체를 생성하고 자신의 promise 객체를 return 한다.

```swift
// SearchViewController.swift
extension SearchViewController {
    static func start(on baseViewController: UIViewController) -> Promise<Location> {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let searchViewController = mainStoryboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as? SearchViewController else {
            CreationError.toSearchViewController.andReturn()
        }
        baseViewController.present(searchViewController, animated: true, completion: nil)
        return searchViewController.promise
    }
}
```

&nbsp;

### 4. LocaionListViewController에서 +버튼 누르면 SearchViewController 의 promise 에 달린 생명주기를 시작하게 한다

SearchViewController 가 가진 promise 객체가 resolved 되면, then 블록의 메소드를 탄다. 더이상 delegate로 서로를 참조하고 관련 메소드를 부를 필요가 없다. 

```swift
//LocationListViewController.swift
@IBAction func addLocationButtonTouched(_ sender: Any) {
        SearchViewController.start(on: self)
        .then { location in
            self.userAdd(newLocation: location)
        }
    }
```

&nbsp;

핵심은 promise 객체의 상태가 fulfill 이든 reject 이든 resolved(결정) 된다면, 이는 처리가 완료되었다는 뜻이고, 다음 처리로 갈 수 있게된다. 

promise로 비동기 처리를 가독성 좋게 바꿀 수 있다고 공식문서에서는 설명했지만 실제로 구현해보기 전까진 제대로 이해하지 못했다.

이런 방식으로 CoreLocation 의 Location 검색이 완료되면 다음 처리를 하도록 promise를 적용해 볼수도 있다.



---

### 📌 Reference

- [google promises](https://github.com/google/promises)

- [weather app project - promises branch](https://github.com/daheenallwhite/WeatherApp/tree/promises)

  