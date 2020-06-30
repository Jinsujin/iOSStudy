//
//  ContentView.swift
//  DemoProject
//
//  Created by jsj on 2020/06/17.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct MainScene: View {

    @State var showDetails = false
    
    let appleIconStack = HStack {
        Text("Image")
//            .font(.custom("Copperplate", size: 50))
            .font(.largeTitle)
        Image("apple_rainbow")
        .resizable()
//            .aspectRatio(contentMode: .fit)
    }
    
    var body: some View {
        VStack {
            // 수정자 순서에 따라 뷰에 적용이 된다
            Text("Hello, World!")
                .font(.largeTitle)
                .foregroundColor(.red)
                .padding()
                .border(Color.black)
                
            Button(action: {
                self.showDetails.toggle()
            }) {
                Text("Button")
            }
            if showDetails {
                Text("Show!")
                    .font(.largeTitle)
                    .lineLimit(nil)
                    .foregroundColor(.black)
            }
            MyHStackView()
            appleIconStack
        }
    }
}

/**
  하위뷰로 나누기 - 컴포넌트 생성
 */
struct MyHStackView: View {
    var body: some View {
        HStack {
            Text("Text 3")
                .foregroundColor(.black)
            Text("Text 4")
                .foregroundColor(.orange)
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
