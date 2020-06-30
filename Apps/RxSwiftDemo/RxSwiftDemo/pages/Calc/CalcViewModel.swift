//
//  File.swift
//  RxSwiftDemo
//
//  Created by jsj on 2020/06/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay


class CalcViewModel {
    
    // 입력한 숫자값
    var prevSavedNumber$ = BehaviorRelay<Int>(value: 0)
    
    // result num
    var currentInputNumber$ = BehaviorRelay<Int>(value: 0)
    
    // +, -
    var calcType$ = BehaviorRelay<String>(value: "")
    
    
    func inputNumber(_ number: Int) {
        guard let r = Int("\(currentInputNumber$.value)\(number)") else {
            return
        }
        
        currentInputNumber$.accept(r)
    }
    
    func resetCalc(){
        self.currentInputNumber$.accept(0)
        self.prevSavedNumber$.accept(0)
        self.calcType$.accept("")
    }
    
    func add(){
        prevSavedNumber$.accept(currentInputNumber$.value)
        currentInputNumber$.accept(0)
    }
    
    func result(){ // = 버튼 눌렀을때
        if calcType$.value == "+" {
            let result = prevSavedNumber$.value + currentInputNumber$.value
            currentInputNumber$.accept(result)
            prevSavedNumber$.accept(0)
        }
        
        if calcType$.value == "-" {
            let result = prevSavedNumber$.value - currentInputNumber$.value
            currentInputNumber$.accept(result)
            prevSavedNumber$.accept(0)
        }
    }
    
    
}
