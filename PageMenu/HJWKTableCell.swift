//
//  HJWKTableCell.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/9.
//  Copyright © 2018年 Mr.H. All rights reserved.
//
import UIKit
import WebKit

class HJWKTableCell: UITableViewCell {
    
    var wKwebView: WKWebView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    func creatUI() {
        
        self.addSubview(self.wKwebView)
        
        self.wKwebView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraint = NSLayoutConstraint(item: self.wKwebView,
                                                attribute: NSLayoutAttribute.left,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: self,
                                                attribute:NSLayoutAttribute.left,
                                                multiplier: 1.0, constant: 0)
        
        
        let rightConstraint = NSLayoutConstraint(item: self.wKwebView,
                                                 attribute: NSLayoutAttribute.right,
                                                 relatedBy: NSLayoutRelation.equal,
                                                 toItem: self,
                                                 attribute:NSLayoutAttribute.right,
                                                 multiplier: 1.0, constant: 0)
        
        
        
        let topConstraint = NSLayoutConstraint(item: self.wKwebView,
                                               attribute: NSLayoutAttribute.top,
                                               relatedBy: NSLayoutRelation.equal,
                                               toItem: self,
                                               attribute:NSLayoutAttribute.top,
                                               multiplier: 1.0, constant: 0)
        
        
        let downConstraint = NSLayoutConstraint(item: self.wKwebView,
                                                attribute: NSLayoutAttribute.bottom,
                                                relatedBy: NSLayoutRelation.equal,
                                                toItem: self,
                                                attribute:NSLayoutAttribute.bottom,
                                                multiplier: 1.0, constant: 0)
        
        
        self.addConstraints([leftConstraint, rightConstraint, topConstraint,downConstraint])
        
    }
    
    func setUrl(webView:WKWebView) {
        
        self.wKwebView = webView
        
        self.creatUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
