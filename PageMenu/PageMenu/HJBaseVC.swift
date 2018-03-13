//
//  HJBaseVC.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit

protocol HJBaseVCDelegate {
    
    func scrollContentOffset(scrollView: UIScrollView)
    
}

public class HJBaseVC:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {
    
    var delegate : HJBaseVCDelegate?
    
    /// 滚动视图
    public lazy var tableView: UITableView = {
        
        let tableV = UITableView.init(frame: CGRect(x: 0, y: 0, width: SCWidth, height: SCHeight))
        
        tableV.delegate = self;
        
        tableV.dataSource = self;
        
        tableV.layoutMargins = .zero
        
        tableV.backgroundColor = UIColor.red
        
        return tableV
        
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        if #available(iOS 11.0, *) {
            
            self.tableView.contentInsetAdjustmentBehavior = .never;
            
        }else {
        
            self.automaticallyAdjustsScrollViewInsets = false
        
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "\(indexPath.row)"

        cell.backgroundColor = UIColor.brown
        
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.delegate?.scrollContentOffset(scrollView: scrollView)
        
    }
    
}
