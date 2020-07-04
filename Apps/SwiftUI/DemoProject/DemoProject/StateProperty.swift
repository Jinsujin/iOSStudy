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
 
 해당 뷰에서만 사용할 수 있다.
 하위뷰가 아니거나 상태 바인딩이 구현되어 있지 않은 다른뷰는 접근할 수 없다.
 상태 프로퍼티는 일시적인 것. 부모뷰가 사라지면, 그 상태도 사라진다.
 (다른뷰들이 외부에서 접근할 수 있는 영구적인 데이터를 표현하려면, Observable 객체를 사용)
 
 
 String, Int 처럼 간단한 데이터값을 저장하기 위해서 사용
 @State 프로퍼티 래퍼를 사용하여 선언됨
 해당뷰에 속한것이기 때문에 private 로 선언되어야만 함
 
 상태값변경 ===> 해당 프로퍼티가 선언된 뷰 계층구조를 다시 렌더링.
 프로퍼티값에 의존하는 뷰는, 최신값이 반영되도록 업데이트해야 함
 상태프로퍼티 - 뷰를 바인딩하여, 뷰에서 변경이 일어나면 상태 프로퍼티에 자동으로 값이 반영 됨
 
 
 **/

struct StateProperty: View {
    
    
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
