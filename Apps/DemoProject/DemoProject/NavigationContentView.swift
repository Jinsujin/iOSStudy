//
//  Navigation.swift
//  DemoProject
//
//  Created by jsj on 2020/06/23.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NavigationContentView : View {
    var body: some View {
        NavigationView {
            Text("Hi")
            .navigationBarTitle(Text("Intro"))
            .navigationBarItems(trailing:
                NavigationLink(destination: DetailView()) { // 네비게이션뷰를 링크를 통해 푸쉬가능
                    Image("apple_rainbow").resizable()
                    .frame(width: 25, height: 25, alignment: .trailing)
                }
            )
        }
    }
}

struct NavigationContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationContentView()
    }
}
