//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by jsj on 2020/06/24.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI


/**
 Spacer()
 뷰들 사이에 가변적인 공간을 제공.레이아웃에 따라 뷰가 확장되기도, 줄어들기도 함.
 스택에 포함된 경우, 스택축의 방향으로 크기가 조절됨.
 스택 밖에 포함된 경우, 수직, 수평 모두 크기가 조절될 수 있다.
 
 Divider()
 뷰를 분리하는 라인을 그림
 **/

struct ContentView: View {


    var colors: [Color] = [.black, .red, .green, .blue]
    var colornames = ["Black", "Red", "Green", "Blue"]
    
    @State private var colorIndex = 0
    @State private var rotation: Double = 0
    @State private var text: String = "Hello SwiftUI!"
    
    var body: some View {
            VStack {
                Spacer()
                Text("Hello, World!")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .rotationEffect(.degrees(self.rotation))
                    .animation(.easeOut(duration: 5))
                    .foregroundColor(self.colors[self.colorIndex])
                Spacer()
                Divider()
                // $으로 상태 프로퍼티와 바인딩
                Slider(value: $rotation, in:0 ... 360, step: 0.1)
                    .padding()
                
                TextField("Enter text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                
                Picker(selection: $colorIndex, label: Text("Color")) {
                    ForEach (0 ..< colornames.count) {
                        Text(self.colornames[$0])
                            .foregroundColor(self.colors[$0])
                    }
                }
                .padding()

            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
