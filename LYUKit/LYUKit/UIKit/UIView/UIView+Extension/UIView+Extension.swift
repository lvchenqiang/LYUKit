//
//  UIView+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/8.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


// MARK: Custom UIView Initilizers
extension UIView {
    /// convenience contructor to define a view based on width, height and base coordinates.
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
    
    ///  puts padding around the view
    public convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.LYU_X + padding, y: superView.LYU_Y + padding, width: superView.LYU_W - padding*2, height: superView.LYU_H - padding*2))
    }
    
    ///  Copies size of superview
    public convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.size))
    }
}

// MARK: Frame Extensions
extension UIView {
    
    /// EZSE: add multiple subviews
    public func addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    
    //TODO: Add pics to readme
    /// EZSE: resizes this view so it fits the largest subview
    public func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.LYU_X + aView.LYU_W
            let newHeight = aView.LYU_Y + aView.LYU_H
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: LYU_X, y: LYU_Y, width: width, height: height)
    }
    
    /// resizes this view so it fits the largest subview
    public func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.LYU_X + aView.LYU_W
                let newHeight = aView.LYU_Y + aView.LYU_H
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: LYU_X, y: LYU_Y, width: width, height: height)
    }
    
    ///  resizes this view so as to fit its width.
    public func resizeToFitWidth() {
        let currentHeight = self.LYU_H
        self.sizeToFit()
        self.LYU_H = currentHeight
    }
    
    ///  resizes this view so as to fit its height.
    public func resizeToFitHeight() {
        let currentWidth = self.LYU_W
        self.sizeToFit()
        self.LYU_W = currentWidth
    }
    
    /// getter and setter for the x coordinate of the frame's origin for the view.
    public var LYU_X: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame = CGRect(x: value, y: self.LYU_Y, width: self.LYU_W, height: self.LYU_H)
        }
    }
    
    ///  getter and setter for the y coordinate of the frame's origin for the view.
    public var LYU_Y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame = CGRect(x: self.LYU_X, y: value, width: self.LYU_W, height: self.LYU_H)
        }
    }
    
    /// variable to get the width of the view.
    public var LYU_W: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.LYU_X, y: self.LYU_Y, width: value, height: self.LYU_H)
        }
    }
    
    ///  variable to get the height of the view.
    public var LYU_H: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.LYU_X, y: self.LYU_Y, width: self.LYU_W, height: value)
        }
    }
    
    ///  getter and setter for the x coordinate of leftmost edge of the view.
    public var LYU_Left: CGFloat {
        get {
            return self.LYU_X
        } set(value) {
            self.LYU_X = value
        }
    }
    
    /// getter and setter for the x coordinate of the rightmost edge of the view.
    public var LYU_Right: CGFloat {
        get {
            return self.LYU_X + self.LYU_W
        } set(value) {
            self.LYU_X = value - self.LYU_W
        }
    }
    
    /// getter and setter for the y coordinate for the topmost edge of the view.
    public var LYU_Top: CGFloat {
        get {
            return self.LYU_Y
        } set(value) {
            self.LYU_Y = value
        }
    }
    
    /// getter and setter for the y coordinate of the bottom most edge of the view.
    public var LYU_Bottom: CGFloat {
        get {
            return self.LYU_Y + self.LYU_H
        } set(value) {
            self.LYU_Y = value - self.LYU_H
        }
    }
    
    /// getter and setter the frame's origin point of the view.
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }
    
    /// getter and setter for the X coordinate of the center of a view.
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    /// getter and setter for the Y coordinate for the center of a view.
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    ///  getter and setter for frame size for the view.
    public var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame = CGRect(origin: self.frame.origin, size: value)
        }
    }
    
    /// getter for an leftwards offset position from the leftmost edge.
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.LYU_Left - offset
    }
    
    /// getter for an rightwards offset position from the rightmost edge.
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.LYU_Right + offset
    }
    
    ///  aligns the view to the top by a given offset.
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.LYU_Top - offset
    }
    
    /// align the view to the bottom by a given offset.
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.LYU_Bottom + offset
    }
    
    //TODO: Add to readme
    ///  align the view widthwise to the right by a given offset.
    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.LYU_W - offset
    }
    
    ///
    public func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
    
    
    /// Centers view in superview horizontally
    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("SwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.LYU_X = parentView.LYU_W/2 - self.LYU_W/2
    }
    
    /// Centers view in superview vertically
    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("SwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }
        
        self.LYU_Y = parentView.LYU_H/2 - self.LYU_H/2
    }
    
    ///  Centers view in superview horizontally & vertically
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
}

// MARK: Transform Extensions
extension UIView {
    /// SwiftExtensions
    public func setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        self.layer.transform = transform
    }
    
    /// SwiftExtensions
    public func setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }
    
    /// SwiftExtensions
    public func setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    
    /// SwiftExtensions
    public func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    
    /// SwiftExtensions
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

// MARK: Layer Extensions
extension UIView {
    /// SwiftExtensions
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    //TODO: add this to readme
    /// SwiftExtensions
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    /// SwiftExtensions
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }
    
    ///
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    
    //TODO: add to readme
    
    public func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }
    
    ///
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    
    ///
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    
    ///
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }
    
    ///
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    //TODO: add this to readme
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.LYU_W, height: self.LYU_W), cornerRadius: self.LYU_W/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    //TODO: add this to readme
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.LYU_W, height: self.LYU_W), cornerRadius: self.LYU_W/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}


//TODO: add this to readme
// MARK: Animation Extensions
extension UIView {
    
}

//TODO: add this to readme
// MARK: Render Extensions
extension UIView {
    /// SwiftExtensions
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


//TODO: add to readme
extension UIView {
    ///  [UIRectCorner.TopLeft, UIRectCorner.TopRight]
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    /// Mask square/rectangle UIView with a circular/capsule cover, with a border of desired color and width around it
    public func roundView(withBorderColor color: UIColor? = nil, withBorderWidth width: CGFloat? = nil) {
        self.setCornerRadius(radius: min(self.frame.size.height, self.frame.size.width) / 2)
        self.layer.borderWidth = width ?? 0
        self.layer.borderColor = color?.cgColor ?? UIColor.clear.cgColor
    }
    
    /// Remove all masking around UIView
    public func nakedView() {
        self.layer.mask = nil
        self.layer.borderWidth = 0
    }
}

extension UIView {
    ///Shakes the view for as many number of times as given in the argument.
    public func shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100
        
        self.layer.add(anim, forKey: nil)
    }
}

extension UIView {
    /// Loops until it finds the top root view. //TODO: Add to readme
    func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
}

// MARK: Fade Extensions

private let UIViewDefaultFadeDuration: TimeInterval = 0.4

extension UIView {
    /// Fade in with duration, delay and completion block.
    public func fadeIn(_ duration: TimeInterval? = 0.4, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        fadeTo(1.0, duration: duration, delay: delay, completion: completion)
    }
    
    ///
    public func fadeOut(_ duration: TimeInterval? = 0.4, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        fadeTo(0.0, duration: duration, delay: delay, completion: completion)
    }
    
    /// Fade to specific value     with duration, delay and completion block.
    public func fadeTo(_ value: CGFloat, duration: TimeInterval? = 0.4, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: delay ?? UIViewDefaultFadeDuration, options: .curveEaseInOut, animations: {
            self.alpha = value
        }, completion: completion)
    }
}

