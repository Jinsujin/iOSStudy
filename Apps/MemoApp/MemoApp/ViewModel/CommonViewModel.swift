//
//  CommonViewModel.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/**
    의존성을 주입하는 생성자/ 바인딩에 사용되는 속성, 메서드가 추가됨
 
 뷰모델 - 화면전환, 메모저장 처리
 뷰모델 생성하는 시점에, 생성자를 통해 의존성을 주입해야 함
 
 
 - 앱을 구성하는 모든씬은 navigation에 embed 됨 -> 네비게이션 타이틀 필요
 */

class CommonViewModel: NSObject {
    
    // 네비게이션 타이틀. 바인딩을 쉽게 하기위해 Driver로 선언
    let title: Driver<String>
    
    // 프로토콜로 선언 - 의존성을 쉽게 수정 가능
    let sceneCoordinator: SceneCoordinatorType
    
    let storage: MemoStorageType
    

    // 속성을 초기화 하는 생성자
    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType){
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}

