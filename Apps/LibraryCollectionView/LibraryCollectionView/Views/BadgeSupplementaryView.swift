//
//  BadgeSupplementaryView.swift
//  LibraryCollectionView
//
//  Created by jsj on 2021/03/29.
//

import UIKit

final class BadgeSupplementaryView: UICollectionReusableView {
    static let reuseIdentifier = String(describing: BadgeSupplementaryView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure() {
        backgroundColor = UIColor(named: "rw-green")
        let radius = bounds.width / 2.0
        layer.cornerRadius = radius
    }
}
