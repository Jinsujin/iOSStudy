import Foundation

protocol RepositoryProtocol {
    func save(num: Int)
}


// DB, API fetch
class Repository: RepositoryProtocol {
    func save(num: Int) {
        print("Repository save:", num)
    }
}
