//
//  _qxTableView.swift
//  RxDemo
//
//  Created by Richard.q.x on 2017/4/24.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import UIKit

//MARK: -
/// normal, use height in item
class _qxMutiHeightTableView<H, F, C>: _qxConvenienceTableView<H, F, C> {
    //cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return item.sectionItems[indexPath.section].items[indexPath.row].cellHeight
    }
    //header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let header = item.sectionItems[section].header {
            return header.headerHeight
        }
        return kQXTableViewNoneHeight(estimate: false)
    }
    //footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let footer = item.sectionItems[section].footer {
            return footer.footerHeight
        }
        return kQXTableViewNoneHeight(estimate: false)
    }
}

//MARK: -
/// estimatedHeight, use estimatedHeight in item
class _qxEstimatedHeightTableView<H, F, C>: _qxConvenienceTableView<H, F, C> {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return item.sectionItems[indexPath.section].items[indexPath.row].estimatedCellHeight
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if let header = item.sectionItems[section].header {
            return header.estimatedHeaderHeight
        }
        return 0
    }
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if let footer = item.sectionItems[section].footer {
            return footer.estimatedFooterHeight
        }
        return 0
    }
}

//MARK: -
/// fixEstimatedHeight, ignore estimatedHeight and height in item
class _qxStaticEstimatedHeightTableView<H, F, C>: _qxConvenienceTableView<H, F, C> {
    var estimatedSectionHeaderHeight: CGFloat = kQXTableViewDefaultHeaderHeight {
        didSet {
            tableView.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight
        }
    }
    var estimatedSectionFooterHeight: CGFloat = kQXTableViewDefaultFooterHeight {
        didSet {
            tableView.estimatedSectionFooterHeight = estimatedSectionFooterHeight
        }
    }
    var estimatedCellHeight: CGFloat = kQXTableViewDefaultCellHeight {
        didSet {
            tableView.estimatedRowHeight = estimatedCellHeight
        }
    }
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.tableView.estimatedSectionHeaderHeight = kQXTableViewDefaultHeaderHeight
        self.tableView.estimatedSectionFooterHeight = kQXTableViewDefaultFooterHeight
        self.tableView.estimatedRowHeight = kQXTableViewDefaultCellHeight
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -
/// fixHeight, ignore estimatedHeight and height in item
class _qxStaticHeightTableView<H, F, C>: _qxConvenienceTableView<H, F, C> {
    var sectionHeaderHeight: CGFloat = kQXTableViewDefaultHeaderHeight {
        didSet {
            tableView.sectionHeaderHeight = sectionHeaderHeight
        }
    }
    var sectionFooterHeight: CGFloat = kQXTableViewDefaultFooterHeight {
        didSet {
            tableView.sectionFooterHeight = sectionFooterHeight
        }
    }
    var cellHeight: CGFloat = kQXTableViewDefaultCellHeight {
        didSet {
            tableView.rowHeight = cellHeight
        }
    }
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.tableView.sectionHeaderHeight = kQXTableViewDefaultHeaderHeight
        self.tableView.sectionFooterHeight = kQXTableViewDefaultFooterHeight
        self.tableView.rowHeight = kQXTableViewDefaultCellHeight
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - other

/// convenience middle process
class _qxConvenienceTableView<H, F, C>: QXTableView<H, F, C>, UITableViewDataSource, UITableViewDelegate {
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //cells
    func numberOfSections(in tableView: UITableView) -> Int {
        return item.sectionItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.sectionItems[section].items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item.sectionItems[indexPath.section].items[indexPath.row]
        let identity = "\(item.cellClass)"
        let cell: QXTableViewCell<C>
        if let _cell = tableView.dequeueReusableCell(withIdentifier: identity) as? QXTableViewCell<C> {
            cell = _cell
        } else {
            cell = item.cellClass.init(identity: identity)
        }
        cell.indexPath = indexPath
        cell.item = item
        return cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? QXTableViewCell<C>)?.reset()
    }
    //header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = self.item.sectionItems[section]
        if let header = sectionItem.header {
            let identity = "\(header.viewClass)"
            let view: QXTableViewHeaderView<H>
            if let _view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identity) as? QXTableViewHeaderView<H> {
                view = _view
            } else {
                view = header.viewClass.init(identity: identity)
            }
            view.section = section
            view.item = header
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        (view as? QXTableViewHeaderView<H>)?.reset()
    }
    //footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionItem = self.item.sectionItems[section]
        if let footer = sectionItem.footer {
            let identity = "\(footer.viewClass)"
            let view: QXTableViewFooterView<F>
            if let _view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identity) as? QXTableViewFooterView<F> {
                view = _view
            } else {
                view = footer.viewClass.init(identity: identity)
            }
            view.section = section
            view.item = footer
            return view
        }
        return nil
    }
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        (view as? QXTableViewFooterView<F>)?.reset()
    }
    //edit
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let item = self.item.sectionItems[indexPath.section].items[indexPath.row]
        if let sysEditActions = item.sysEditActions {
            return sysEditActions.count > 0
        }
        return false
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let item = self.item.sectionItems[indexPath.section].items[indexPath.row]
        return item.sysEditActions
    }
    
}

/// base tableView
class _qxTableView<H, F, C>: UIView {
    var item: QXTableViewItem<H, F, C>! {
        didSet {
            assert(item != nil)
            self.update(item: item)
            item.respondUpdate = { [weak self] in
                if self != nil {
                    self!.update(item: self!.item)
                }
            }
        }
    }
    func update(item: QXTableViewItem<H, F, C>) {
        self.tableView.reloadData()
    }
    
    let tableView: UITableView
    init(style: UITableViewStyle) {
        self.tableView = UITableView(frame: CGRect.zero, style: style)
        super.init(frame: CGRect.zero)
        addSubview(tableView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = self.bounds
    }
}
