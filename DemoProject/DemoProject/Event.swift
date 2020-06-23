//
//  Event.swift
//  DemoProject
//
//  Created by jsj on 2020/06/23.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct Event: View {
    var body: some View {
        // 버튼 이벤트 연결 1
//        Button(action: buttonPressed) {
//            Text("Click me!")
//        }
        
        VStack {
            Text("Hello world!")
                .onAppear {
                    // 뷰가 나타날때 실행
                }
                .onDisappear {
                    // 뷰가 사라질때 실행
                }
            Button(action: {
                print("🤠")
            }) {
                Image(systemName: "square.and.arrow.down")
            }
        }
        
        
    }
    
    func buttonPressed(){
        print("pressed!")
    }
}

struct Event_Previews: PreviewProvider {
    static var previews: some View {
        Event()
    }
}
