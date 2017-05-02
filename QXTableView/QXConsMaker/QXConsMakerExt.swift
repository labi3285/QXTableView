//
//  QXConsMakerExt.swift
//  QXAutoLayoutDemo
//
//  Created by Richard.q.x on 16/5/6.
//  Copyright © 2016年 labi3285_lab. All rights reserved.
//
//  GitHub: https://github.com/labi3285/QXConsMaker

import UIKit

@discardableResult public func MAKE_EQUAL_WIDTH(_ views: UIView ...) -> [NSLayoutConstraint] {
    var cones = [NSLayoutConstraint]()
    var first: UIView? = nil
    for v in views {
        if let fv = first {
            cones.append(v.WIDTH.EQUAL(fv).MAKE())
            first = v
        } else {
            first = v
        }
    }
    return cones
}

@discardableResult public func MAKE_EQUAL_HEIGHT(_ views: UIView ...) -> [NSLayoutConstraint] {
    var cones = [NSLayoutConstraint]()
    var first: UIView? = nil
    for v in views {
        if let fv = first {
            cones.append(v.HEIGHT.EQUAL(fv).MAKE())
            first = v
        } else {
            first = v
        }
    }
    return cones
}

@discardableResult public func MAKE_EQUAL_SIZE(_ views: UIView ...) -> [NSLayoutConstraint] {
    var cones = [NSLayoutConstraint]()
    var first: UIView? = nil
    for v in views {
        if let fv = first {
            cones.append(v.WIDTH.EQUAL(fv).MAKE())
            cones.append(v.HEIGHT.EQUAL(fv).MAKE())
            first = v
        } else {
            first = v
        }
    }
    return cones
}

extension UIView {
    
    func IN(_ V: UIView) -> QXConsesMaker        { return QXConsesMaker.updateMaker(view: self, containerView: V, isIn: true, possition: nil) }
    
    func TOP(_ V: UIView) -> QXConsesMaker       { return QXConsesMaker.updateMaker(view: self, containerView: V, isIn: false, possition: .top) }

    func LEFT(_ V: UIView) -> QXConsesMaker      { return QXConsesMaker.updateMaker(view: self, containerView: V, isIn: false, possition: .left) }
    
    func BOTTOM(_ V: UIView) -> QXConsesMaker    { return QXConsesMaker.updateMaker(view: self, containerView: V, isIn: false, possition: .bottom) }
    
    func RIGHT(_ V: UIView) -> QXConsesMaker     { return QXConsesMaker.updateMaker(view: self, containerView: V, isIn: false, possition: .right) }
    
    @discardableResult  func MAKE(W w: CGFloat, H h: CGFloat) -> [NSLayoutConstraint] {
        let cons1 = self.WIDTH.EQUAL(w).MAKE()
        let cons2 = self.HEIGHT.EQUAL(h).MAKE()
        return [cons1, cons2]
    }
    
}

extension QXConsesMaker {
    
    func SIZE(_ W: CGFloat, _ H: CGFloat) -> QXConsesMaker { return WIDTH(W).HEIGHT(H) }
    
    func TOP(_ T: CGFloat) -> QXConsesMaker       { return QXConsesMaker.updateMaker(top: T) }
    func LEFT(_ L: CGFloat) -> QXConsesMaker      { return QXConsesMaker.updateMaker(left: L) }
    func BOTTOM(_ B: CGFloat) -> QXConsesMaker    { return QXConsesMaker.updateMaker(bottom: B) }
    func RIGHT(_ R: CGFloat) -> QXConsesMaker     { return QXConsesMaker.updateMaker(right: R) }
    func WIDTH(_ W: CGFloat) -> QXConsesMaker     { return QXConsesMaker.updateMaker(width: W) }
    func HEIGHT(_ H: CGFloat) -> QXConsesMaker    { return QXConsesMaker.updateMaker(height: H) }
    
    func OFFSET(_ O: CGFloat) -> QXConsesMaker    { return QXConsesMaker.updateMaker(offset: O) }

