//
//  HJWKTableCell.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/9.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit
import WebKit

protocol HJWKTableCellDelegate {
    
    func cellHeight(height: CGFloat)
    
}

class HJWKTableCell: UITableViewCell {

    var delegate:HJWKTableCellDelegate?
    
    var wKwebView: WKWebView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
     
        
    }
    
    func creatUI() {
        
       
        
       self.addSubview(self.wKwebView)
        
        // 禁止将 AutoresizingMask 转换为 Constraints
        
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
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.body.offsetHeight") { (any, error) in
    
            print(error ?? "没有错误")
            
            print(any ?? "没有值")
            
            guard let temp = any else { return }
            
            guard let height = temp as? CGFloat else { return }
            
            self.delegate?.cellHeight(height: height)
            
        }
        
    }
    
    func setUrl(webView:WKWebView) {
        
        self.wKwebView = webView
        
        self.creatUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
