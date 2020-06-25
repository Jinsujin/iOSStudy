//
//  SecondView.swift
//  ObservableDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    // STEP01
    //@ObservedObject var timerData: TimerData
    
    // STEP02
    @EnvironmentObject var timerData: TimerData
    
    var body: some View {
        VStack {
            Text("Second view")
                .font(.largeTitle)
            Text("Timer count = \(timerData.timeCount)")
                .font(.headline)
        }.padding()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        
        // STEP01.
        // 여기서 정의된 TimerData 인스턴스는 ContentView 와 다른 인스턴스.
//        SecondView(timerData: TimerData())
        
        // STEP02
        SecondView().environmentObject(TimerData())
    }
}
