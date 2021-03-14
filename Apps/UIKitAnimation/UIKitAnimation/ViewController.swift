//
//  ViewController.swift
//  UIKitAnimation
//
//  Created by jsj on 2021/03/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var menuHeightConstraint: NSLayoutConstraint!
    
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
//            self.tableView.addItem(item)
//            self.transitionCloseMenu()
        }
        titleLable.superview!.addSubview(slider)
        
        
    }
}

private extension ViewController {
    @IBAction func toggleMenu(_ sender: Any) {
        menuIsOpen.toggle()
        titleLable.text = menuIsOpen ? "Select IceCream": "Baskinrabbins"
        self.view.layoutIfNeeded() // titlelabel 애니메이션 막음

        menuHeightConstraint.constant = menuIsOpen ? 200 : 80
        UIView.animate(
            withDuration: 1/3, delay: 0,
            options: .curveEaseIn,
            animations: {
                self.view.layoutIfNeeded()
            }
        )
    }
    
    func showItem(_ item: Item) {
      let imageView = UIImageView(item: item)
      imageView.backgroundColor = .init(white: 0, alpha: 0.5)
      imageView.layer.cornerRadius = 5
      imageView.layer.masksToBounds = true
      imageView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(imageView)
    }

}
