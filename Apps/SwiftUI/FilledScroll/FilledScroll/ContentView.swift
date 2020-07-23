//
//  ContentView.swift
//  FilledScroll
//
//  Created by jsj on 2020/07/24.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

/**
 
 1. ScrollView 를 GeometryReader 로 감싸기
 2. 각 항목에 대한 뷰를 GeometryReader 로 감싸기
 3. sacleEffect 주기
 
 */


struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    var body: some View {
        VStack(spacing: 0){
            HStack {
                Text("Album Songs")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color.white.shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5))
            .zIndex(0)
//            Spacer()
            
            GeometryReader{ mainView in
                ScrollView{
                        VStack(spacing: 15){
                            
                            ForEach(albums, id: \.title) { album in
                                GeometryReader{ item in
                                    AlbumView(album: album)
                                        .scaleEffect(self.scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY), anchor: .topTrailing)
                                        .opacity(Double(self.scaleValue(mainFrame: mainView.frame(in: .global).minY, minY: item.frame(in: .global).minY)))
                                }
                            .frame(height: 100)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 25)
                        
                    }
                .zIndex(1)
                
            }
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.top)
    }
    
    
    func scaleValue(mainFrame: CGFloat, minY: CGFloat) -> CGFloat {
        
        withAnimation(.easeOut) {
            // top padding 값 빼주기
            let scale = (minY - 25) / mainFrame
            
            print(scale)
            
            if scale > 1 {
                return 1
            } else {
                return scale
            }
        }
    }
}


struct AlbumView: View {
    var album: Album
    
    var body: some View {
        HStack {
            Image(album.cover)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(album.title)
                    .fontWeight(.bold)
                
                Text(album.author)
            }
            .padding(.leading, 10)
            
            Spacer(minLength: 0)
            
        }
        .background(Color.white.shadow(color: Color.black.opacity(0.12), radius: 5, x: 0, y: 4))
    .cornerRadius(15)
    }
}

// MARK:- Datas
struct Album {
    var title: String
    var author: String
    var cover: String
}


var albums = [
    Album(title: "gondola", author: "1", cover: "gondola"),
    Album(title: "murano", author: "2", cover: "murano"),
    Album(title: "newdelhi", author: "2", cover: "newdelhi"),
    Album(title: "newyork", author: "2", cover: "newyork"),
    Album(title: "paris", author: "2", cover: "paris"),
    Album(title: "santorini", author: "2", cover: "santorini"),
    Album(title: "saopaulo", author: "2", cover: "saopaulo"),
    Album(title: "stmarksbasilica", author: "2", cover: "stmarksbasilica"),
    Album(title: "venice", author: "2", cover: "venice")
]


