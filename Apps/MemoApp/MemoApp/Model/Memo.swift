//
//  Memo.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxDataSources

/**
 RxDataSources : tableview, collectionview 에 바인딩 할 수 있는 datasource 제공.
 datasource 에 저장되는 모든데이터는 IdentifiableType 을 채용해야 함
 
 */

struct Memo: Equatable,IdentifiableType {
    var identity: String
    var content: String
    var insertDate: Date
    
    init(content: String, insertDate: Date = Date()){
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: Memo, uptatedContent: String){
       self = original
       self.content = uptatedContent
   }
}


