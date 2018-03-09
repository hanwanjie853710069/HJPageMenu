//
//  HJConstantFile.swift
//  PageMenu
//
//  Created by 王木木 on 2018/3/8.
//  Copyright © 2018年 Mr.H. All rights reserved.
//

import UIKit

let SCWidth = UIScreen.main.bounds.width

let SCHeight = UIScreen.main.bounds.height

let menuHeight: CGFloat = 44

let iS_iPhoneX = (SCWidth == 375 && SCHeight == 812 ? true : false)

let statusIphoneXHeight:CGFloat = (iS_iPhoneX ? 24 : 0)

let statusBarAndNavigationBarHeight: CGFloat = (iS_iPhoneX ? 88 : 64)
