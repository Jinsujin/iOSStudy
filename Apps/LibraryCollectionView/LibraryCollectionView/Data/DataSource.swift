//
//  DataSource.swift
//  LibraryCollectionView
//
//  Created by jsj on 2021/03/28.
//

import Foundation

class DataSource {
    static let shared = DataSource()
    
    var tutorials: [TutorialCollection]
    private let decoder = PropertyListDecoder()
    
    init() {
        guard let url = Bundle.main.url(forResource: "Tutorials", withExtension: "plist"),
        let data = try? Data(contentsOf: url),
        let tutorials = try? decoder.decode([TutorialCollection].self, from: data) else {
            self.tutorials = []
            return
        }
        self.tutorials = tutorials
    }
}
