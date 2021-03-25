//
//  EmojiViewController.swift
//  CollectionView
//
//  Created by jsj on 2021/03/25.
//

import UIKit

class EmojiViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    

    let dataSource = DataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 6, interItemSpacing: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showEmojiDetail",
              let emojiCell = sender as? EmojiCell,
              let emojiDetailController = segue.destination as? EmojiDetailController,
              let indexPath = collectionView.indexPath(for: emojiCell),
              let emoji = Emoji.shared.emoji(at: indexPath) else {
            fatalError()
        }
        
        emojiDetailController.emoji = emoji
        
    }


}

