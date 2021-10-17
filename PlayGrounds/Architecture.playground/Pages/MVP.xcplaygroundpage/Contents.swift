//: [Previous](@previous)

/**
 MVP
 
 MVC 와 유사하게 생겼다. 하지만 중재자 역할을 하는 Presenter 가 ViewController 의 라이프 사이클과 상관이 없다.
 따라서 Presenter 에는 레이아웃을 구성하는 코드가 전혀 없고, 데이터와 state 를 사용해 View 를 업데이트 하는 역할을 한다.
 
 MVVM 과의 차이점
 - MVP 는 Presenter 가 Model 에게 뷰를 업데이트 하라고 지시
 - MVVM 은 View 와 ViewModel 이 바인딩 되어 뷰모델의 데이터가 바뀌면, View 가 이를 알아채고 업데이트
 */


import UIKit

// Model
struct Person {
    let name: String
    let age: Int
}


protocol HelloViewPresenter {
    init(view: HelloView, person: Person)
    func showGreeting()
}


protocol HelloView: class {
    func setHello(hello: String)
}


// Presenter
class HelloPresenter : HelloViewPresenter {
    unowned let view: HelloView
    let person: Person
    required init(view: HelloView, person: Person) {
        self.view = view
        self.person = person
    }
    func showGreeting() {
        let greeting = "Hello" + " I'm " + self.person.name
            + " " + "\(self.person.age)" + "year's old."
        self.view.setHello(hello: greeting)
    }
}


// View
class HelloViewController : UIViewController, HelloView {
    var presenter: HelloPresenter!
    let button = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.addTarget(self, action: "touchedButton:", for: .touchUpInside)
    }
    
    func touchedButton(button: UIButton) {
        self.presenter.showGreeting()
    }
    
    func setHello(hello: String) {
        self.label.text = hello
    }
    
    // layout code goes here
}



// Assembling of MVP
let model = Person(name: "jin", age: 22)
let view = HelloViewController()
let presenter = HelloPresenter(view: view, person: model)
view.presenter = presenter



//: [Next](@next)
