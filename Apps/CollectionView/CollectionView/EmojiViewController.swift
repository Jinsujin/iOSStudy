//
//  EmojiViewController.swift
//  CollectionView
//
//  Created by jsj on 2021/03/25.
//

import UIKit

class EmojiViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    let dataSource = DataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 6, interItemSpacing: 8)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.allowsMultipleSelection = true
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        
    }
    
    // edit bar button item 을 활성화 할때마다 들어온다
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        deleteButton.isEnabled = isEditing
        addButton.isEnabled = !isEditing
        
        
        collectionView.indexPathsForVisibleItems.forEach {
            guard let emojiCell = collectionView.cellForItem(at: $0) as? EmojiCell else { return }
            emojiCell.isEditing = editing
        }

        // edit 상태가 아닐때, 셀 선택 해제
        if !isEditing {
            collectionView.indexPathsForSelectedItems?.compactMap({ $0 }).forEach {
                collectionView.deselectItem(at: $0, animated: true)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing && identifier == "showEmojiDetail" { // 편집모드일때 화면이 넘어가지 않게 한다
            return false
        }
        return true
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
    
    
    @IBAction func touchedAddEmoji(_ sender: Any) {
        let (category, randomEmoji) = Emoji.randomEmoji()
        dataSource.addEmoji(randomEmoji, to: category)
        
//        collectionView.reloadData() // 전체 셀을 리로드 하기때문에 낭비
        
        let emojiCount = collectionView.numberOfItems(inSection: 0)
        let insertedIndex = IndexPath(item: emojiCount, section: 0)
        collectionView.insertItems(at: [insertedIndex])
        
        
    }
    
    
    /**
     
     삭제해야 할 인덱스 패스가 [2, 4, 5] 일때
     2 > 4 > 5 순으로 삭제를 진행하면, 나중에 삭제하는 4, 5 는 배열순서가 떙겨지게 되므로 다른 오브젝트가 삭제되는 에러 발생
     => 해결: 배열을 뒤집어서 뒤에서 부터 삭제
     */
    @IBAction func touchedDeleteEmoji(_ sender: Any) {
        guard let selectedIndices = collectionView.indexPathsForSelectedItems else { return }
        
        // 삭제해야할 인덱스
        let sectionsToDelete = Set(selectedIndices.map({ $0.section }))
        sectionsToDelete.forEach { section in
            let indexPathsForSection = selectedIndices.filter({ $0.section == section }) //  삭제할 대상의 섹션을 찾고
            let sortedIndexPaths = indexPathsForSection.sorted(by: { $0.item > $1.item }) // [3,2,1]
            print(sortedIndexPaths)
            dataSource.deleteEmoji(at: sortedIndexPaths)
            collectionView.deleteItems(at: sortedIndexPaths)
        }
    }
}

