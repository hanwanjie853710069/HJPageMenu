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
    
    var isNeedReload: Bool = true
    
    lazy var wKwebView: WKWebView = {
        
        let webView = WKWebView()
        
        webView.scrollView.isScrollEnabled = false
        
        webView.load(URLRequest.init(url: URL.init(string: "https://mp.weixin.qq.com/s/XKisIHQtSZ8JN9WbDmfj2w")!))
        
//        let filePath = Bundle.main.url(forResource: "showNew2", withExtension: "html")
//
//        webView.loadFileURL(filePath!, allowingReadAccessTo: Bundle.main.bundleURL)
        
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
    
    func cellHeight(height: CGFloat) {
        
        self.isNeedReload = false
        
        self.cellHeight = height
        
        self.tableView.reloadData()
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.body.offsetHeight") { (any, error) in
            
            print(error ?? "没有错误")
            
            print(any ?? "没有值")
            
            guard let temp = any else { return }
            
            guard let height = temp as? CGFloat else { return }
            
            self.cellHeight = height
            
            self.tableView.reloadData()
            
        }
        
    }
    
}
