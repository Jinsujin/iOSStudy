//
//  ViewController.swift
//  UIMaster
//
//  Created by jsj on 2021/10/07.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let vc = ProgressTimerViewController()
        let vc = CustomProgress()
        present(vc, animated: false, completion: nil)
    }

}

