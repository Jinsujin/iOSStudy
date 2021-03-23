/**
 
 iOS 13.
 - Diffable data sources
 - Compositional layout objects
 
 */

import UIKit

class ViewController: UIViewController {

    enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = configureLayout()
        
        configureDaraSource()
    }

    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        // 1. item 각각의 사이즈를 설정
        // 0.5: 50%
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // item 안쪽 여백
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // 2. 아이템을 감싸는 그룹사이즈를 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // 3. group 을 감싸는 section의 사이즈를 설정
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    
    func configureDaraSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
            //
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberCell.reuseIdentifier, for: indexPath) as? NumberCell else {
                fatalError("cannot create new cell")
            }
            cell.label.text = number.description
            return cell
        })
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(Array(1...100))
        
        dataSource.apply(initialSnapshot, animatingDifferences: false, completion: {})
    }
}

