import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/**
 Dispatch group
 
 */
let workingQueue = DispatchQueue(label: "com.hello.concurrent", attributes: .concurrent)
let numberArray = [(0,1), (2,3), (4,5), (6,7), (8,9), (10, 11)]

// create dispatchGroup
let group1 = DispatchGroup()

for inValue in numberArray {
    workingQueue.async(group: group1) {
        let result = slowAdd(inValue)
        print("결과값: \(result)")
    }
}

func slowAdd(_ input: (Int, Int)) -> Int {
  sleep(30)
  return input.0 + input.1
}


// 그룹1의 모든 작업이 끝났을때, notify 로 알림을 받는다
let desultQueue = DispatchQueue.global()

group1.notify(queue: desultQueue) {
    print("---// group1 End ----")
}



// wait : 그룹작업이 다 끝나야만 다음 작업을 할 수 있을때 사용
// distantFuture 먼 미래
group1.wait(timeout: DispatchTime.distantFuture)


// 시간제한을 걸어두고 기다리기
if group1.wait(timeout: .now() + 60) == .timedOut {
    print("모든 작업이 60초안에 끝나지 않았습니다")
}
