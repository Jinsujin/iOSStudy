//
//  ViewController.swift
//  UIKitAnimation
//
//  Created by jsj on 2021/03/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var menuHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var menuButtonTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet private var tableView: TableView! {
      didSet { tableView.handleSelection = showItem }
    }
//    @IBOutlet weak var tableView: TableView!
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    
    
    private var menuIsOpen = false
    private var slider: HorizontalSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        slider = HorizontalSlider(in: view){ [unowned self] item in
            self.tableView.addItem(item)
//            self.transitionCloseMenu()
        }
        titleLable.superview!.addSubview(slider)
        
        
    }
}

private extension ViewController {
    @IBAction func toggleMenu() {
        menuIsOpen.toggle()
        titleLable.text = menuIsOpen ? "Select IceCream": "Baskinrabbins"
        self.view.layoutIfNeeded() // titlelabel 애니메이션 막음

        let constraints = titleLable.superview!.constraints
        
        constraints.first {
            $0.firstItem === titleLable
            && $0.firstAttribute == .centerX
        }?.constant = menuIsOpen ? -100 : 0
        constraints.first {$0.identifier == "Title Center Y"}!.isActive = false
        let constraint = NSLayoutConstraint(item: titleLable!, attribute: .centerY, relatedBy: .equal, toItem: titleLable.superview, attribute: .centerY, multiplier: menuIsOpen ? 2/3 : 1, constant: 0)
        constraint.identifier = "Title Center Y"
        constraint.priority = .defaultHigh
        constraint.isActive = true
        
        
        menuHeightConstraint.constant = menuIsOpen ? 200 : 80
        menuButtonTrailingConstraint.constant = menuIsOpen ? 16: 8
        UIView.animate(
            withDuration: 1/3, delay: 0,
            options: .curveEaseIn,
            animations: {
                self.menuButton.transform = .init(rotationAngle: self.menuIsOpen ? .pi / 4 : 0)
                self.view.layoutIfNeeded()
            }
        )
        
    }
    
    // cell 클릭시, 아이템 애니메이션
    func showItem(_ item: Item) {
      let imageView = UIImageView(item: item)
      imageView.backgroundColor = .init(white: 0, alpha: 0.5)
      imageView.layer.cornerRadius = 5
      imageView.layer.masksToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(imageView)
        
        let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: imageView.frame.height)
        let widthConstraint = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -50)
        
        NSLayoutConstraint.activate([
            bottomConstraint,
            widthConstraint,
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.8){
            bottomConstraint.constant = imageView.frame.height * -2
            widthConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
        UIView.animateKeyframes(withDuration: 2/3, delay: 2) {
            bottomConstraint.constant = imageView.frame.height
            widthConstraint.constant = -50
            self.view.layoutIfNeeded()
        } completion: { _ in
            // 화면에서 이미지뷰가 사라질때, 상위뷰에서 제거
            imageView.removeFromSuperview()
        }

    }

}

