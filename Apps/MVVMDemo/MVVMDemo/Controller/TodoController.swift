//
//  TodoViewController.swift
//  MVVMDemo
//
//  Created by jsj on 2020/06/30.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit

class TodoController: UITableViewController {

    var todoViewModels:[TodoViewModel] = []
    private let cellId = "todoCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchTodoData()
    }

    fileprivate func fetchTodoData(){
        Service.shared.fetchTodos { (todos, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.todoViewModels = todos?.map({ TodoViewModel(todo: $0) }) ?? []
            self.tableView.reloadData()
        }
    }
    
    
    fileprivate func setupTableView(){
        tableView.register(TodoCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 24)
        tableView.separatorColor = .gray
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
        
    }
    
     // MARK: - Table view data source
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todoViewModels.count
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoCell
         cell.todoViewModel = todoViewModels[indexPath.row]
         return cell
     }
    
}
