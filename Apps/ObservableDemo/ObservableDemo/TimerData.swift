//
//  TimerData.swift
//  ObservableDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import Combine


/**
    ObservableObject 프로토콜을 구현하는 데이터 클래스를 추가
 
 
    Observable 객체 : 여러 다른뷰들이 외부에서 접근할 수 있는 영구적인 데이터를 표현하기 위해 사용
 예) 타이머, 알림(notification) 이벤트 처리를 위해 사용됨
 */

class TimerData: ObservableObject {
    // published 프로퍼티 래퍼를 사용사여 선언. 프로젝트 내에 있는 뷰에서 관찰될 수 있다
    // 데이터 값을 게시(publish), Observable 객체는 게시자를 구독하여 게시된 프로퍼티가 변경될때마다 업데이트를 받는다
    @Published var timeCount = 0
    var timer : Timer?
    
    init(){
        // 매 초마다 timerDidFire함수를 호출
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(timerDidFire),
                                     userInfo: nil, repeats: true)
        
    }
    
    @objc func timerDidFire(){
        timeCount += 1
    }
    
    func resetCount(){
        timeCount = 0
    }
    
}
