//
//  HJMenuView.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit

protocol HJMenuViewDelegate:class {
    
    func touchMenuBtn(tag: Int)
    
}

class HJMenuView: UIView {

   weak var delegate : HJMenuViewDelegate?
    
    var line: UILabel = {
        
        let label = UILabel()
        
        label.backgroundColor = UIColor.init(hexString: "FF525F")
        
        return label
        
    }()
    
    /// 设置菜单标题数组
    var arrayS :[String]? {
        
        willSet {
            
            guard let value = newValue else { return }
            
            self.setTitleArray(array: value)
            
        }
        
    }
    
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
    
    
    private func setTitleArray(array:[String]) {
        
        let menuWidth = SCWidth / CGFloat(array.count)
        
        
        for (index,element) in array.enumerated() {
            
            let btn = UIButton()
            
            btn.tag = 100 + index
            
            btn.frame = CGRect(x: (menuWidth * CGFloat(index)),
                               y: 0,
                               width: menuWidth,
                               height: menuHeight)
         
           btn.setTitle(element, for: .normal)
            
            if (index == 0) {
                
                btn.setTitleColor(UIColor.init(hexString: "FF525F"), for: .normal)
                
            }else {
 
                btn.setTitleColor(UIColor.init(hexString: "999999"), for: .normal)
            
            }
            
            btn.addTarget(self, action: #selector(self.touchBtn(btn:)), for: .touchUpInside)
            
            self.addSubview(btn)
            
        }
        
        let topLine = UILabel(frame: CGRect(x: 0, y: 0, width: SCWidth, height: 1))
        
        topLine.backgroundColor = UIColor.init(hexString: "F5F5F5")
        
        self.addSubview(topLine)
        
        let bottomLine = UILabel(frame: CGRect(x: 0, y: 43, width: SCWidth, height: 1))

        bottomLine.backgroundColor = UIColor.init(hexString: "F5F5F5")
        
        self.addSubview(bottomLine)
        
        self.line.frame = CGRect(x: 0, y: 42, width: menuWidth, height: 2)
        
        self.addSubview(self.line)
        
    }
    
    @objc func touchBtn(btn:UIButton) {
        
        let tag = btn.tag - 100
        
        self.setScrollIndex(tag: tag)
        
        self.delegate?.touchMenuBtn(tag: tag)
    }
    
    func setScrollIndex(tag: Int) {
        
        let x = SCWidth / CGFloat(self.arrayS!.count) * CGFloat(tag)
        
        UIView.animate(withDuration: 0.2) {
            
            self.line.frame.origin.x = x
            
        }
        
        for (index,_) in self.arrayS!.enumerated() {
            
            let temptag = index + 100
            
            let btnTemp:UIButton = self.viewWithTag(temptag) as! UIButton
            
            if (index == tag) {
                
                btnTemp.setTitleColor(UIColor.init(hexString: "FF525F"), for: .normal)
                
            }else {
                
                btnTemp.setTitleColor(UIColor.init(hexString: "999999"), for: .normal)
                
            }
            
        }
        
    }
    
    convenience required init?(coder aDecoder: NSCoder) { self.init() }
    
}