    var CENTER: QXConsesMaker                   { return QXConsesMaker.updateMaker(center: true) }
    var CENTER_X: QXConsesMaker                 { return QXConsesMaker.updateMaker(centerX: true) }
    var CENTER_Y: QXConsesMaker                 { return QXConsesMaker.updateMaker(centerY: true) }

    var LEFT: QXConsesMaker                     { return LEFT(0) }
    var RIGHT: QXConsesMaker                    { return RIGHT(0) }
    var TOP: QXConsesMaker                      { return TOP(0) }
    var BOTTOM: QXConsesMaker                   { return BOTTOM(0) }
    
    @discardableResult func MAKE() -> [NSLayoutConstraint]         { return QXConsesMaker.makeUpConstraints() }

}

enum QXConsesPossion {
    case top
    case left
    case bottom
    case right
}

struct QXConsesMaker {
    
    fileprivate var isIn: Bool = true
    fileprivate var view: UIView?
    fileprivate var containerView: UIView?
    
    fileprivate var topMargin: CGFloat?
    fileprivate var leftMargin: CGFloat?
    fileprivate var bottomMargin: CGFloat?
    fileprivate var rightMargin: CGFloat?

    fileprivate var offset: CGFloat?

    fileprivate var width: CGFloat?
    fileprivate var height: CGFloat?
    
    fileprivate var possition: QXConsesPossion?
    fileprivate var centerX: Bool = false
    fileprivate var centerY: Bool = false
    fileprivate var center: Bool = false

    fileprivate static var maker = QXConsesMaker()
    
    static func updateMaker(view v: UIView, containerView cv: UIView, isIn i: Bool, possition p: QXConsesPossion?) -> QXConsesMaker {
        self.maker.isIn = i
        self.maker.view = v
        self.maker.containerView = cv
        self.maker.possition = p
        if let ps = p {
            switch ps {
            case .top: self.maker.topMargin = 0
            case .left: self.maker.leftMargin = 0
            case .bottom: self.maker.bottomMargin = 0
            case .right: self.maker.rightMargin = 0
            }
        }
        if i == false {
            _ = self.updateMaker(offset: 0)
        }
        return self.maker
    }
    
    static func updateMaker(left l: CGFloat) -> QXConsesMaker {
        self.maker.leftMargin = QXConsesMaker.maker.isIn ? l : -l
        return self.maker
    }
    
    static func updateMaker(right r: CGFloat) -> QXConsesMaker {
        self.maker.rightMargin = QXConsesMaker.maker.isIn ? -r : r
        return self.maker
    }
    
    static func updateMaker(top t: CGFloat) -> QXConsesMaker {
        self.maker.topMargin = QXConsesMaker.maker.isIn ? t : -t
        return self.maker
    }
    
    static func updateMaker(bottom b: CGFloat) -> QXConsesMaker {
        self.maker.bottomMargin = QXConsesMaker.maker.isIn ? -b : b
        return self.maker
    }
    
    static func updateMaker(offset o: CGFloat) -> QXConsesMaker {
        self.maker.offset = o
        return self.maker
    }
    
    static func updateMaker(width w: CGFloat) -> QXConsesMaker {
        self.maker.width = w
        return self.maker
    }
    
    static func updateMaker(height h: CGFloat) -> QXConsesMaker {
        self.maker.height = h
        return self.maker
    }
    
    static func updateMaker(centerX x: Bool) -> QXConsesMaker {
        self.maker.centerX = x
        return self.maker
    }
    
    static func updateMaker(centerY y: Bool) -> QXConsesMaker {
        self.maker.centerY = y
        return self.maker
    }
    
    static func updateMaker(center c: Bool) -> QXConsesMaker {
        self.maker.center = c
        return self.maker
    }
    
