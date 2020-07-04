//
//  LogInValidateViewController.swift
//  RxSwiftDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LogInValidateViewController: UIViewController {

    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
        bindOutput()
    }
    
    // 메모리 누수를 방지하기 위함. 뷰가 사라질때 전부 날려줌-> weak self 안써도 된다!
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag = DisposeBag()
    }
    
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwValidView: UIView!
    @IBOutlet weak var idValidView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButton(_ sender: Any) {
            print("login")
    }

    
    // Subject: 스스로 데이터를 가지고 있는 Observable. 외부에서 데이터를 넣어줄 수도, subscribe 할수도 있다.
    let idValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    let pwValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    let idInputText: BehaviorSubject<String> = BehaviorSubject(value: "")
    let pwInputText: BehaviorSubject<String> = BehaviorSubject(value: "")
    /**
        email, password 체크 해서 둘다 유효성을 만족할때, 로그인을 한다
     */
    private func bindUI(){
        
        // id input ----> check valid  --> bullet
        // pw input ----> check valid  --> bullet
        // id valid && pw valid ==> button enable
        
        
        /******************* STEP01  *********************/
        /*
        // 이벤트를 스트림에 담아서 rx로 처리함
        idField.rx.text
        .orEmpty
//            .filter{ $0 != nil}
//            .map { $0! }
            .map(checkEmailValid)
            .subscribe( onNext: { bool in
            print(bool)
                self.idValidView.isHidden = bool
            
        }).disposed(by: disposeBag)
        
        
        pwField.rx.text.orEmpty
            .map(checkPasswordValid)
            .subscribe( onNext: { bool in
            print(bool)
                self.pwValidView.isHidden = bool
            
        }).disposed(by: disposeBag)
        
        
        //스트림 합치기
        Observable.combineLatest(
            idField.rx.text.orEmpty.map(checkEmailValid),
            pwField.rx.text.orEmpty.map(checkPasswordValid),
            resultSelector: { s1, s2 in s1 && s2 } // 두 스트림을 받아서, 여기서 결정한 스트림을 밑으로 내려보내줌
        ).subscribe(onNext: { b in
            self.loginButton.isEnabled = b
            }).disposed(by: disposeBag)
        */
        
        
        /******************* STEP02  *********************/
        // 필요한 시점에 구독을 하면 된다!
        // 인풋: 아이디 입력, 비번 입력
//        let idInputOb : Observable<String> = idField.rx.text.orEmpty.asObservable()
//
        idField.rx.text.orEmpty
            .bind(to: idInputText)
            .disposed(by: disposeBag)
        
        idInputText
            .map(checkEmailValid)
            .bind(to: idValid)
            .disposed(by: disposeBag)
        
        
        /*
        idValidOb.subscribe(onNext: { b in
            self.idValid.onNext(b) // 값을 외부에서 넣어준다
        })
        idValidOb.bind(to: idValid) // idValidOb 에 값이 발생하면, idValid로 전달
        */
        
        
        pwField.rx.text.orEmpty
            .bind(to: pwInputText)
            .disposed(by: disposeBag)
        
        pwInputText
            .map(checkPasswordValid)
            .bind(to: pwValid)
            .disposed(by: disposeBag)
        
        
        
    }
    
    private func bindOutput(){

                // 아웃풋: 불릿, 로그인 버튼 enable
        //        idValidOb.subscribe(onNext: { b in self.idValidView.isHidden = b }).disposed(by: disposeBag)
        //        pwValidOb.subscribe(onNext: { b in self.pwValidView.isHidden = b }).disposed(by: disposeBag)
        //
        //        Observable.combineLatest(idValidOb, pwValidOb, resultSelector: { $0 && $1 })
        //            .subscribe(onNext: { b in self.loginButton.isEnabled = b })
        //            .disposed(by: disposeBag)
                
                
        idValid.subscribe(onNext: { b in self.idValidView.isHidden = b }).disposed(by: disposeBag)
        pwValid.subscribe(onNext: { b in self.pwValidView.isHidden = b }).disposed(by: disposeBag)
        
        Observable.combineLatest(idValid, pwValid, resultSelector: { $0 && $1 })
            .subscribe(onNext: { b in self.loginButton.isEnabled = b })
            .disposed(by: disposeBag)
    }
    
    //MARK: - valid check logic
    private func checkEmailValid(_ email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func checkPasswordValid(_ password: String) -> Bool {
        return password.count > 5
    }
    
    
    func fetchData(){
        
        downloadJson("https://naver.com")
            .subscribe{ event in
                switch event {
                case let .next(json):
                    DispatchQueue.main.async {
                        self.view.backgroundColor = .green
//                        self.editView.text = json
//                        self.setVisibleWithAnimation(self.activityIndicator, false)
                    }
                case .completed:
                    break
                case .error:
                    break
                }
        }
    }
    
    func downloadJson(_ url: String) -> Observable<String?> {
        return Observable.create() { emitter in
            let url = URL(string: url)!
            //URLSession 은 메인쓰레드가 아닌곳에서 돌아간다
            //
            let task = URLSession.shared.dataTask(with: url) { (data, res, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let data = data,
                    let json = String(data: data, encoding: .utf8){
                    // onNext로 값 전달. 여러개도 가능
                    emitter.onNext(json)
                }
                
                // Observable 은 complete 가 불렸을때 끝남
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create() {
                // dispose가 불렸을때 여기를 실행한다 -> 작업중지시킴
                task.cancel()
            }
        }
    }
}
