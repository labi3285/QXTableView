//
//  _qxTableViewItems.swift
//  RxDemo
//
//  Created by Richard.q.x on 2017/4/24.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import UIKit

//MARK:- bussiness

/// tableView item
public class _qxTableViewItem<H,F,C> {
    public var sectionItems: [QXTableViewSectionItem<H,F,C>]      { didSet { respondUpdate?() } }
    public var respondUpdate: (() -> ())?
    public init(sectionItems: [QXTableViewSectionItem<H,F,C>]) {
        self.sectionItems = sectionItems
    }
}
/// section item
class _qxTableViewSectionItem<H,F,C> {
    var header: QXTableViewHeaderItem<H>?      { didSet { respondUpdate?() } }
    var items: [QXTableViewCellItem<C>]        { didSet { respondUpdate?() } }
    var footer: QXTableViewFooterItem<F>?      { didSet { respondUpdate?() } }
    var respondUpdate: (() -> ())?
    init(header: QXTableViewHeaderItem<H>?, footer: QXTableViewFooterItem<F>?, items: [QXTableViewCellItem<C>]) {
        self.header = header
        self.items = items
        self.footer = footer
    }
}
/// cell item
class _qxTableViewCellItem<D>: _qxTableViewReuseCellItem<D> {
    var cellHeight: CGFloat = kQXTableViewDefaultCellHeight
    var estimatedCellHeight: CGFloat = kQXTableViewDefaultCellHeight
    var sysEditActions: [UITableViewRowAction]?
}
/// header item
class _qxTableViewHeaderItem<D>: _qxTableViewReuseHeaderViewItem<D> {
    var headerHeight: CGFloat = kQXTableViewDefaultHeaderHeight
    var estimatedHeaderHeight: CGFloat = kQXTableViewDefaultHeaderHeight
}
/// footer item
class _qxTableViewFooterItem<D>: _qxTableViewReuseFooterViewItem<D> {
    var footerHeight: CGFloat = kQXTableViewDefaultFooterHeight
    var estimatedFooterHeight: CGFloat = kQXTableViewDefaultFooterHeight
}

//MARK:- base classes

/// reuse tableHeader item
class _qxTableViewReuseHeaderViewItem<D>: _qxTableViewDataItem<D> {
    let viewClass: QXTableViewHeaderView<D>.Type
    init(data: D, viewClass: QXTableViewHeaderView<D>.Type) {
        self.viewClass = viewClass
        super.init(data: data)
    }
}
/// reuse tableFooter item
class _qxTableViewReuseFooterViewItem<D>: _qxTableViewDataItem<D> {
    let viewClass: QXTableViewFooterView<D>.Type
    init(data: D, viewClass: QXTableViewFooterView<D>.Type) {
        self.viewClass = viewClass
        super.init(data: data)
    }
}
/// reuse tableCell item
class _qxTableViewReuseCellItem<D>: _qxTableViewDataItem<D> {
    let cellClass: QXTableViewCell<D>.Type
    init(data: D, cellClass: QXTableViewCell<D>.Type) {
        self.cellClass = cellClass
        super.init(data: data)
    }
}

/// root data item
class _qxTableViewDataItem<D> {
    var data: D     { didSet { respondUpdate?() } }
    var respondUpdate: (() -> ())?
    init(data: D) {
        self.data = data
    }
}
