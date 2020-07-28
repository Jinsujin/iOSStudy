//
//  MemoComposeViewModel.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

/**
    새로운 메모 추가, 메모 수정
 
 */
class MemoComposeViewModel: CommonViewModel {
    
    // 새메모 : nil / 메모편집: String
    private let content: String?
    
    // 뷰에 바인딩하기위한 드라이버
    var initalText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    // 저장, 취소버튼을 바인딩할 액션
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil) {
        self.content = content
        
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in}
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map {_ in}
        }
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
