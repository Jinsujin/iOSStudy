//
//  CustomProgress.swift
//  UIMaster
//
//  Created by jsj on 2021/10/07.
//

import UIKit

class CustomProgress: UIViewController {

    lazy var horizontalBarProgress: PlainHorizontalProgressBar = {
        let v = PlainHorizontalProgressBar(color: .red, frame: CGRect(x: 0, y: 0, width: Int(view.frame.width), height: 50))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var circleProgress: CircleProgress = {
        let v = CircleProgress(color: .orange, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    lazy var progressSlider: UISlider = {
        let s = UISlider()
        s.addTarget(self, action: #selector(progressChanged), for: .valueChanged)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    @objc func progressChanged(_ sender: UISlider)  {
        print(sender.value)
        let progress = CGFloat(sender.value)
        horizontalBarProgress.progress = progress
        circleProgress.progress = progress
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let stack = UIStackView(arrangedSubviews: [horizontalBarProgress, circleProgress, progressSlider ])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            horizontalBarProgress.widthAnchor.constraint(equalTo: stack.widthAnchor),
            horizontalBarProgress.heightAnchor.constraint(equalToConstant: 20),
            
            circleProgress.widthAnchor.constraint(equalToConstant: 200),
            circleProgress.heightAnchor.constraint(equalToConstant: 200),
            
            progressSlider.widthAnchor.constraint(equalTo: stack.widthAnchor)
            

        ])
    }
}


