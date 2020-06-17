//
//  ContentView.swift
//  DemoProject
//
//  Created by jsj on 2020/06/17.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct MainScene: View {

    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.red)
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
            }
        }
        

    }
}


/**
 PreviewProvider: 파일에서 기본이 되는 뷰의 인스턴스를 반환.
 -> 프리뷰 캔버스에 해당뷰의 미리보기를 표시
 
 */
struct MainScene_Previews: PreviewProvider {
    static var previews: some View {
        
        // Group으로 그룹핑하여, 여러 디바이스에서 동시에 미리보기 가능
        Group {
            MainScene()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")
                .environment(\.colorScheme, .dark) // dark모드에서 미리보기 
            
            MainScene()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .previewDisplayName("iPhone 11")
            
            
        }
        
    }
}
