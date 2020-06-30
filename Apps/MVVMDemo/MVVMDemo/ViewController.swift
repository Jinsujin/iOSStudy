//
//  ViewController.swift
//  MVVMDemo
//
//  Created by jsj on 2020/06/30.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    @objc func touchupGoTodolistButton(){
        self.present(TodoController(), animated: true)
    }
    
    func setupViews(){
        let goTodoListButton = UIButton()
        goTodoListButton.setTitle("Go TodoList", for: .normal)
        goTodoListButton.setTitleColor(.black, for: .normal)
        goTodoListButton.addTarget(self, action: #selector(touchupGoTodolistButton), for: .touchUpInside)
        goTodoListButton.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [goTodoListButton])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        self.view.addConstraints([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }


}

