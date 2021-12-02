import Foundation

class Service {
    let repository = Repository()
    
    func add(a: Int, b: Int) -> Int {
        let result = a + b
        
        // DB save
//        repository.save(num: result)
        
        return result
    }
}
