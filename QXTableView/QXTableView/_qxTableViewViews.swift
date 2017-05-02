//
//  _qxTableViewViews.swift
//  RxDemo
//
//  Created by Richard.q.x on 2017/4/24.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import UIKit

/// reuse cell
class _qxTableViewReuseCell<D>: UITableViewCell {
    
    var indexPath: IndexPath!
    
    var item: QXTableViewCellItem<D>! {
        didSet {
            assert(item != nil)
            update(item: item)
            item.respondUpdate = { [weak self] in
                if self != nil {
                    self!.update(item: self!.item)
                }
            }
        }
    }
    func update(item: QXTableViewCellItem<D>) { }
    func reset() {
        item.respondUpdate = nil
    }
    
    required init(identity: String?) {
        super.init(style: .default, reuseIdentifier: identity)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// reuse header
class _qxTableViewReuseHeaderView<D>: UITableViewHeaderFooterView {
    
    var section: Int!
    
    var item: QXTableViewHeaderItem<D>! {
        didSet {
            assert(item != nil)
            update(item: item)
            item.respondUpdate = { [weak self] in
                if self != nil {
                    self!.update(item: self!.item)
                }
            }
        }
    }
    func update(item: QXTableViewHeaderItem<D>) { }
    func reset() {
        item.respondUpdate = nil
    }
    
    required init(identity: String?) {
        super.init(reuseIdentifier: identity)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// reuse footer
class _qxTableViewReuseFooterView<D>: UITableViewHeaderFooterView {
    
    var section: Int!

    var item: QXTableViewFooterItem<D>! {
        didSet {
            assert(item != nil)
            update(item: item)
            item.respondUpdate = { [weak self] in
                if self != nil {
                    self!.update(item: self!.item)
                }
            }
        }
    }
    func update(item: QXTableViewFooterItem<D>) { }
    func reset() {
        item.respondUpdate = nil
    }
    
    required init(identity: String?) {
        super.init(reuseIdentifier: identity)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
