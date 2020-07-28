//
//  ViewModelBindableType.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit


/**
 뷰 모델과 뷰를 바인딩하는 역할을 하는 프로토콜
 
    - MVVM 패턴 구현시, 뷰 모델을 뷰 컨트롤러에 속성으로 추가하게 됨
 
    - 뷰 모델의 타입은, 뷰 컨트롤러 마다 달라짐 -> 제네릭 프로토콜로 선언
 */
protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}



// MARK:- protocol extension
extension ViewModelBindableType where Self: UIViewController {
    
    /**
     - 뷰컨트롤러에 추가된 뷰 모델 속성의 실제 뷰모델 저장,
     - 바인드 뷰모델 메서드를 자동으로 호출하는 메서드 구현
     
     개별 뷰 컨트롤러에서 바인드 뷰 메서드를 직접 호출할 필요가 없어짐 -> 코드 간략화
     */
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        
        loadViewIfNeeded()
        
        bindViewModel()
    }
    
}


