import Foundation

//protocol Subject {
//    func register(observer: Observer)
//    func remove(observer: Observer)
//    func notify(with data: String)
//}
//
//protocol Observer {
//    var id: String { get }
//    func update(_ updatedValue: String)
//}
//
//
//class Youtuber: Subject {
//    let name: String
//    var subscribers = [Observer]()
//
//    init(name: String) {
//        self.name = name
//    }
//
//    func register(observer: Observer) {
//        subscribers.append(observer)
//    }
//
//    func remove(observer: Observer) {
//        subscribers.removeAll(where: {$0.id == observer.id})
//    }
//
//    func notify(with videoTitle: String) {
//        for subscriber in subscribers {
//            subscriber.update(videoTitle)
//        }
//    }
//
//    func uploadVideo(title: String) {
//        print("\(self.name)이 새로운 영상 \(title)을 업로드 했습니다.")
//        notify(with: title)
//    }
//}
//
//class Subscriber: Observer {
//    var id: String
//    var nickname: String
//    init(id: String, nickname: String) {
//        self.id = id
//        self.nickname = nickname
//    }
//
//    func update(_ videoTitle: String) {
//        print("\(self.nickname)이 \(videoTitle) 시청")
//        thumbsUp(for: videoTitle)
//    }
//
//    func thumbsUp(for videoTitle: String) {
//        print("\(self.nickname)이 좋아요를 눌렀습니다.")
//    }
//}
//
//let BBoni = Youtuber(name: "빵튜버 뽀니")
//
//let Dana = Subscriber(id: "dana123", nickname: "dana")
//let Kate = Subscriber(id: "kate111", nickname: "kate")
//
//// 구독자
//BBoni.register(observer: Dana)
//BBoni.register(observer: Kate)
//
//// 새로운 영상 올림
//BBoni.uploadVideo(title: "북촌 디저트 카페")



protocol Subject {
    var notificationCenter: NotificationCenter { get set }
}

protocol Observer {
    var id: String { get }
    func update(with data: String)
}

protocol NotificationCenter {
    func post(with data: String)
    func add(observer: Observer)
    func remove(observer: Observer)
    func broadCast(with data: String)
}

class YoutubeNotificationCenter: NotificationCenter {
    var subscribers = [Observer]()
    
    init() {
        
    }
    
    func post(with title: String) {
        broadCast(with: title)
    }
    func add(observer: Observer) {
        subscribers.append(observer)
    }
    
    func remove(observer: Observer) {
        subscribers.removeAll {
            $0.id == observer.id
        }
    }
    
    func broadCast(with title: String) {
        for subscriber in subscribers {
            subscriber.update(with: title)
        }
    }
}

class Youtuber: Subject {
    let name: String
    var subscribers = [Observer]()
    var notificationCenter: NotificationCenter
    
    init(name: String, notificationCenter: NotificationCenter) {
        self.name = name
        self.notificationCenter = notificationCenter
    }

    func uploadVideo(title: String) {
        print("\(self.name)이 새로운 영상 \(title)을 업로드 했습니다.")
        notificationCenter.post(with: title)
    }
}

class Subscriber: Observer {
    var id: String
    var nickname: String
    init(id: String, nickname: String) {
        self.id = id
        self.nickname = nickname
    }

    func update(with videoTitle: String) {
        print("\(self.nickname)이 \(videoTitle) 시청")
        thumbsUp(for: videoTitle)
    }

    func thumbsUp(for videoTitle: String) {
        print("\(self.nickname)이 좋아요를 눌렀습니다.")
    }
    
    
}

let youtubeNotificationCenter = YoutubeNotificationCenter()
let Bboni = Youtuber(name: "빵튜버 뽀니", notificationCenter: youtubeNotificationCenter)

let Dana = Subscriber(id: "dana123", nickname: "dana")
let Kate = Subscriber(id: "kate111", nickname: "kate")

youtubeNotificationCenter.add(observer: Dana)
youtubeNotificationCenter.add(observer: Kate)

Bboni.uploadVideo(title: "빵 뷔페")



