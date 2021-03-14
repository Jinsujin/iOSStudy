//
//  HorizontalSlider.swift
//  UIKitAnimation
//
//  Created by jsj on 2021/03/15.
//

import UIKit

class HorizontalSlider: UIScrollView {


    typealias HandleTap = (Item) -> Void
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(in view: UIView, handleTap: @escaping HandleTap){
        super.init(frame: .init(x: 0, y: 120, width: view.frame.width, height: 80))
        
        let buttonWidth: CGFloat = 60
        
        for (index, item) in Item.allCases.enumerated() {
            let imgView = UIImageView(item: item)
            imgView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            imgView.center = CGPoint(x: CGFloat(index) * buttonWidth + buttonWidth/2, y: buttonWidth/2)
            
            addSubview(imgView)
            imgView.addGestureRecognizer(
                TapGestureRecognizer{handleTap(item)}
            )
        }
        
        let padding:CGFloat = 10
        contentSize = CGSize(width: padding * buttonWidth, height: buttonWidth + 2 * padding)
        
    }

}
