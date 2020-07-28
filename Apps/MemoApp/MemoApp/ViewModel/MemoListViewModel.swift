//
//  MemoListViewModel.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import RxDataSources

/**
  테이블뷰에서 header, footer 를 사용하지 않으므로,  SectionData 는 신경쓰지 않아도 됨
 
 - Int : sectionData 형식
 - Memo : rowData 형식
 */
typealias MemoSectionModel = AnimatableSectionModel<Int, Memo>

/**
 MemoListViewController 에서 사용하는 뷰모델
 
 */
class MemoListViewModel: CommonViewModel {
    
    // tableView 바인딩에 사용하는 datasource
    let dataSource: RxTableViewSectionedAnimatedDataSource<MemoSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<MemoSectionModel>(configureCell: { (dataSource, tableView, indexPath, memo) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = memo.content
            return cell
        })
        ds.canEditRowAtIndexPath = { _, _ in return true }
        return ds
    }()
    
    // 테이블뷰와 바인딩하는 속성
    var memoList: Observable<[MemoSectionModel]> {
        return storage.memoList()
    }

    //    var memoList: Observable<[Memo]> {
    //        return storage.memoList()
    //    }
    
    
    // Action - 입력값으로 메모 업데이트
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map { _ in }
        }
    }
    
    // Action - 취소버튼 눌렀을때, 임시메모 삭제
    func performCalcel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in}
        }
    }
    
    /**
     새 메모 생성
     */
    func makeCreateAction () -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    // 뷰모델을 생성하여 파라미터로 전달
                    let composeViewModel = MemoComposeViewModel(title: "새 메모", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCalcel(memo: memo))
                    
                    let composeScene = Scene.compose(composeViewModel)
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map {_ in }
            }
        }
    }
    
    
    /**
     목록화면 -> 보기화면 이동
     
     - Memo: Action 의 입력 형식
     - Void: Action 의 출력형식
     
     lazy : 클로저 내부에서 self 로 접근하기 위함
     */
    lazy var detailAction: Action<Memo, Void> = {
        return Action { memo in
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            
            // 씬 생성
            let detailScene = Scene.detail(detailViewModel)
            
            // push 방식으로 화면 전환
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }()
    
    
    /**
     삭제 Action
     
     메모만 삭제. 이전으로 되돌아가지 않아도 됨
     */
    lazy var deleteAction: Action<Memo, Swift.Never> = {
        return Action { memo in
            return self.storage.delete(memo: memo).ignoreElements()
        }
    }()
}
