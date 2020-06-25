//
//  OperatorViewController.swift
//  RxSwiftDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


/**
    Operator
 
    * just: 그냥 한번에 다 내려보낸다
    * from: 하나씩 내려 보낸다
    * map: 변환시켜서 내려 보낸다
    * filter: true 인 애만 내려보낸다
 
 
    * Obsevable 생성 : create, just, from
    * Observable 두개 이상 결합
    *   오류처리
 
 
    *subscribe : 최종으로 얻어진 데이터를 받아서 사용
 */

class OperatorViewController: UIViewController {

    private var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    private func output(_ s:Any) -> Void {
        print(s)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func just1(_ sender: Any) {
//        Observable.just("Hello world!")
//        Observable.just(["Hello", "World!"])
//            .subscribe(onNext: { str in
//                print(str)
//            })
//            .disposed(by: disposeBag)
        
        
        // 방법1. subscribe 에서 switch 로 케이스별 처리
        Observable.from(["Hello", "World!"])
            .subscribe{ event in
                    switch event {
                    case .next(let str):
                        print("next: \(str)")
                        break
                    case .error(let err):
                        print("error \(err)");
                        break
                    case .completed:
                        print("completed")
                        break
                    }
                }
                .disposed(by: disposeBag)
    
        // 방법2.
        Observable.from(["banana", "orange", "apple"])
            .subscribe(onNext: output
                , onError: { (error) in
                print(error.localizedDescription)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
        .disposed(by: disposeBag)
            
    }
    
    // 배열에 있는 요소들을 하나씩 내려준다
    @IBAction func from1(_ sender: Any) {
        Observable.from(["1", "2", 3, "4"]) // 다른타입도 넣을 수 있다!
            .subscribe(onNext: { arr in
                print(arr)
            })
        .disposed(by: disposeBag)
    }
    
    @IBAction func map1(_ sender: Any) {
        Observable.just("Hello")
            .map { str in "\(str) World!"} // 내려오는 애를 바꿔치기 해서 밑으로 내려보낸다
            .subscribe(onNext: { str in // 여기서 내려오는 애는 "Hello World!"
                print(str)
            })
        .disposed(by: disposeBag)
    }
    
    @IBAction func map2(_ sender: Any) {
        Observable.from(["mint", "choco"]) // mint 먼저 내려보내서 모든 스트림 작업이 끝나면, 다음 choco 를 내려보낸다
            .map { $0.count }
            .subscribe(onNext: { str in
                print(str)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func filter(_ sender: Any) {
        Observable.from([1,2,3,4,5,6,7,8,9,10])
            .filter{ $0 % 2 == 0} // true 일때만 밑으로 내려보낸다. 짝수가 아닌것은 밑으로 내려보내지 않는다
            .subscribe(onNext: { n in
                print(n)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func map3(_ sender: Any) {
        

        /*
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/")} //800/600
            .map { "https://picsum.photos/\($0)/?random" } // https://picsum.photos/800/600/?random
            .map { URL(string: $0)} // url 로 변경
            .filter{ $0 != nil} // url 객체가 nil인지 체크. nil 이면 false 이기때문에, 밑으로 내려가지 못함
            .map { $0! } // URL! 강제 언래핑 - 위에서 이미 nil체크 했기때문에 에러나지 않음!
            .map { try Data(contentsOf: $0) } // Data
            .map { UIImage(data: $0)}
            .subscribe(onNext: { image in
                self.imageView.image = image
            })
            .disposed(by: disposeBag)
        */
        
        
        
        // action 은 메인스레드에서 동작하기 때문에, UI에 락이 걸려 멈추는 현상이 발생
        // => 해결법. Concurrent 쓰레드에서 동작시키기 (스케쥴러)
        
        // 방법1. 동시에 실행하고 && 메인스레드가 아닌곳에서 실행
        // 이미지 설정은 메인쓰레드에서 실행 해야함
        /*
        Observable.just("800x600")
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default)) // observeOn 밑의 스트림은 모두 ConcurrentDispatchQueueScheduler 에서 동작하게 됨
            .map { $0.replacingOccurrences(of: "x", with: "/")}
            .map { "https://picsum.photos/\($0)/?random" }
            .map { URL(string: $0)}
            .filter{ $0 != nil}
            .map { $0! }
            .map { try Data(contentsOf: $0) }
            .map { UIImage(data: $0)}
            .observeOn(MainScheduler.instance) // 이 다음 스트림 부터 MainScheduler 에서 동작
            .subscribe(onNext: { image in
                self.imageView.image = image
            })
            .disposed(by: disposeBag)
 
 */
        
        
        // 방법2. subscribeOn : 첫 스트림부터 영향을 주게 하고 싶을때 사용.
        // .subscribe 될때부터 적용함 => 아무대나 넣어도 상관없음
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/")}
            .map { "https://picsum.photos/\($0)/?random" }
            .map { URL(string: $0)}
            .filter{ $0 != nil}
            .map { $0! }
            .map { try Data(contentsOf: $0) }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .map { UIImage(data: $0)}
            .observeOn(MainScheduler.instance) // 이 다음 스트림 부터 MainScheduler 에서 동작
            .subscribe(onNext: { image in
                self.imageView.image = image
            })
            .disposed(by: disposeBag)
        
    }
}

