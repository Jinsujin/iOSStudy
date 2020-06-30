//
//  TodoCell.swift
//  MVVMDemo
//
//  Created by jsj on 2020/06/30.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    var todoViewModel: TodoViewModel! {
        didSet {
            textLabel?.text = todoViewModel.title
            detailTextLabel?.text = todoViewModel.detailTextString
            accessoryType = todoViewModel.accessoryType
        }
    }
    
    /*
     // MVC 일때
    var todo: TodoViewModel! {
        didSet {
            textLabel?.text = todo.title

            if todo.isDone {
                accessoryType = .detailDisclosureButton
                detailTextLabel?.text = "Complete😃"
            } else {
                detailTextLabel?.text = "Not Complete"
                accessoryType = .none
            }
        }
    }
 */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        contentView.backgroundColor = isHighlighted ? .brown : .white
        textLabel?.textColor = isHighlighted ? .white : .blue
        detailTextLabel?.textColor = isHighlighted ? .white : .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        textLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
