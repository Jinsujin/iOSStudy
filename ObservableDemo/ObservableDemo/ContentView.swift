//
//  ContentView.swift
//  ObservableDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

/**
 
 여러 뷰에서 동일한 데이터를 참조하기
 
 STEP01. Observable 객체를 만들어 뷰에서 구독한다.
 네비게이션으로 뷰를 넘길때, 인스턴스 참조도 같이 넘겨서 같은 데이터를 바라보게끔 한다.
 
 STEP02. Environment 객체 사용
 Observable 객체를 Environment 객체로 변환.
 두개의 뷰 모두가 동일한 TimerData 객체에 대한 참조체를 전달하지 않아도 접근할 수 있게 된다
 
 */


struct ContentView: View {

    // STEP01
//    @ObservedObject var timerData: TimerData = TimerData()
   
    // STEP02.
    @EnvironmentObject var timerData: TimerData
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Timer count = \(timerData.timeCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Button(action: resetCount) {
                    Text("Reset Counter")
                }
                
                // STEP01. 두번째뷰에 동일한 인스턴스를 참조하도록 넘겨준다
//                NavigationLink(destination: SecondView(timerData: timerData)) {
//                    Text("Next Screen")
//                }.padding()
                
                // STEP02.
                NavigationLink(destination: SecondView()) {
                    Text("Next Screen")
                }.padding()
            }
        }
        
    }
    
    func resetCount(){
        timerData.resetCount()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // STEP02. 레이아웃의 프리뷰가 나타날때, 타이머의 인스턴스를 추가
        ContentView().environmentObject(TimerData())
    }
}
