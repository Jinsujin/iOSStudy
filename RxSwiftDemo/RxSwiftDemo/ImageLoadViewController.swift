//
//  ImageLoadViewController.swift
//  RxSwiftDemo
//
//  Created by jsj on 2020/06/25.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImageLoadViewController: UIViewController {

    var counter: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (_) in
            self.counter += 1
            self.countLabel.text = "\(self.counter)"
        }
    }

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    @IBAction func onLoadImage(_ sender: Any) {
        
        imageView.image = nil
        
        // 이미지를 받아오고 나서의 처리를 subscribe 에 한다
        // subscribe 하면, dispose 가 리턴된다. 이 dispose 로 작업을 취소할 수 있다
        rxSwiftLoadImage(from: loadingImageUrl)
            .observeOn(MainScheduler.instance) // ui 변경로직은 메인에서 처리해야 하므로
            .subscribe({ result in
                switch result {
                case let .next(image):
                    self.imageView.image = image
                case let .error(err):
                    print(err)
                case .completed:
                    break
                }
            }).disposed(by: disposeBag) // disposeBag 에 넣어준다
        
//        disposeBag.insert(disposable)
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
        // 작업을 취소한다
        // 예) 비동기 작업중, 어느 한부분에서 에러가 나면 작업전체를 취소시킬 수 있다
        // 날코딩 작업을 한다면, 오퍼레이션 큐를 이용해서 작업해야 함 or 플래그 처리
//        disposable?.dispose()
        disposeBag = DisposeBag()
    }
    
    
    /**
     imageUrl 로 비동기 통신을 해서, 이미지 데이터를 받아온 다음,
     Observable 로 리턴
     */
    func rxSwiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
        return Observable.create { seal in
            asyncLoadImage(from: imageUrl) { image in
                // next 로 이미지를 전달
                seal.onNext(image)
                seal.onCompleted()
            }
            return Disposables.create()
        }
        
    }
}
