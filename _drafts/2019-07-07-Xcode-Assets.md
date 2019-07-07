---
layout: post
title:  "OOP + FP - 객제지향과 함수형 적절히 사용하기"
date:  2019-07-03 04:53:59
author: Dana Lee
categories: Programming
tags: [OOP, Functional Programming]
lastmod : 2019-07-03 04:53:59
sitemap :
  changefreq : weekly
  priority : 1.0
---

> App 을 만들 때 사용되는 resource 인 asset 을 어떻게 관리하는지 알아보기

## Asset ?

images, sprites, textures, stickers, and data 같은 앱에서 사용되는 자료(resource)를 의미한다.

&nbsp;

## Asset Catalog ?

>  앱을 만들기 위해 사용되는 서로 다른 타입의 asset들을 관리하기 위해 사용하는 도구

에셋 카탈로그는 에셋과 다양한 디바이스의 속성에 대한 파일의 연결을(mapping) 통해서 애플리케이션 리소스에 쉽게 접근할 수 있도록 도와준다. (리소스는 애플리케이션이 실행 중일 때 사용하는 이미지와 음악 파일 등을 말합니다.) 여기서 말하는 속성은 디바이스의 특징, 사이즈 클래스, 주문형 리소스, 특정 타입의 정보를 포함하고 있습니다. 

project 를 생성하면  `Assets.xcassets` 가 디폴트로 생성되어 있다. 이는 전체 Asset Catalog의 가장 상위 폴더(top level folder of asset catalog)이다. 이 최상위 asset catalog 는 다른 하위 asset catalog를 포함할 수 있다.

&nbsp;

### 생성 방법

1. single view app 등 template 으로 프로젝트를 생성하면 자동으로 `Assets.xcassets`가 생성된다.
2. `Add new file from a template` → `Resource` 에 `Asset Catalog` 선택하여 생성

&nbsp;

### 왜 Asset Catalog, 관리하는 방식이 별도로 필요할까?

iOS App 에서는 가장 중요하게 여기는 부분이 바로 서로 다른 특성의 기기(다른 사이즈, 다른 해상도)에서도 동일하게 보여야 한다는 점이다. 즉, 이 앱이 아이패드에서도 화면 깨짐이나 안보이는 부분 없이 동작해야 하고, 내 오래된 아이폰 6에서도 똑같이 동작하고 안보이는 부분 없이 동작해야 한다. 

서로 다른 특성의 여러 device 를 지원하기 위한 파일 묶음(집합)을 관리하기 위해서 asset catalog가 필요하다. 예를 들어, 같은 모양의 앱 아이콘이어도 서로 다른 디바이스에서 잘 보여지도록 2x, 3x사이즈를 지원해야 한다. 여러 사이즈의 아이콘 이미지가 한 계층에 주르륵 있어도 괜찮지만, 다른 이미지나 리소스가 많다면 묶음 지어 한 그룹에 넣는 것이 관리하기 편할 것이다. assset catalog 안에 한 그룹을 만들어 앱 아이콘 이미지들을 넣고 앱 아이콘이라고 알려주면 알아서 관리해준다.

![](https://help.apple.com/xcode/mac/current/en.lproj/Art/as_about_asset_catalogs.png)[*출처 - Xcode help*](https://help.apple.com/xcode/mac/current/#/dev10510b1f7)

앱 아이콘 이미지들이 위에서부터 아래로 주르륵 나열되어 있을 수도 있지만, appicon 이라고 알려주면 assset catalog 가 저렇게 한 페이지 안에 종류별로 잘 나누어 관리해준다.



### 구조, 구성

asset catalog 는 관련된 asset 들을 그룹짓는 폴더와 `Contents.`json` 파일로 구성된다.

```
Assets.xcassets
|-- AppIcon.appiconset
|  |- Icon-Small...2x.png
|  |- Icon-...png
|  |- Contents.json
|-- sound.dataset
|  |- sound.mp3
|  |- contents.json
```

각 folder 이름 뒤에 `.appiconset`, `.dataset`이라고 붙여져있다. 이는 각 그룹의 타입을 알려주는 것이다. 이는 미리 사전에 약속된 이름이다.

또 각 폴더에 `Contents.json` 이란 이름의 json 파일이 있다. 이는 각 asset catalog 의 metadata를 명세하고 있다. 메타 데이터란 데이터의 데이터로, 각 그룹이 어떤 특성을 나타내고, 어떤 데이터 속성을 가진 리소스가 있는지 알려주는 역할을 한다.

>  The `Contents.json` file specifies metadata for the asset catalog, attributes for a folder type, and attributes for asset files.

### Asset Types

> The folders in asset catalogs represent the overall asset catalog, groups of assets and other groups, and several different types of assets. Some of the asset types in a catalog work only with selected Apple platforms.

asset catalog 안에 있는 폴더의 이름은 해당 폴더에 들어있는 content를 대표하기도 한다. type extension 처럼 `폴더이름.확장자` 로 명시해서 해당 그룹에 있는 asset의 특성을 나타낸다.



## :mag: 

app thining

https://www.edwith.org/boostcourse-ios/lecture/16842/

app slicing

target device & os 에 맞는 구조와 리소스만 생성하고 전달하는 것

https://help.apple.com/xcode/mac/current/#/dev10510b1f7

[Asset Catalog Format Reference](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/AssetTypes.html)

