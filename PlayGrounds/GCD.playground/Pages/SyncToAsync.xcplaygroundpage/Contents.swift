//: [Previous](@previous)

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let image = UIImage(named: "dark_road_small.jpg")

/**
    동기 함수를 비동기 함수로 만들기
 
    - 오래걸리는 작업을(동기) 비동기로 동작할 수 있도록 바꾸기
 */


//runQueue: 실행 할 큐
//completionQueue: 작업이 끝난 처리를 수행할 큐
//completion: 작업이 끝 난 시점을 알려줌

func asyncTiltShift(_ inputImage: UIImage?, runQueue: DispatchQueue, completionQueue: DispatchQueue, completion: @escaping (UIImage?, Error?) -> ()) {
    
    runQueue.async {
        var error: Error?
        error = .none
        
        let outputImage = tiltShift(image: inputImage)
        completionQueue.async {
            completion(outputImage, error)
        }
    }
}


let workingQueue = DispatchQueue(label: "com.sujin.serial")

// playgorund 에서는 메인큐가 아닌, default global 큐에서 동작
let resultQueue = DispatchQueue.global()


asyncTiltShift(image, runQueue: workingQueue, completionQueue: resultQueue) { image, error in
    image
    print("👾 비동기 작업 종료  👾")
}




//: [Next](@next)
