//
//  ViewController.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self;
        
        self.view.backgroundColor = UIColor.green;
        
        let pages:[HJBaseVC] = [HJCaseVC(),HJCaseVC(),HJCaseVC()]
        
        let titles = ["你好","你好世界","世界"]
        
        let vc = HJPageMenuVC();
        
        vc.setPageMenu(headHeight: 200,
                       headView: self.getHeadView(),
                       navView:self.getNavView(),
                       vcs: pages,
                       vcTiltes: titles,
                       animationType: .Type_None)
        
        self.addChildViewController(vc)
        
        self.view.addSubview(vc.view)
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let isShow = viewController.isKind(of: self.classForCoder)
        
        self.navigationController?.setNavigationBarHidden(isShow, animated: true)
        
    }
    
    func getHeadView() -> UIView {
        
        let headView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCWidth, height: 200))
        
        headView.image = UIImage.init(named: "HJPageMenuBundle.bundle/imageview.jpg")
        
        return headView
        
    }
    
    func getNavView() -> UIView {
        
        let navV = UIView.init(frame: CGRect(x: 0,
                                             y: 0,
                                             width:
            SCWidth, height: statusBarAndNavigationBarHeight))
        
        navV.backgroundColor = UIColor.green.withAlphaComponent(0);
        
        return navV
        
    }
    
    
}

