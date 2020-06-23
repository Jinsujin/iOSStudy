//
//  Frame.swift
//  DemoProject
//
//  Created by jsj on 2020/06/23.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

/**
    유연한 프레임 만들기
 **/

struct Frame: View {
    var body: some View {
        Text("Hello fantastic World!!!")
            .font(.largeTitle)
            .border(Color.red)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .border(Color.black, width:5 )
            .edgesIgnoringSafeArea(.all) // 안전영역 밖까지 프레임영역을 확장
//            .frame(minWidth: 100, maxWidth: 300, minHeight: 100, maxHeight: 100, alignment: .center)
//            .frame(width: 100, height: 100, alignment: .center)
    }
}

struct Frame_Previews: PreviewProvider {
    static var previews: some View {
        Frame()
    }
}
