//
//  ViewController.swift
//  Unit
//
//  Created by jsj on 2021/12/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindUI() {
        viewModel.handle = { num in
            self.textLabel.text = "\(num)"
        }
    }
    
    @IBAction func touchedButton(_ sender: Any) {
        calculate()
    }
    
    func calculate(){
        viewModel.add(a: 1, b: 3)
    }

}

