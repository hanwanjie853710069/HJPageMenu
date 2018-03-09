//
//  HJMenuHeadView.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit

class HJMenuHeadView: UIView {

    init() {
        
        super.init(frame: CGRect.zero)
        
        self.viewDidLoad()
        
        self.updateView()
        
    }
    
    func viewDidLoad() {
        
        self.backgroundColor = UIColor.white
        
    }
    
    func updateView() {
        
        
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let view = super.hitTest(point, with: event)
        
        guard let tempView = view else { return nil}
        
        if tempView.isKind(of: UIButton.classForCoder()) {
            
         
            return tempView
            
        }
        
        return nil
        
    }
    
    convenience required init?(coder aDecoder: NSCoder) { self.init() }
    
}
