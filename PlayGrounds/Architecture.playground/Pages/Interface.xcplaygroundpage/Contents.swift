//: [Previous](@previous)

import Foundation

/**
 interface(Protocol) 을 사용한 다중 상속 구현
 */

class Widget {
    static var numWidgets: Int = 0
    var label: String
    var x: Int
    var y: Int
    init(x: Int, y: Int) {
        self.label = String(format: "Widget%d", Widget.numWidgets)
        self.x = x
        self.y = y
        Widget.numWidgets += 1
    }
}

protocol Clickable {
    func onClick()
}

protocol Draggable {
    func onDrag(x: Int, y: Int)
}

protocol Droppable {
    func onDrop(widget: Widget)
}

final class Button: Widget, Clickable {
    override init(x: Int, y: Int) {
        super.init(x: x, y: y)
    }
    
    func onClick() {
        print("Button onClick")
    }
}

final class Card: Widget, Draggable {
    private var content: String = "no content"
    
    override init(x: Int, y: Int) {
        super.init(x: x, y: y)
    }
    func onDrag(x: Int, y: Int) {
        print("Drag card")
    }
}

final class Directory: Widget, Clickable, Draggable, Droppable {
    override init(x: Int, y: Int) {
        super.init(x: x, y: y)
    }
    
    func onClick() {
        print("Directory onClick")
    }
    
    func onDrag(x: Int, y: Int) {
        print("Directory onDrag")
    }
    
    func onDrop(widget: Widget) {
        print("Directory onDrop, widget: \(widget.label)")
    }
}

// widget 생성
let button1 = Button(x: 5, y: 5)
let button2 = Button(x: 10, y: 15)
let card = Card(x: 0, y: 1)
let directory = Directory(x: 22, y: 32)

var widgets = [Widget]()
widgets.append(button1)
widgets.append(button2)
widgets.append(card)
widgets.append(directory)

// 상속을 사용한 다형성
for w in widgets {
    print(w.label)
    // w.onClick() => 컴파일 에러
}

// 인터페이스를 사용한 다형성
var clickables = [Clickable]()
clickables.append(button1)
clickables.append(directory)
for item in clickables {
    item.onClick()
}


//: [Next](@next)
