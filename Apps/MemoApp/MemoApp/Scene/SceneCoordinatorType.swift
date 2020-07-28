//
//  SceneCoordinatorType.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift


/**
 
 */
protocol SceneCoordinatorType {
    
    /**
     
     새로운 씬을 표시
     
     - scene : 대상 씬
     - using: 애니메이션 스타일
     -
     */
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    /**
        현재씬을 닫고, 이전씬으로 돌아감
     
     - Completable: 구독자를 추가하고, 화면전환이 완료된 이후에 원하는 작업 구현 가능
     - discardableResult: 후 작업이 필요없다면 사용하지 않아도 됨. 리턴형을 사용안해도 에러 안뜸
     */
    @discardableResult
    func close(animated: Bool) -> Completable
}
