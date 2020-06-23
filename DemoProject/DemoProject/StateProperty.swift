//
//  StateProperty.swift
//  DemoProject
//
//  Created by jsj on 2020/06/23.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

/**
 상태프로퍼티: 뷰 레이아웃의 현재 상태를 저장하기 위해서만 사용됨
 예) 텍스트필드에 입력된 텍스트(String)
 
 String, Int 처럼 간단한 데이터값을 저장하기 위해서 사용
 @State 프로퍼티 래퍼를 사용하여 선언됨
 해당뷰에 속한것이기 때문에 private 로 선언되어야만 함
 
 상태값변경 ===> 해당 프로퍼티가 선언된 뷰 계층구조를 다시 렌더링.
 프로퍼티값에 의존하는 뷰는, 최신값이 반영되도록 업데이트해야 함
 상태프로퍼티 - 뷰를 바인딩하여, 뷰에서 변경이 일어나면 상태 프로퍼티에 자동으로 값이 반영 됨
 
 
 **/

struct StateProperty: View {
    
    @State private var wifiEnabled = true
    @State private var userName = ""
    
    
    var body: some View {
        VStack {
            TextField("Enter name", text: $userName)
        }
    }
}

struct StateProperty_Previews: PreviewProvider {
    static var previews: some View {
        StateProperty()
    }
}
