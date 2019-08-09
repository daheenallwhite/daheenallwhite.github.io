---
layout: post
title:  "[iOS] MapKit 으로 위치 검색 자동완성 구현하기"
date:  2019-08-07 23:36:59
author: Dana Lee
categories: iOS
tags: [MapKit, 지도 앱, 위치 검색 자동완성, 위치 자동완성, MKLocalSearchCompleter]
lastmod : 2019-08-09 12:13:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

[**MapKit**](https://developer.apple.com/documentation/mapkit) 은 Apple 에서 제공하는 지도 관련된 모든 기능을 구현하도록 도와주는 framework 이다. 지도나 인공위성 사진을 앱 안에서 사용할 수도 있고, 장소의 위도/경도를 포함한 위치 정보도 알 수 있다. 🧭

그 중에서, 위치 검색 자동완성을 위해 필요한 부분은 **MapKit** 중에서 **Placemark and Local Search** 카테고리의 class 들이다. 해당 카테고리는 원하는 위치를 검색하고 사용자가 입력한 문구에 따른 검색 자동완성을 구현한 클래스들이 있다.

MapKit 의 이 클래스들을 활용하여 다음과 같은 위치 자동완성 기능을 구현해보자. 😆

![](https://github.com/daheenallwhite/WeatherApp/raw/master/images/display-6.gif)

&nbsp;

## MKLocalSearch

> 지도 기반 검색과 그 결과를 관리하는 유틸리티 object

이 클래스는 네트워킹과 유사하게 위치 정보에 대한 request 객체를 initializer 에 넘겨 생성 후, `start()` method 로 검색하여 completion handler에서 response 를 받을 수 있다. 한 개의 search request 만 실행될 수 있다. 

초기화는 `MKLocalSearch.Request` 타입 객체를 넘겨 진행되며, response 타입엔 `MKMapItem` 배열이 들어있다. 이는 해당 지점의 정보와 `MKPlacemark` 객체를 가지고 있다. `MKPlacemark` 에 바로 위도/경도 값이 들어있다.

&nbsp;

## MKLocalSearchCompleter

이 클래스에 자동 완성 제안을 불러오는 기능을 구현해 놓았다

### queryFragment - 검색어 자동 완성 이용하기

> 자동완성 되길 원하는 대상 string

이 property 에 원하는 검색 string 값을 할당하면 `MKLocalSearchCompleter` 객체가 자동완성한 결과를 자신의 delegate 의 `completerDidUpdateResults()` method 에 넘겨준다.

자동완성된 결과는 `MKLocalSearchCompletion` 배열로 전달된다. 이 클래스는 부분 문자열을 자동완성한 결과를 `title`, `subtitle` 등의 property 에 담고있다. 

delegate 는 `MKLocalSearchCompleterDelegate` protocol type 이다. 

`MKLocalSearchCompleter` 로 검색을 구현하는 원리는 다음과 같다.

![](https://github.com/daheenallwhite/WeatherApp/raw/master/images/implementation-search.jpeg)

&nbsp;

## 위치 검색 자동완성 구현하기

사용자가 search bar 에 위치를 검색하면 바로 자동완성된 위치들이 Table View 에 나타나는 기능을 구현해보자. 

1. `UISearchBarDelegate` - `textDidChange` method
   - 검색창의 text 가 변했을 경우 search bar 가 delegate 에 알리는 method
   - 여기서 검색 대상 text를 queryFragment 에 넘긴다
2. `MKLocalSearchCompleterDelegate` - `completerDidUpdateResults` method
   - 위치 자동완성이 끝나면 completer 가 호출하는 delegate method
   - 여기서 자동완성 결과를 Table View 의 data source에서 참조하는 변수에 할당한 뒤, table view 의 reloadData() method 를 호출 -> 자동완성된 결과가 table 에 나오게 됨
3. 자동완성 된 결과 중, 사용자가 선택한 table cell 의 구체적인 위치정보를 알고 싶다면?
   - `MKLocalSearch.Request` & MKLocalSearch class 를 사용하여 검색 요청을 던져 reponse 를 받는다
   - 선택한 cell 에 맞는 `MKLocalSearchCompletion` 객체로 `MKLocalSearch.Request` 객체를 만든다
   -  Request 객체로 다시 `MKLocalSearch` 객체를 만들어 `start()` method 를 호출하여 검색 결과를 받는다. 

&nbsp;

구현한 코드는 다음과 같다 ([github repo]([https://github.com/daheenallwhite/WeatherApp/blob/master/WeatherApp/WeatherApp/View%20Controllers/WeatherViewController.swift](https://github.com/daheenallwhite/WeatherApp/blob/master/WeatherApp/WeatherApp/View Controllers/WeatherViewController.swift)))

```swift
class SearchViewController: UIViewController {
    static let identifier = "SearchViewController" 
    private let searchTableCellIdentifier = "searchResultCell"
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var searchResultTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: SearchViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.showsCancelButton = true
        self.searchBar.becomeFirstResponder()
        self.searchCompleter.delegate = self
        self.searchCompleter.filterType = .locationsOnly
        self.searchBar.delegate = self
        self.searchResultTable.dataSource = self
        self.searchResultTable.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchResults.removeAll()
            searchResultTable.reloadData()
        }
      // 사용자가 search bar 에 입력한 text를 자동완성 대상에 넣는다
        searchCompleter.queryFragment = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: MKLocalSearchCompleterDelegate {
  // 자동완성 완료시 결과를 받는 method  
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultTable.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(LocationError.localSearchCompleterFail)
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTable.dequeueReusableCell(withIdentifier: searchTableCellIdentifier, for: indexPath)
        let searchResult = searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
  // 선택된 위치의 정보 가져오기
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                print(LocationError.localSearchRequstFail)
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            let coordinate = Coordinate(coordinate: placeMark.coordinate)
            self.delegate?.userAdd(newLocation: Location(coordinate: coordinate, name: "\(placeMark.locality ?? selectedResult.title)"))
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}

```

&nbsp;

## :mag: 더 알아보기

[공식 문서](https://developer.apple.com/documentation/mapkit/searching_for_nearby_points_of_interest)에서는 search bar delegate method 를 사용하지 않고, `UISearchResultsUpdating` protocol 로 구현하는 방법을 제안했다. 

```swift
func updateSearchResults(for searchController: UISearchController)
```

이 method는 search bar 가 first responder(이벤트를 처리하는 responder chain 에서 가장 앞에 있는 요소) 이거나, 사용자가 search bar 에 어떤 변화를 주었을 때 호출된다. 이 method 구현부에서 `queryFragment` 에 사용자가 입력하는 문자열을 할당하면 되겠다.

[`UISearchController`](https://developer.apple.com/documentation/uikit/uisearchcontroller) 는 search bar 기반으로 검색 결과를 보여주는 역할을 담당하는 ViewController 의 하위 클래스라고 한다. 이 클래스는 이미 search bar 를 내장하고 있다고 한다. 검색에 관련된 protocol 로 updater 속성도 있어 검색에 최적화된 view controller class 인 듯하다. 다음에 검색관련 scene에 사용해봐야겠다.

---

### 📌 Reference

- [Searching for Nearby Points of Interest](https://developer.apple.com/documentation/mapkit/searching_for_nearby_points_of_interest)
- [MKLocalSearchCompleter](https://developer.apple.com/documentation/mapkit/mklocalsearchcompleter)
- [UISearchController](https://developer.apple.com/documentation/uikit/uisearchcontroller)

