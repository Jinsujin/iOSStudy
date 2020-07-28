//
//  SceneCoordinator.swift
//  MemoApp
//
//  Created by jsj on 2020/07/26.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/**
실제로 화면에 표시되고 있는 ViewController 를 리턴
 */
extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
    
}

/**
    화면 전환을 담당
 
 */
class SceneCoordinator: SceneCoordinatorType {
    
    private let bag = DisposeBag()
    
    
    private var window: UIWindow
    
    //현재화면에 표시되고 있는 씬
    private var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        self.currentVC = window.rootViewController!
    }
    
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        
        // 전환결과를 방출할 subject
        let subject = PublishSubject<Void>()
        
        // 씬을 생성해서 상수에 저장
        let target = scene.instantiate()
        
        // transition style에 따라서 실제 전환 처리
        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
            
        case .push:
            print(currentVC)
            
            // navigation controller 에 embed 되어 있는지 확인하여 처리
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            // UINavigationDelegate - willShow
            // 화면전환전 호출되는 시점에 구독자를 추가하고 currentVC update
            // delegate 메서드가 호출되는 시점마다 next이벤트를 방출
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] event in
                    self.currentVC = event.viewController.sceneViewController
                })
                .disposed(by: bag)
            
            
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
            
            subject.onCompleted()
            
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            
            currentVC = target.sceneViewController
        }
        
        // subject 를 Completable 로 변환해서 반환
        return subject.ignoreElements()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        
        return Completable.create { [unowned self] completable in
            
            if let presentingVC = self.currentVC.presentingViewController {
                // vc 가 modal 일때, dismiss
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                // vc 가 navigation stack 에 푸쉬되어있다면 pop
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
        }
    }
}
