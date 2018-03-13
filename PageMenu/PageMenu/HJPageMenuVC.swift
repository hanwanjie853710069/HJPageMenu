//
//  HJPageMenuVC.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit

public class HJPageMenuVC:
    UIViewController,
    HJBaseVCDelegate,
    HJMenuViewDelegate,
UIScrollViewDelegate{
    
    /// 视图控制器数组
    private var arrayVC :[HJBaseVC]? {
        
        willSet {
            
            guard let value = newValue else { return }
            
            self.setVC(arrays: value)
            
        }
        
    }
    
    /// 视图控制器名字数组
    private var arrayTitles :[String]? {
        
        willSet {
            
            guard let value = newValue else { return }
            
            self.menuView.arrayS = value
            
        }
        
    }
    
    /// 底部滚动视图
    private var bottomScrollView: UIScrollView = {
        
        let frame = CGRect(x: 0, y: 0, width: SCWidth, height: SCHeight)
        
        let scrollView = UIScrollView(frame: frame)
        
        scrollView.isPagingEnabled = true
        
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.bounces = false
        
        scrollView.isScrollEnabled = true
        
        scrollView.backgroundColor = UIColor.purple
        
        return scrollView
        
    }()
    
    /// 头部高度
    private var headHeight:CGFloat? {
        
        willSet {
            
            guard let value = newValue else { return }
            
            self.setEdgeInsetHeight(height: value)
            
        }
        
    }
    
    /// 外部传入的头视图
    private var headView:UIView? {
        
        willSet {
            
            guard let value = newValue else { return }
            
            self.setHeadView(view: value)
            
        }
        
    }
    
    /// 底部的头视图
    private lazy var headBottomView:HJMenuHeadView = {
        
        let headV = HJMenuHeadView()
        
        headV.addSubview(self.menuView)
        
        return headV
        
    }()
    
    /// 导航栏
    private var navView:UIView? {
        
        willSet{
            
           guard let value = newValue else { return }
            
            self.view.addSubview(value)
            
        }
        
    }
    
    /// 菜单
    private lazy var menuView: HJMenuView = {
        
        let mView = HJMenuView()
        
        return mView;
        
    }()
    
    private var animationType: animationType = .Type_None
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.bottomScrollView)
        
        self.bottomScrollView.delegate = self
        
        self.menuView.delegate = self
        
        self.edgesForExtendedLayout = .init(rawValue: 0)
        
        if #available(iOS 11.0, *) {
            
            self.bottomScrollView.contentInsetAdjustmentBehavior = .never;
            
        }else {
            
            self.automaticallyAdjustsScrollViewInsets = false
            
        }
        
    }
    
    private func setHeadView(view:UIView) {
        
        self.headBottomView.addSubview(view)
        
    }
    
    private func setVC(arrays:[HJBaseVC]) {
        
        let size = CGSize(width: CGFloat(arrays.count) * SCWidth, height: 0)
        
        self.bottomScrollView.contentSize = size
        
        for (index, vc) in arrays.enumerated() {
            
            vc.delegate = self;
            
            vc.view.frame = CGRect(x:(CGFloat(index) * SCWidth), y: 0, width: SCWidth, height: SCHeight)
            
            self.addChildViewController(vc)
            
            self.bottomScrollView.addSubview(vc.view)
            
            if (self.headHeight != nil) {
                
                let height = (self.headHeight ?? 0) + menuHeight
                
                let edgeIn = UIEdgeInsetsMake(height, 0.0, 0.0, 0.0)
                
                vc.tableView.scrollIndicatorInsets = edgeIn
                
                vc.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: height))
                
            }
            
        }
        
        self.headBottomView.removeFromSuperview()
        
        self.view.addSubview(self.headBottomView)
        
    }
    
    private func setEdgeInsetHeight(height: CGFloat) {
        
        let frame = CGRect(x: 0, y: 0, width: SCWidth, height: height + menuHeight)
        
        self.headBottomView.frame = frame
        
        self.menuView.frame = CGRect(x: 0, y: height, width: SCWidth, height: menuHeight)
        
        guard let arrays = self.arrayVC else { return }
        
        for vc in arrays {
            
            let edgeIn = UIEdgeInsetsMake(height + menuHeight, 0.0, 0.0, 0.0)
            
            vc.tableView.scrollIndicatorInsets = edgeIn
            
            vc.tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: height))
            
        }
        
        self.headBottomView.removeFromSuperview()
        
        self.view.addSubview(self.headBottomView)
        
    }
    
    internal func scrollContentOffset(scrollView: UIScrollView) {
        
        guard let arrays = self.arrayVC else { return }
        
        let contentOffset = scrollView.contentOffset
        
        let index = contentOffset.y
        
        let offsetY = self.headHeight! - statusBarAndNavigationBarHeight
        
        print(scrollView.contentOffset.y + (self.headHeight ?? 0));
        
        for (_,element) in arrays.enumerated() {
            
            if scrollView.isEqual(element.tableView) {
                
            }else {
                
                if (index >= offsetY) {
                    
                    if (element.tableView.contentOffset.y >= offsetY) {
                        
                        
                    }else {
                        
                        element.tableView.contentOffset = CGPoint(x: 0, y: offsetY)
                        
                    }
                    
                }else {
                    
                    element.tableView.contentOffset = CGPoint(x: 0, y: index)
                    
                }
                
            }
            
        }
        
        if (index > (self.headHeight! - statusBarAndNavigationBarHeight)) {
            
            let height = -(self.headHeight! - statusBarAndNavigationBarHeight)
            
            let frame = CGRect(x: 0, y: height, width: SCWidth, height: self.headHeight!)
            
            self.headBottomView.frame = frame
            
            return
            
        }
        
        let frame = CGRect(x: 0, y: -index, width: SCWidth, height: self.headHeight! + menuHeight)
        
        self.headBottomView.frame = frame
        
        let color = self.navView?.backgroundColor ?? UIColor.white
        
        self.navView?.backgroundColor = color.withAlphaComponent(index/64)
        
        let height = self.headHeight ?? 0
        
        switch self.animationType {
        case .Type_UpDown:
            self.headView?.frame = CGRect(x: 0, y: index, width: SCWidth, height:height - index)
        case .Type_All:
            do {
                var width = SCWidth - index * SCWidth / height;
                
                if width < SCWidth {
                    
                    width = SCWidth
                    
                }
                var x = -(-index * SCWidth / height / 2)
                
                if x > 0 {
                    
                    x = 0
                }
                
                self.headView?.frame = CGRect(x: x,
                                              y: index,
                                              width: width,
                                              height: height - index)
                
            }
        default:
            break
        }
        
    }
    
    internal func touchMenuBtn(tag: Int) {
        
        let point = CGPoint(x: SCWidth * CGFloat(tag), y: 0)
        
        self.bottomScrollView.setContentOffset(point, animated: true)
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / SCWidth
        
        self.menuView.setScrollIndex(tag: Int(page))
        
    }
    
    /// 设置pageMenu属性 （视图控制器数组个数 == 菜单数组个数）
    ///
    /// - Parameters:
    ///   - headHeight: 头部高度
    ///   - headView: 头部视图
    ///   - navView: 导航栏
    ///   - vcs: 视图控制器数组
    ///   - vcTiltes: 菜单数组
    ///   - animationType: 头部动画
   public func setPageMenu(headHeight:CGFloat,
                     headView:UIView,
                     navView:UIView,
                     vcs:[HJBaseVC],
                     vcTiltes:[String],
                     animationType:animationType = .Type_None) {
        
        self.headHeight = headHeight
        
        self.headView = headView
        
        self.arrayTitles = vcTiltes
        
        self.arrayVC = vcs
        
        self.animationType = animationType
        
        self.navView = navView
        
    }
    
    /// 设置pageMenu属性 （视图控制器数组个数 == 菜单数组个数）
    ///
    /// - Parameters:
    ///   - headHeight: 头部高度
    ///   - headView: 头部视图
    ///   - vcs: 视图控制器数组
    ///   - vcTiltes: 菜单数组
    ///   - animationType: 头部动画
    public func setPageMenu(headHeight:CGFloat,
                     headView:UIView,
                     vcs:[HJBaseVC],
                     vcTiltes:[String],
                     animationType:animationType = .Type_None) {

        self.setPageMenu(headHeight: headHeight,
                         headView: headView,
                         navView: self.getNavView(),
                         vcs: vcs,
                         vcTiltes: vcTiltes
            ,animationType:animationType)
        
    }
    
    func getNavView() -> UIView {
        
        let navV = UIView.init(frame: CGRect(x: 0,
                                             y: 0,
                                             width:
            SCWidth, height: statusBarAndNavigationBarHeight))

        navV.backgroundColor = UIColor.white.withAlphaComponent(0);

        return navV
        
    }
    
    /// 头部动画效果
    ///
    /// - Type_None: 没有动画
    /// - Type_UpDown: 上下拉伸
    /// - Type_All: 上下左右拉伸
   public enum animationType {
        case Type_None
        case Type_UpDown
        case Type_All
    }
    
    
}
