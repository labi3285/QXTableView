//
//  ViewController.swift
//  QXTableView
//
//  Created by Richard.q.x on 2017/5/2.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import UIKit

/// person data model
class Person {
    var name: String
    var age: Int
    var brief: String = "（无）"
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

/// person cell (those who wanna contains muti type cells, must set data to Any)
class PersonCell: QXTableViewCell<Any> {
    override func update(item: QXTableViewCellItem<Any>) {
        super.update(item: item)
        if let person = item.data as? Person {
            nameLabel.text = person.name
            ageLabel.text = "\(person.age) 岁"
            detail.text = person.brief
        }
    }
    lazy var nameLabel: UILabel = {
        let one = UILabel()
        one.numberOfLines = 0
        one.textColor = UIColor.black
        one.font = UIFont.systemFont(ofSize: 20)
        return one
    }()
    lazy var ageLabel: UILabel = {
        let one = UILabel()
        one.numberOfLines = 0
        one.textColor = UIColor.gray
        one.font = UIFont.systemFont(ofSize: 16)
        return one
    }()
    lazy var detail: UILabel = {
        let one = UILabel()
        one.numberOfLines = 0
        one.textColor = UIColor.lightGray
        one.font = UIFont.systemFont(ofSize: 12)
        return one
    }()
    required init(identity: String?) {
        super.init(identity: identity)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(detail)
        nameLabel.IN(contentView).LEFT(10).TOP(10).RIGHT(10).MAKE()
        ageLabel.BOTTOM(nameLabel).OFFSET(10).LEFT.RIGHT.MAKE()
        detail.BOTTOM(ageLabel).OFFSET(10).LEFT.RIGHT.MAKE()
        detail.BOTTOM.EQUAL(contentView).OFFSET(-10).MAKE()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// header view
class HeaderView: QXTableViewHeaderView<String> {
    override func update(item: QXTableViewHeaderItem<String>) {
        super.update(item: item)
        titleLabel.text = item.data
    }
    lazy var titleLabel: UILabel = {
        let one = UILabel()
        one.numberOfLines = 0
        return one
    }()
    required init(identity: String?) {
        super.init(identity: identity)
        contentView.addSubview(titleLabel)
        titleLabel.IN(contentView).LEFT(10).RIGHT(10).TOP(10).BOTTOM(10).MAKE()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// footer view
class FooterView: QXTableViewFooterView<String> {
    lazy var titleLabel: UILabel = {
        let one = UILabel()
        one.numberOfLines = 0
        return one
    }()
    override func update(item: QXTableViewFooterItem<String>) {
        super.update(item: item)
        titleLabel.text = item.data
    }
    required init(identity: String?) {
        super.init(identity: identity)
        contentView.addSubview(titleLabel)
        titleLabel.IN(contentView).LEFT(10).RIGHT(10).TOP(10).BOTTOM(10).MAKE()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    var tableViewItem: QXTableViewItem<String, String, Any>!
    lazy var tableView: QXStaticEstimatedHeightTableView<String, String, Any> = {
        let one = QXStaticEstimatedHeightTableView<String, String, Any>(style: .plain)
        //one.estimatedCellHeight = kQXTableViewEstimatedMaxHeight
        //one.estimatedSectionHeaderHeight = kQXTableViewEstimatedMaxHeight
        //one.estimatedSectionFooterHeight = kQXTableViewEstimatedMaxHeight
        return one
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.IN(view).LEFT.RIGHT.TOP.BOTTOM.MAKE()
        
        let persons = [
            Person(name: "小明", age: 18),
            Person(name: "小花", age: 16),
            Person(name: "小强", age: 20),
            Person(name: "小明", age: 18),
            Person(name: "小花", age: 16),
            Person(name: "小强", age: 20),
            ]
        for person in persons {
            person.brief = RadomiseText(200)
        }
        
        var items = [QXTableViewCellItem<Any>]()
        for person in persons {
            let item = QXTableViewCellItem<Any>(data: person, cellClass: PersonCell.self)
            items.append(item)
        }
        
        let headerText = "Header: 0"
        let header = QXTableViewHeaderItem<String>(data: headerText, viewClass: HeaderView.self)
        
        let footerText = "Footer: 0" + RadomiseText(100)
        let footer = QXTableViewFooterItem<String>(data: footerText, viewClass: FooterView.self)
        
        let sectionItem = QXTableViewSectionItem<String, String, Any>(header: header, footer: footer, items: items)

        tableViewItem = QXTableViewItem<String, String, Any>(sectionItems: [sectionItem])
        
        tableView.item = tableViewItem

    }
}



func RadomiseText(_ lev: UInt32) -> String {
    var text = ""
    for i in 0...arc4random_uniform(lev) {
        text += "\(i)"
    }
    return text
}



