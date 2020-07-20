//
//  ViewController.swift
//  MultipleCellTableApp
//
//  Created by jsj on 2020/07/21.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var models = [CellModel]()
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.tableHeaderView = createTableHeader()
        setUpModels()
    }
    
    private func createTableHeader() -> UIView? {
        
        //1. 영상 파일 가져오기
        guard let path = Bundle.main.path(forResource: "aurora02", ofType: "mov") else {
            return nil
        }
        
        let url = URL(fileURLWithPath: path)
        
        let player = AVPlayer(url: url)
        player.volume = 0
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height:  view.frame.size.width))
        
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = headerView.bounds
        headerView.layer.addSublayer(playerLayer)

        playerLayer.videoGravity = .resizeAspectFill
        player.play()
        
        return headerView
    }
    
    private func setUpModels(){
        models.append(.collectionView(models: [
            CollectionTableCellModel(title: "Pizza 1", imageName: "pizza1"),
            CollectionTableCellModel(title: "Pizza 2", imageName: "pizza2"),
            CollectionTableCellModel(title: "Pizza 3", imageName: "pizza3"),
            CollectionTableCellModel(title: "Pizza 4", imageName: "pizza4"),
            CollectionTableCellModel(title: "Pizza 5", imageName: "pizza5"),
            CollectionTableCellModel(title: "Pizza 6", imageName: "pizza6")
        ], rows: 2))
        
        models.append(.list(models: [
            ListCellModel(title: "First"),
            ListCellModel(title: "Second"),
            ListCellModel(title: "Third")
        ]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch models[section] {
        case .list(let models):
            return models.count
        case .collectionView(let models, _):
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch models[indexPath.section] {
        case .list(let models):
            let model = models[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.title
            return cell
            
        case .collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        print("didSelectRowAt", indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch models[indexPath.section] {
        case .list(_):
            return 50
        case .collectionView(_, let rows):
            return 180 * CGFloat(rows)
        }
        
    }
}



extension ViewController : CollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print(model.title)
    }
}
