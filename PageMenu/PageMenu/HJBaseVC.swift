//
//  HJBaseVC.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit

protocol HJBaseVCDelegate: class {
    
    func scrollContentOffset(scrollView: UIScrollView)
    
}

open class HJBaseVC:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {
    
   weak var delegate : HJBaseVCDelegate?
    
    /// 滚动视图
    open lazy var tableView: UITableView = {
        
        let tableV = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCWidth, height: SCHeight))
        
        tableV.delegate = self;
        
        tableV.dataSource = self;
        
        tableV.layoutMargins = .zero
        
        tableV.backgroundColor = UIColor.white
        
        return tableV
        
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        if #available(iOS 11.0, *) {
            
            self.tableView.contentInsetAdjustmentBehavior = .never;
            
        }else {
        
            self.automaticallyAdjustsScrollViewInsets = false
        
        }
        
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(indexPath.row)"

        cell.backgroundColor = UIColor.brown
        
        return cell
        
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.delegate?.scrollContentOffset(scrollView: scrollView)
    
    }
    
}
