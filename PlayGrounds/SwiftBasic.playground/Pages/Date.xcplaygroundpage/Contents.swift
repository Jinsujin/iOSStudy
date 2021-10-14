//: [Previous](@previous)

import Foundation

/** ======================================================================
 Date() : 초 기준
 현재 시점을 기준으로 인스턴스가 생성된다.
 기준 시간(2001.1.1 00:00:00 UTC) 을 기준으로 현재시간까지 몇초가 흘렀는지 계산.
 => TimeInterval 타입(초단위)
Date() 자체적으로는 사용할 수 없고, 변환해서 써야 한다.
 
 
 - 유닉스 기준시간
 1970.1.1 00:00:00
 .timeIntervalSince1970
 
 
 - 1시간 = 3600
 - 하루 = (60초 * 60분 * 24시간)
 ====================================================================== */


// 영국시간 UTC 기준으로 현재시간이 출력된다.
// 2021-10-06 14:26:33 +0000
let now = Date()
print(now)



// 2001.1.1 00:00:00 UTC 기준으로 얼마나 시간(초)가 흘렀는지 반환
now.timeIntervalSinceReferenceDate

// 1970.1.1 00:00:00 UTC 시간을 기준으로.
now.timeIntervalSince1970

// 1초간격
let oneSecond = TimeInterval(1.0)
let oneDay: TimeInterval = (60 * 60 * 24)

// Date() - 86400 : 어제 날짜
let yesterday = now - 86400



// 현재 - 과거 시간의 차이를 초로
now.timeIntervalSince(yesterday) //86400

//
now.distance(to: yesterday) //-86400

// 내일
now.advanced(by: 86400)
let tomarrow = Date(timeIntervalSinceNow: oneDay)



// 스위프트 내부에 정의된 타임존 확인
//for localeName in TimeZone.knownTimeZoneIdentifiers {
//    print(localeName)
//}

// Asia/Seoul (current)
TimeZone.current



/** ======================================================================
 Calendar 구조체
 
 Date 를 달력을 이루는 요소로 변환.
 "년,월,일 + 시,분,초 + 요일" 로 변환
 예) 두 날짜 사이의 일수, 양력 음력
 ====================================================================== */

// 캘린더는 기본값이 그레고리력 (Gregorian calendar) - 양력
var calendar = Calendar.current
//Calendar(identifier: .gregorian)


// 지역설정.
// 나라(지역)마다 날짜와 시간을 표시하는 형식과 언어가 다르떄문에 필요.
calendar.locale // 달력의 지역 en_US
//calendar.locale = Locale(identifier: "ko_KR")
calendar.timeZone // Asia/Seoul



// 날짜 - 년/월/일
let year: Int = calendar.component(.year, from: now) // 2021
let month: Int = calendar.component(.month, from: now)
let day: Int = calendar.component(.day, from: now)

// 시간 - 시/분/초
let timeHour: Int = calendar.component(.hour, from: now)
let timeMin: Int = calendar.component(.minute, from: now)
let timeSec: Int = calendar.component(.second, from: now)

// 요일
// 일요일:1, 월:2 ... 토: 7
let weekday: Int = calendar.component(.weekday, from: now)



let dateComs = calendar.dateComponents([.year, .month, .day], from: now)
dateComs.year
dateComs.month
dateComs.day


// 달력을 기준으로 나이 계산하기
struct Person {
    var name: String
    var yearOfBirth: Int
    
    var age: Int {
        get {
            let year = Calendar.current.component(.year, from: Date())
            return year - yearOfBirth
        }
    }
}

let chulsu = Person(name: "철수", yearOfBirth: 2001)
chulsu.age


// 오늘의 요일 계산
enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    static var today: Weekday {
        let weekday = Calendar.current.component(.weekday, from: Date())
        return Weekday(rawValue: weekday) ?? .sunday
    }
}

let weekToday = Weekday.today


// 두 날짜사이의 일수 계산
let startDate = Date()
let endDate = startDate.addingTimeInterval(oneDay)

let someDays = calendar.dateComponents([.day], from: startDate, to: endDate).day!
print(someDays, "일 후")





/** ======================================================================
 DateFormatter
 Date 를 String 으로, String을 Date로 변환가능
RFC 3339를 표준으로 작성.
 
 - Date를 특정 형식의 문자열로 변환하려면,
 1) 지역설정 -> 2) 시간대 설정 -> 3) 날짜형식 -> 4) 시간형식
 ====================================================================== */

let formatter = DateFormatter()

// 1) 지역 설정
formatter.locale = Locale(identifier: "ko_KR")

