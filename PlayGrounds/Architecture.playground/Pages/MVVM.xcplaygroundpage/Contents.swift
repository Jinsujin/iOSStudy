//: [Previous](@previous)

/**
 MVVM
 MV 종류중 최근에 나온 가장 좋은 패턴이다.
 최근에 나왔기에 MV* 가 이전에 직면했던 문제를 고려해 반영되었다.
  
 */

import UIKit


// Model(data)
struct Person {
    let name: String
    let age: Int
}

protocol ViewModelProtocol: class {
    var hello: String? { get }
    var helloDidChange: ((ViewModelProtocol) -> ())? { get set }
    init(person: Person)
    func showHello()
}

// ViewModel
class HelloViewModel: ViewModelProtocol {
    let person: Person
    var hello: String? {
        didSet {
            self.helloDidChange?(self)
        }
    }
    var helloDidChange: ((ViewModelProtocol) -> ())?
    required init(person: Person) {
        self.person = person
    }
    func showHello() {
        self.hello = "Hello, " + person.name
    }
}

// View
class HelloViewController: UIViewController {
    var viewModel: ViewModelProtocol! {
        didSet {
            // 바인딩
            self.viewModel.helloDidChange = { [unowned self] viewModel in
                self.label.text = viewModel.hello
                
            }
        }
    }
    let button = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.addTarget(self.viewModel, action: "showHello", for: .touchUpInside)
    }
    // ...
}

// Assembling of MVVM
let model = Person(name: "jin", age: 22)
let viewModel = HelloViewModel(person: model)
let view = HelloViewController()
view.viewModel = viewModel // 뷰모델 주입




//: [Next](@next)
