//
//  MemoListViewController.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {
    
    // 필수멤버 추가
    var viewModel: MemoListViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    // viewmodel - view 바인딩
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)

        // rxDatasource 로 바인딩
        viewModel.memoList
            .bind(to: listTableView.rx.items(dataSource: viewModel.dataSource))
        .disposed(by: rx.disposeBag)
        
//        viewModel.memoList
//            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { row, memo, cell in
//                cell.textLabel?.text = memo.content
//        }
//        .disposed(by: rx.disposeBag)
        
        addButton.rx.action = viewModel.makeCreateAction()
        
        // tableView에서 메모 선택 -> 뷰모델을 통해 detailAction전달 -> 선택된 셀 선택해제
        // 1. 선택한 메모 listTableView.rx.modelSelected(Memo.self)
        // 2. 인덱스 패스 listTableView.rx.itemSelected
        
        // zip으로 옵저버블 병합
        Observable.zip(listTableView.rx.modelSelected(Memo.self), listTableView.rx.itemSelected)
            .do(onNext: { [unowned self] (_, indexPath) in
                // 선택해제
                self.listTableView.deselectRow(at: indexPath, animated: true)
            }).map { $0.0 } // indexPath 제외하고, 데이터만 방출
            .bind(to: viewModel.detailAction.inputs) // 선택한 메모를 Action으로 전달. -> Action에 구현되어있는 코드 실행
            .disposed(by: rx.disposeBag)
        
        // tableView 에서 memo 삭제
        // modelDeleted: ControllEvent 리턴. 메모를 삭제할때마다 next 이벤트 방출
        // swift delete 이벤트가 자동으로 활성화됨
        listTableView.rx.modelDeleted(Memo.self)
            .bind(to: viewModel.deleteAction.inputs)
            .disposed(by: rx.disposeBag)
    }

}
