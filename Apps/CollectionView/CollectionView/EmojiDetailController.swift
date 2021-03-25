//
//  EmojiDetailController.swift
//  CollectionView
//
//  Created by jsj on 2021/03/25.
//

import UIKit

class EmojiDetailController: UIViewController {

    var emoji: String? {
      didSet {
        if let label = textLabel {
          label.text = emoji
        }
      }
    }
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      textLabel.text = emoji
    }
}
