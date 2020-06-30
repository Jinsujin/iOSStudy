//
//  CalcViewController.swift
//  RxSwiftDemo
//
//  Created by jsj on 2020/06/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class CalcViewController: UIViewController {

    private var disposeBag = DisposeBag()
    
    private let viewModel = CalcViewModel()
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    // MARK:- view did load -- 화면이 그려지기 전
    override func viewDidLoad() {
        super.viewDidLoad()

        // 뷰모델값과 결과를 보여줄 Label 바인딩 => 뷰모델 값이 바뀌면, Label도 자동으로 바뀐다
        viewModel.currentInputNumber$
//            .scan(0, accumulator: +) // 0부터 값을 시작해서, 기존의 값과 + 한다
//            .map { $0.currencyKR() }
            .map{ "\($0)" }
            .observeOn(MainScheduler.instance)
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    

    @IBAction func touchedNumButton(_ sender: UIButton) {
        print(sender.titleLabel?.text)

        // 숫자버튼을 누를때마다, 숫자 하나하나를 쌓아야 함
        // -> = 버튼 누르면 전체 숫자가 나와야 함(결과반영)
        guard let num = Int(sender.titleLabel?.text ?? "") else {
            return
        }
        viewModel.inputNumber(num)
    }
    
    
    
    @IBAction func touchedCalcButton(_ sender: UIButton) {
        guard let calc_text = sender.titleLabel?.text else {
            return
        }
        
        if calc_text == "=" { // = 눌렀을때
//            viewModel.currentInputNumber$.subscribe(onNext: { val in
//                print(val)
//            })
            viewModel.result()
        } else if calc_text == "+" {
            viewModel.add()
            viewModel.calcType$.accept("+")
        } else if calc_text == "-" {
            viewModel.add()
            viewModel.calcType$.accept("-")
        }
    }
    
    @IBAction func touchedResetButton(_ sender: Any) {
        viewModel.resetCalc()
    }
}
