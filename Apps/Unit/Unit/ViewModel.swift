import Foundation

class ViewModel {
    let service = Service()
    
//    var datas: [String] = []
    
    var handle: ((Int) -> Void)?
    
    var result: Int = 0 {
        didSet {
            self.handle?(result)
        }
    }
    
    func add(a: Int, b: Int) {
        self.result = service.add(a: a, b: b)
    }
}
