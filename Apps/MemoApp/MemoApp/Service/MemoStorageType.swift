//
//  MemoStorageType.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift



/**
    CRUD 처리 메서드
 
 
 */
protocol MemoStorageType {
    
    /**
    구독자가 작업결과를 원하는 방식으로 처리하도록 Observable 리턴
     작업결과가 필요없는 경우를 위해 discardableResult 선언
     
     */
    @discardableResult
    func createMemo(content: String) -> Observable<Memo>
    
    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]>
    //    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
