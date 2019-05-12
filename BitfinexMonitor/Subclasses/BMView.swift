//
//  BMView.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import UIKit

@IBDesignable
class BMView: UIView {
    
    @IBInspectable var borderColor : UIColor = UIColor.clear
    @IBInspectable var borderWidth : CGFloat = 0
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowColor : UIColor = UIColor.clear
    @IBInspectable var shadowOpacity : Float = 0
    @IBInspectable var shadowOffset : CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowRadius : CGFloat = 0
    
    init() {
        super.init(frame: CGRect.zero)
        addTapGestureRecognizer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTapGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.customize()
        addTapGestureRecognizer()
    }
    
    override func prepareForInterfaceBuilder() {
        customize()
    }
    
    func customize(){
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        self.layer.cornerRadius = self.cornerRadius
        self.layer.shadowColor = self.shadowColor.cgColor
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowOffset = self.shadowOffset
        self.layer.shadowRadius = self.shadowRadius
    }
    
    func addTapGestureRecognizer(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: Action Closure
    private var action: (() -> Void)?
    
    func touchUpInside(action: (() -> Void)? = nil){
        self.action = action
    }
    
    @objc func viewTapped(sender: BMView? = nil) {
        self.action?()
    }
    
}
