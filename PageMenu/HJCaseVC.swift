//
//  HJCaseVC.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit
import WebKit

class HJCaseVC: HJBaseVC, WKNavigationDelegate{
    
    var cellHeight: CGFloat = 0
    
    lazy var wKwebView: WKWebView = {
        
        let webView = WKWebView()
        
        webView.scrollView.isScrollEnabled = false
        
        webView.load(URLRequest.init(url: URL.init(string: "http://mp.weixin.qq.com/s?__biz=MzUxMjA3MzgyNw==&mid=2247487539&idx=1&sn=95b779aacdba1d4afbd3af50aba89b9b&chksm=f96b593fce1cd029e703154dad9eeabb7fd8db3d8983cfc32b1e7b7062dcb0cc9bb8e9c65009&mpshare=1&scene=23&srcid=0310Xnrz4nWYygRhySc3UTat#rd")!))
        
        return webView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wKwebView.navigationDelegate = self
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HJWKTableCell(style: .default, reuseIdentifier: "Cell")
        
        cell.setUrl(webView: self.wKwebView)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.cellHeight
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.body.offsetHeight") { (any, error) in
            
            guard let temp = any else { return }
            
            guard let height = temp as? CGFloat else { return }
            
            self.cellHeight = height
            
            self.tableView.reloadData()
            
        }
        
    }
    
}

