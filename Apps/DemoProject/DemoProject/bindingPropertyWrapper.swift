//
//  bindingPropertyWrapper.swift
//  DemoProject
//
//  Created by jsj on 2020/06/24.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct bindingPropertyWrapper: View {
    
    @State private var wifiEnabled = true
    
    
    var body: some View {
        VStack {
            Toggle(isOn: $wifiEnabled){
                Text("Enable WiFi")
            }
            WifiImageView(wifiEnabled: $wifiEnabled)
        }
    }
}

/**
    하위뷰 정의
 **/
struct WifiImageView: View {
    // 바인딩 래퍼를 이용해 프로퍼티 선언
    @Binding var wifiEnabled: Bool
    
    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
    }
}

struct bindingPropertyWrapper_Previews: PreviewProvider {
    static var previews: some View {
        bindingPropertyWrapper()
    }
}