    static func makeUpConstraints() -> [NSLayoutConstraint] {
        
        let view = QXConsesMaker.maker.view!
        let containerView = QXConsesMaker.maker.containerView!
        
        var conses = [NSLayoutConstraint]()
        
        if let offset = QXConsesMaker.maker.offset {
            
            if let pos = QXConsesMaker.maker.possition {
                switch pos {
                case .top:
                    QXConsesMaker.maker.topMargin = nil
                case .left:
                    QXConsesMaker.maker.leftMargin = nil
                case .bottom:
                    QXConsesMaker.maker.bottomMargin = nil
                case .right:
                    QXConsesMaker.maker.rightMargin = nil
                }
            }
            
            if QXConsesMaker.maker.isIn {
                if let pos = QXConsesMaker.maker.possition {
                    switch pos {
                    case .top:
                        conses.append(view.TOP.EQUAL(containerView).OFFSET(offset).MAKE())
                    case .left:
                        conses.append(view.LEFT.EQUAL(containerView).OFFSET(offset).MAKE())
                    case .bottom:
                        conses.append(view.BOTTOM.EQUAL(containerView).OFFSET(-offset).MAKE())
                    case .right:
                        conses.append(view.RIGHT.EQUAL(containerView).OFFSET(-offset).MAKE())
                    }
                }
            } else {
                if let pos = QXConsesMaker.maker.possition {
                    switch pos {
                    case .top:
                        conses.append(view.BOTTOM.EQUAL(containerView).TOP.OFFSET(-offset).MAKE())
                    case .left:
                        conses.append(view.RIGHT.EQUAL(containerView).LEFT.OFFSET(-offset).MAKE())
                    case .bottom:
                        conses.append(view.TOP.EQUAL(containerView).BOTTOM.OFFSET(offset).MAKE())
                    case .right:
                        conses.append(view.LEFT.EQUAL(containerView).RIGHT.OFFSET(offset).MAKE())
                    }
                }
            }
        }
        
        if let width = QXConsesMaker.maker.width {
            conses.append(view.WIDTH.EQUAL(width).MAKE())
        }
        if let height = QXConsesMaker.maker.height {
            conses.append(view.HEIGHT.EQUAL(height).MAKE())
        }
        
        if let topMargin = QXConsesMaker.maker.topMargin {
            conses.append(view.TOP.EQUAL(containerView).OFFSET(topMargin).MAKE())
        }
        if let leftMargin = QXConsesMaker.maker.leftMargin {
            conses.append(view.LEFT.EQUAL(containerView).OFFSET(leftMargin).MAKE())
        }
        if let bottomMargin = QXConsesMaker.maker.bottomMargin {
            conses.append(view.BOTTOM.EQUAL(containerView).OFFSET(bottomMargin).MAKE())
        }
        if let rightMargin = QXConsesMaker.maker.rightMargin {
            conses.append(view.RIGHT.EQUAL(containerView).OFFSET(rightMargin).MAKE())
        }
        
        if QXConsesMaker.maker.centerX {
            conses.append(view.CENTER_X.EQUAL(containerView).MAKE())
        }
        
        if QXConsesMaker.maker.centerY {
            conses.append(view.CENTER_Y.EQUAL(containerView).MAKE())
        }
        
        if QXConsesMaker.maker.center {
            if let pos = QXConsesMaker.maker.possition {
                switch pos {
                case .bottom, .top:
                    conses.append(view.CENTER_X.EQUAL(containerView).MAKE())
                case .left, .right:
                    conses.append(view.CENTER_Y.EQUAL(containerView).MAKE())
                }
            } else {
                if QXConsesMaker.maker.leftMargin != nil || QXConsesMaker.maker.rightMargin != nil {
                    conses.append(view.CENTER_Y.EQUAL(containerView).MAKE())
                } else if QXConsesMaker.maker.topMargin != nil || QXConsesMaker.maker.bottomMargin != nil {
                    conses.append(view.CENTER_X.EQUAL(containerView).MAKE())
                } else {
                    conses.append(view.CENTER_X.EQUAL(containerView).MAKE())
                    conses.append(view.CENTER_Y.EQUAL(containerView).MAKE())
                }
            }
        }
        
        QXConsesMaker.maker = QXConsesMaker()
        
        return conses
        
    }

}
