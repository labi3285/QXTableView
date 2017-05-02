//
//  QXTableView.swift
//  RxDemo
//
//  Created by Richard.q.x on 2017/4/24.
//  Copyright © 2017年 labi3285. All rights reserved.
//

import UIKit

public var QXTableViewVersionNumber: Double = 1.0

//MARK: - globals
/// a max value for estimate height
public let kQXTableViewEstimatedMaxHeight:     CGFloat = 99999
/// default cell height
public let kQXTableViewDefaultCellHeight:      CGFloat = 50
/// default header height
public let kQXTableViewDefaultHeaderHeight:    CGFloat = 20
/// default footer height
public let kQXTableViewDefaultFooterHeight:    CGFloat = 20
/// use for null header & footer
public func kQXTableViewNoneHeight(estimate: Bool) -> CGFloat {
    if estimate {
        return 0
    }
    return 0.0001
}

//MARK: -  tableView
/// tableView item
public class QXTableViewItem<H,F,C>:                       _qxTableViewItem<H,F,C> { }
/// base tableView
public class QXTableView<H,F,C>:                           _qxTableView<H,F,C> { }
/// normal, use height in item
public class QXMutiHeightTableView<H,F,C>:                 _qxMutiHeightTableView<H,F,C> { }
/// estimatedHeight, use estimatedHeight in item
public class QXEstimatedHeightTableView<H,F,C>:            _qxEstimatedHeightTableView<H,F,C> { }
/// fixEstimatedHeight, ignore estimatedHeight and height in item
public class QXStaticEstimatedHeightTableView<H,F,C>:      _qxStaticEstimatedHeightTableView<H,F,C> { }
/// fixHeight, ignore estimatedHeight and height in item
public class QXStaticHeightTableView<H,F,C>:               _qxStaticHeightTableView<H,F,C> { }


//MARK: - section
public class QXTableViewSectionItem<H,F,C>:        _qxTableViewSectionItem<H,F,C> { }

//MARK: - cell
/// cell item
public class QXTableViewCellItem<D>:               _qxTableViewCellItem<D> { }
/// cell
public class QXTableViewCell<D>:                   _qxTableViewReuseCell<D> { }


//MARK: - header
/// header item
public class QXTableViewHeaderItem<D>:             _qxTableViewHeaderItem<D> { }
/// header view
public class QXTableViewHeaderView<D>:             _qxTableViewReuseHeaderView<D> { }

//MARK: - footer
/// footer item
public class QXTableViewFooterItem<D>:             _qxTableViewFooterItem<D> { }
/// footer
public class QXTableViewFooterView<D>:             _qxTableViewReuseFooterView<D> { }

