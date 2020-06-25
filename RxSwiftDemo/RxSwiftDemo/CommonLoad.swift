//
//  CommonLoad.swift
//  RxSwiftDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit

let largeImageUrl = "https://picsum.photos/1024/768/?random"

let loadingImageUrl = largeImageUrl


func asyncLoadImage(from imageUrl: String, completed: @escaping (UIImage?) -> Void) {
    // 백그라운드 쓰레드로 로직 돌리기 :
    // 네트워크 통신같은 작업은 자원을 많이 잡아먹기 때문에, UI에 락을 걸어서 화면에 렉이 걸리는 것처럼 보일 수 있기때문
    DispatchQueue.global().async {
        guard let url = URL(string: imageUrl) else {
            completed(nil)
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            completed(nil)
            return
        }
        
        let image = UIImage(data: data)
        completed(image)
    }
}
