//
//  MemoryStorage.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift

/**
     메모리에 메모를 저장
 
 */
class MemoryStorage: MemoStorageType {
    // 메모를 저장할 배열
    private var list = [
        Memo(content: "Homework", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Shopping", insertDate: Date().addingTimeInterval(-20))
    ]
    
    private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
    
    private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])
//    private lazy var store = BehaviorSubject<[Memo]>(value: list)
    
    
    /**
        새로운 메모를 생성하고 배열에 추가
     
        새로운 상태를 방출
     */
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        
        sectionModel.items.insert(memo, at: 0)
        store.onNext([sectionModel])
        
//        list.insert(memo, at: 0)
//        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
//    func memoList() -> Observable<[Memo]> {
//        return store
    }
    
    /**
        업데이트된 메모 인스턴스 생성
     
     배열에 저장된 인스턴스를, 수정된 인스턴스로 바꿈
     */
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, uptatedContent: content)
        
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
            sectionModel.items.insert(updated, at: index)
        }
        
        store.onNext([sectionModel])
        
        
//        if let index = list.firstIndex(where: { $0 == memo}) {
//            list.remove(at: index)
//            list.insert(updated, at: index)
//        }
//
//        store.onNext(list)
//
        return Observable.just(updated)
    }
    
    
    /**
     삭제하고, 삭제된 메모를 옵저버블로 방출
     
     배열 변경 ->  새로운 next 이벤트 방출
     subject 를 tableview 와 바인딩 하는데, 새로운 배열을 계속 방출해야 테이블 뷰가 정상적으로 업데이트 됨
     (tableview.reloadData() 로는 테이블뷰가 업데이트 되지 않음)
     */
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
        }
        
        store.onNext([sectionModel])
        
//        if let index = list.firstIndex(where: { $0 == memo }) {
//            list.remove(at: index)
//        }
//
//        store.onNext(list)
        
        return Observable.just(memo)
    }
    
}
