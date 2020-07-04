//
//  TextLineLimit.swift
//  DemoProject
//
//  Created by jsj on 2020/06/23.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct TextLineLimit: View {
    var body: some View {
        HStack {
            Image(systemName: "airplane")
            Text("Flight Times: ")
            Text("Christmas Island").layoutPriority(1) // 우선순위값을 1로 높여주면, 글자가 생갹되지 않고 다 보이게 된다. (default:0)
        }
        .font(.largeTitle)
        .lineLimit(1)
    }
}

struct TextLineLimit_Previews: PreviewProvider {
    static var previews: some View {
        TextLineLimit()
    }
}
