//
//  CustomModifier.swift
//  DemoProject
//
//  Created by jsj on 2020/06/23.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct CustomModifier: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        .modifier(StandardTitle())
    }
}

/***
 뷰에 자주적용되는 수정자들의 묶음을 구조체로 만들어 재사용 가능하다
 */
struct StandardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .background(Color.white)
            .border(Color.gray, width: 0.2)
            .shadow(color: Color.black, radius: 5, x:0, y:0)
    }
}

struct CustomModifier_Previews: PreviewProvider {
    static var previews: some View {
        CustomModifier()
    }
}
