//
//  StackContentView.swift
//  DemoProject
//
//  Created by jsj on 2020/06/23.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI


/**
 스택뷰: VStack, HStack, ZStack
 **/
struct StackContentView: View {
    var body: some View {
//        HStack {
//            Image(systemName: "goforward.10")
//            Image(systemName: "goforward.15")
//            Image(systemName: "goforward.30")
//        }
        
        VStack {
            Text("Travel Bill")
                .font(.title)
                .padding(20)
            
            HStack(alignment: .top) {
                Text("food")
                    .font(.headline)
                    .padding(.top, 40)
                VStack(alignment: .center, spacing: 20) {
                    Text("Meat")
                    Text("fruit")
                    Text("drink")
                }
                Spacer()
                VStack(alignment: .leading) {
                    // 컨테이너뷰는 하위뷰를 10개로 제한하므로, 그룹으로 나눠담음
                    Group {
                    Text("190000WON")
                    Text("340000WON")
                    Text("8200WON")
                    Text("190000WON")
                    Text("340000WON")
                    Text("8200WON")
                    Text("190000WON")
                    Text("340000WON")
                    Text("8200WON")
                    Text("190000WON")
                    }
                    
                    Group {
                        Text("340000WON")
                        Text("8200WON")
                        Text("190000WON")
                    }
                }
            }.padding(10)
        }
    }
}

struct StackContentView_Previews: PreviewProvider {
    static var previews: some View {
        StackContentView()
    }
}
