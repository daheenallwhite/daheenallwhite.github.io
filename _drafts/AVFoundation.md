---
layout: post
title:  "[iOS] QR Code Reader 만들기 - AVFoundation"
date:  2019-10-13 16:08:59
author: Dana Lee
categories: [iOS]
tags: [AVFoundation, AVSession]
lastmod : 2019-10-13 16:08:59
sitemap :
  changefreq : weekly
  priority : 1.5
---

# QR Code Reader 만들기 - AVFoundation

ios app에서 QR code를 스캔하고, 해당 QR 코드가 나타내는 문자열- 여기선 구체적으로 웹사이트 url 로 - 의 주소로 safari를 열어보는 기능을 구현해보자.

### What to do?

- 카메라 권한 허용 받기 - QR code 읽기 위해서
- AVFoundation 을 사용하여 input, output 을 받자



## AVFoundation

> Work with audiovisual assets, control device cameras, process audio, and configure system audio interactions

AVFoundation 은 **시청각(audiovisual) Media 와 관련된 작업을 가능하게 해주는 프레임워크**이다. 미디어엔 사진, 동영상, 음성 녹음 등이 포함 되며 이를 capturing 하기 위한 camera, microphone 등이 control 가능한 대상이 된다. 간단히 말해서 눈으로 보고, 귀로 듣는 것을 그대로 ios 기기가 캡처하고 이를 처리할 수 있도록 도와주는 환경이 구성된 프레임워크다

이 시청각 미디어로 다음의 작업들이 가능하다

- capturing 
- processing
- synthesizing (합성)
- controlling
- importing & exporting



### AVFoundation  vs.  AVKit  :confused:

미디어를 다룰 수 있는 Framework 에는 AVKit 도 있는데, 이와 AVFoundation 은 뭐가 다른 것일까??

![](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MediaPlaybackGuide/Contents/Resources/en.lproj/Art/media_playback_framework_2x.png)

#### 차이점 

- AVKit 은 AVFoundation 의 위에서 만들어진 프레임워크로 좀 더 사용자를 위한 playback interface 를 쉽게 만들기 위해 제공된다. 
- 자동으로 media 에 따른 조작 interface를 결정함. 
- 비디오에 더 특화되어 있음. 
- AVKit 은 AVFoundation, UIKit 위에서 만들어진 좀더 보조적인 프레임워크이다.

#### Then, what to use?

AVFoundation - 내가 직접 interface를 만들고 싶다

AVKit - UIKit 위에 잘 만들어진 기본 제공 interface로 미디어를 다룰거야



&nbsp;

## Cameras and Media Capture

QR 을 카메라로 찍어서(capturing media) 이를 분석해야 된다

### AVFoundation Capture Subsystem 

video, photo, and audio capture를 위한 고차원 구조의 서비스를 지원함 (iOS, macOS)

### Capture Architecture

미디어를 캡쳐하기 위한 핵심 구조는 크게 세가지로 구성된다.

![](https://docs-assets.developer.apple.com/published/058e665a6c/4ecf0924-ea2b-4faa-aea8-7bfc0b3fe419.png)

1. session
2. input
3. output

### Session

> 하나 이상의 input을 하나 이상의 output 과 연결해주는 역할<br>
>
> capture session connect one or more inputs to one or more outputs

### Input - Device & Input

> device 및 이를 통해 얻을 수 있는 media 전체를 의미함 <br>
>
> source of media, including capture devices like the cameras and microphones built into and ios device or mac



### Output

> input 이 처리된 형태 <br>
>
> outputs acquire media from inputs to produce useful data, such as movie files written to disk or raw pizel buffers available for live processing



## Flow

- Camera(Device) authorization 받기
- Capture Session 세팅하기
  - QR Code 만 받도록 설정
- Capture Output 받아서 내가 하고 싶은 처리하기

&nbsp;

## Ask User for authorization of using camera

QR 코드 스캔하기 위해 카메라를 사용해야 함

사용자에게 카메라 사용 허용(authorization)을 받아야 함

iOS 에서는 항상 명시적으로 app의 카메라나 microphone 사용 권한을 사용자로부터 받아야한다. (이래서 ios 가 더 안전하다고 하는 부분이기도 함) 

그러기 위해선?

1. info.plist 에 NSCameraUsageDescription key를 추가한다 - 사용자에게 권한 요청할 때의 description을 넣는다
   - **Privacy - Camera Usage Description** 
2. `AVCaptureDevice.authoricationStatus(for: )` 로 허용 상태를 확인한다 (항상 확인하고 처리할 것을 권장함)
   - 상태 종류
   - `notDetermined` - 허용 한번도 안한 상태
   - restricted
   - denied
   - authorized
3. 권한이 없다면 요청한다 - `AVCaptureDevice.requestAcess(for: .video)`
   - AVCaptrueDeviceInput 객체를 처음으로 생성시, 시스템이 자동으로 사용권한 request를 보내준다.



## Make Camera View 

`AVCaptureVideoPreviewlayer`

### :pushpin: Reference

- [Cameras and Media Capture](https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture)
- [About Media Playback](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MediaPlaybackGuide/Contents/Resources/en.lproj/Introduction/Introduction.html#//apple_ref/doc/uid/TP40016757-CH1-SW1)
- [AVKit & AVFoundation - ZeddiOS](https://zeddios.tistory.com/526)