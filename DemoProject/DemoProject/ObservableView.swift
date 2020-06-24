//
//  ObservableView.swift
//  DemoProject
//
//  Created by jsj on 2020/06/24.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI
import Combine

/**
    Combine 프레임워크 - Observable 객체
 iOS 13에 도입
 특정상태가 앱내의 몇몇 SwiftUI뷰에 의해 사용되어야 할 경우에 적합.
 뷰에서 다른뷰로 이동할때, 구독객체의 참조체를 전달해야 한다면 Environment 객체를 사용하는 것이 더 낫다.

 
    여러 다른뷰들이 외부에서 접근할 수 있는 영구적인 데이터를 표현하기 위해 사용
 Observable 객체는 시간에 따라 변경되는 하나 이상의 데이터값을 모으고 관리하는 역할을 담당.
 타이머나 알림과 같은 이벤트를 처리하기 위해 사용될 수 있다.
 
 값을 게시(publish) 하고, 게시자를 구독(Subscribe) 하여 게시된 프로퍼티가 변경될때 마다 업데이트를 받는다. 그리고 상태프로퍼티처럼, 바인딩을 통해 데이터 변경을 SwiftUI가 자동으로 업데이트 해준다.
 
 
 
 **/



// Observable 객체 선언
class DemoData: ObservableObject {
    // Published 래퍼 : 값이 변경될때마다 모든 구독자에게 업데이트를 알림
    @Published var userCount = 0
    @Published var currentUser = ""
    
    init(){
        // 데이터를 초기화 하는 작업
        updateData()
    }
    
    func updateData() {
        // 데이터를 최신 상태로 유지하기 위한 코드
    }
    
}

struct ObservableView: View {
    
    /**
        DemoData 의 인스턴스를 구독하는 구독자
     Observable 객체를 구독하기 위해, @ObservedObject 프로퍼티 래퍼를 사용.
     게시된 데이터가 변경되면, SwiftUI 는 세로운 상태를 반영하여 뷰를 렌더링.
     
     */
    @ObservedObject var demoData: DemoData
    
    
    var body: some View {
        Text("user: \(demoData.currentUser), count: \(demoData.userCount)")
    }
}

struct ObservableView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableView(demoData: DemoData())
    }
}
