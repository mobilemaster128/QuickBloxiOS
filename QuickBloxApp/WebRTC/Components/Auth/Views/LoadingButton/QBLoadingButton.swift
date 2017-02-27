//
//  QBLoadingButton.swift
//  QuickBloxApp
//
//  Created by Sierra on 2/27/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit

class QBLoadingButton: UIButton {
    
    var shapeLayer: CAShapeLayer? {
        return self.layer as? CAShapeLayer
    }
    var activity: UIActivityIndicatorView?
    var currentText: String?
    
    override class var layerClass: AnyClass {
        get {
            return CAShapeLayer.self
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled
            if isEnabled {
                self.shapeLayer?.fillColor = UIColor(red: 0.0392, green: 0.3765, blue: 1.0, alpha: 1.0).cgColor
            }
            else {
                self.shapeLayer?.fillColor = UIColor.gray.cgColor
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.shapeLayer?.fillColor = UIColor(red: 0.0392, green: 0.3765, blue: 1.0, alpha: 1.0).cgColor
        self.shapeLayer?.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
    }
    
    func showLoading() {
        if self.activity != nil {
            return
        }
        
        let animation = CABasicAnimation(keyPath: "path")
        
        animation.fromValue = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
        
        animation.repeatCount = 1
        animation.duration = 0.15
        
        let r = min(self.frame.size.width, self.frame.size.height)
        animation.toValue = UIBezierPath(roundedRect: CGRect(x: self.frame.size.width/2 - r/2, y: 0, width: r, height: r), cornerRadius: r).cgPath
        
        self.shapeLayer?.add(animation, forKey: "shapeAnimation")
        
        self.shapeLayer?.path = UIBezierPath(roundedRect: CGRect(x: self.frame.size.width/2 - r/2, y: 0, width: r, height: r), cornerRadius: r).cgPath
        
        self.showAtivityIndicator()
        self.currentText = self.currentTitle
        self.setTitle("", for: UIControlState.normal)
        
        let fromColor = UIColor(red: 0.0392, green: 0.3865, blue: 1.0, alpha: 1.0)
        let toColor = UIColor(red: 0.0802, green: 0.616, blue: 0.1214, alpha: 1.0)
        
        let colorAnimation = CABasicAnimation(keyPath: "fillColor")
        colorAnimation.fromValue = fromColor.cgColor
        colorAnimation.toValue = toColor.cgColor
        colorAnimation.repeatCount = Float(NSIntegerMax)
        colorAnimation.duration = 1.0
        colorAnimation.autoreverses = true
        
        self.shapeLayer?.add(colorAnimation, forKey: "color")
    }
    
    func hideLoading() {
        if self.activity == nil {
            return
        }
        
        self.shapeLayer?.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5).cgPath
        self.shapeLayer?.fillColor = UIColor(red: 0.0392, green: 0.3765, blue: 1.0, alpha: 1.0).cgColor
        
        self.hideActivityIndicator()
        self.setTitle(self.currentText, for: UIControlState.normal)
        self.currentText = nil
    }
    
    func showAtivityIndicator() {
        if self.activity == nil {
            self.isUserInteractionEnabled = false
            self.activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            self.activity?.isHidden = false
            self.activity?.startAnimating()
            self.activity?.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
            self.addSubview(self.activity!)
        }
    }
    
    func hideActivityIndicator() {
        self.isUserInteractionEnabled = true
        self.shapeLayer?.removeAllAnimations()
        self.activity?.removeFromSuperview()
        self.activity = nil
    }
}