// 미국 설정
//formatter.locale = Locale(identifier: "en_US")


// 2) 시간대 설정
//formatter.timeZone = TimeZone(identifier: "Asia/Seoul")


// 3) 날짜 형식
formatter.dateStyle = .full // 2021년 10월 7일 목요일
//formatter.dateStyle = .long // 2021년 10월 7일
//formatter.dateStyle = .medium // 2021. 10. 7.
//formatter.dateStyle = .none // 날짜 없어짐. => 시간만 표현하고 싶을때 사용.
//formatter.dateStyle = .short // 2021. 10. 7.



//formatter.timeStyle = .full // 오전 12시 22분 55초 대한민국 표준시
formatter.timeStyle = .long // 오전 12시 22분 29초 GMT+9
//formatter.timeStyle = .medium
//formatter.timeStyle = .none // 오전 12:21:38
//formatter.timeStyle = .short // 오전 12:20

// 원하는 (날짜 + 시간) 형식으로 변환하기
let stringDate = formatter.string(from: Date())
print(stringDate)




// 커스텀 형식으로 만들기
//formatter.dateFormat = "yyyy/MM/dd" // unicode 에서 정의한 방법
formatter.dateFormat = "yyyy년 MMMM d일 (E)" // 2021년 10월 7일 (목)
let stringDate2 = formatter.string(from: Date())
print(stringDate2) //"2021/10/07


// 문자열을 Date로 바꾸기
let newFormatter = DateFormatter()
newFormatter.dateFormat = "yyyy/MM/dd"
let someDate = newFormatter.date(from: "2021/04/12")
print(someDate)




// 두 날짜 범위
let start = Date()
let end = start.addingTimeInterval(oneDay)

let formatter2 = DateFormatter()
formatter2.locale = Locale(identifier: "ko_KR")
formatter2.timeZone = TimeZone.current

formatter2.dateStyle = .long
formatter2.timeStyle = .none

// 기간: 2021년 10월 7일  -  2021년 10월 8일
print("기간:", formatter2.string(from: start), "-", formatter2.string(from: end))




// 프로젝트에서 사용 예
struct InstagramPost {
    let title: String = "title"
    let description: String = "des"
    
    private let date = Date()
    var dateString: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
//            formatter.dateStyle = .medium
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter.string(from: date)
        }
    }
}

let post1 = InstagramPost()
print(post1.dateString) // 오늘날짜출력 - 예) 2021/10/07



// 프로젝트에서 예2
// DateComponents 는 날짜정보의 집합이다.
var compoents = DateComponents()
compoents.year = 2021
compoents.month = 1
compoents.day = 1
compoents.hour = 12
compoents.minute = 30
compoents.second = 0

let 특정날짜 = calendar.date(from: compoents)
print(특정날짜)



extension Date {
    init?(y year: Int, m month: Int, d day: Int) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        guard let date = Calendar.current.date(from: components) else {
            return nil
        }
        
        // 구조체 이기때문에, self에 새로운 인스턴스를 할당하는 방식으로 초기화 가능하다. => 클래스는 안됨!
        self = date
    }
}

// Optional(2020-12-31 15:00:00 +0000)
let 만든날짜 = Date(y: 2021, m: 1, d: 1)
print(만든날짜)


/** ======================================================================
 uid 생성 하기
 
 ====================================================================== */

// 1. UUID - 128 random bits
// String 값으로 얻을 수 있다
let identifier1 = UUID()
let identifier2 = UUID()

let uuid = UUID().uuidString
print(uuid)

// 2. timeIntervalSince1970 을 이용한 Int 값 생성
var uidCount: Double = 0.0
func makeUID() -> Int {
    uidCount += 1
//    return Int((Date().timeIntervalSince1970 + uidCount)) // 1634035358
    return Int((Date().timeIntervalSince1970 + uidCount) * 100000) //163403518543954
}

makeUID()
makeUID()
makeUID()
makeUID()


//9223372036854775807
Int.max


struct Book {
    var uid: String = UUID().uuidString
    var title: String = "book name"
    init(title: String) {
        self.title = title
    }
}

struct Log {
    let uid: String
    let ownerId: String
    let createdAt = Date()
    
    init(ownerId: String) {
        self.uid = UUID().uuidString
        self.ownerId = ownerId
    }
}


let booklist = [
    Book(title: "boo1"),
    Book(title: "boo2"),
    Book(title: "boo3")
]

let logs: [Log] = booklist.map { Log(ownerId: $0.uid) }
print(logs)


let today = Date()
let passedTime = TimeInterval(60 * 3)
today.addingTimeInterval(passedTime)



//: [Next](@next)
