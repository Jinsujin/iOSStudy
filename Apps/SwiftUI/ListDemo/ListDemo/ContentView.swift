//
//  ContentView.swift
//  ListDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

/**
 SwiftUI 에서 항목을 추가, 삭제, 편집할 수 있는 동적 리스트 만들기
 Idenfifiable 프로토콜을 따르는 클래스 또는 구조체 내에 포함되어야 함
 Identifiable 프로토콜을 사용하려면, 리스트에서 각 항목을 식별하는데 사용할 id 이름의 프로퍼티가 객체에 있어야 한다
 
 
 STEP04. 리스트 항목을 터치하여 이동하기 - NavigationView, NavigationLink
 
 */
struct ToDoItem: Identifiable {
    var id = UUID()
    var task: String
    var imageName: String
}

var listData: [ToDoItem] = [
    ToDoItem(task: "방청소", imageName: "trash.circle.fill"),
    ToDoItem(task: "장보기", imageName: "cart"),
    ToDoItem(task: "공부", imageName: "studentdesk")
]

struct ContentView: View {
    
    @State var toggleStatus = true
    
    
    var body: some View {
        
        /************* STEP01. 정적 리스트 데이터 표시하기 *************/
//        List {
//            HStack {
//                Image(systemName: "trash.circle.fill")
//                Text("Take out the trash")
//            }
//            HStack {
//                Image(systemName: "person.2.fill")
//                Text("Pick up the kids")
//            }
//        }
        
        
        /************ STEP02. 동적 리스트 데이터 나타내기 ******************/
//        List(listData) { item in
//            HStack {
//                Image(systemName: item.imageName)
//                Text(item.task)
//            }
//        }
//
        
        /************* STEP03. 동적 리스트 데이터 + 정적 데이터 ***********/
//        List {
//            Toggle(isOn: $toggleStatus) {
//                Text("Allow Notifications")
//            }
//
//            ForEach (listData) { item in
//                HStack {
//                    Image(systemName: item.imageName)
//                    Text(item.task)
//                }
//            }
//        }
        
        /************* STEP04. Header + Footer Section ***************/
//        List {
//            Section(header: Text("Settings")) {
//                Toggle(isOn: $toggleStatus) {
//                    Text("Allow Notification")
//                }
//            }
//            Section(header: Text("To Do Tasks")) {
//                ForEach(listData) { item in
//                    HStack {
//                        Image(systemName: item.imageName)
//                        Text(item.task)
//                    }
//                }
//            }
//        }
        
        
        /**************** STEP05. navigation *******************/
        NavigationView {
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleStatus) {
                        Text("Allow Notification")
                    }
                }
                
                Section(header: Text("To Do Tasks")) {
                    ForEach(listData) { item in
                        HStack {
                            NavigationLink(destination: Text(item.task)) {
                                Image(systemName: item.imageName)
                                Text(item.task)
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }
            }
            .navigationBarTitle(Text("To Do List"))
            .navigationBarItems(trailing: EditButton())
        }
        
    }
    
    func deleteItem(at offsets: IndexSet) {
        // 뷰데이터에서 해당 항목 삭제
        print("delete item \(offsets)")
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        // 항목을 재배열하는 작업
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
