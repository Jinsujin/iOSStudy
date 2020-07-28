//
//  MemoDetailViewModel.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: CommonViewModel {
    
    // 이전씬에서 전달된 메모
    let memo: Memo
    
    private var formatter: DateFormatter = {
        let format = DateFormatter()
        format.locale = Locale(identifier: "Ko_kr")
        format.dateStyle = .medium
        format.timeStyle = .medium
        return format
    }()
    
    // 메모내용 - 테이블뷰에 데이터 표시
    var contents: BehaviorSubject<[String]>
    
    init(memo: Memo, title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType){
        self.memo = memo
        
        contents = BehaviorSubject<[String]>(value: [
            memo.content,
            formatter.string(from: memo.insertDate)
        ])
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
        
    }
    
    
    /**
     navigation controller 의 뒤로가기버튼 과 바인딩할 액션
     
     */
    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true).asObservable().map { _ in}
    }
    
    /**
     ComposeViewModel로 Action 전달
     
     */
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            self.storage.update(memo: memo, content: input)
                .subscribe(onNext: { updated in
                    // update된 내용을 subject에 전달
                    // -> subject에 바인딩된 뷰가 새로운 내용으로 업데이트 됨
                    self.contents.onNext([
                        updated.content,
                        self.formatter.string(from: updated.insertDate)
                    ])
                })
                .disposed(by: self.rx.disposeBag)
            
            return Observable.empty()
        }
    }
    
    /**
    보기화면에 편집버튼과 바인딩 할 Action
     
     cancel Action 은 전달할 필요 없음
     */
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(title: "메모 편집", content: self.memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            let composeScene = Scene.compose(composeViewModel)
            
            return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in}
        }
    }
    
    /**
     삭제버튼과 바인딩할 Action
     
     메모 삭제후, 이전화면으로 되돌아감
     */
    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            self.storage.delete(memo: self.memo)
            return self.sceneCoordinator.close(animated: true).asObservable().map { _ in}
        }
    }
}
