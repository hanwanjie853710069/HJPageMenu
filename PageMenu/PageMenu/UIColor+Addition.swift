//
//  UIColor+Addition.swift
//  GuoGuo
//
//  Created by long on 2017/3/2.
//  Copyright © 2017年 long. All rights reserved.
//
import Foundation
import UIKit

func RGBAColor(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat)->UIColor{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha);
}

func RGBColor(red:CGFloat,green:CGFloat,blue:CGFloat)->UIColor{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
}


extension UIColor{
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIColor {
    
    convenience init?(hexString: String, alpha: Float = 1.0) {
        let set = CharacterSet.whitespacesAndNewlines
        var hex = hexString.trimmingCharacters(in: set).uppercased()
        
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        guard let hexVal = Int(hex, radix: 16) else {
            self.init()
            return nil
        }
        
        switch hex.count {
        case 3:
            self.init(hex3: hexVal, alpha: alpha)
        case 6:
            self.init(hex6: hexVal, alpha: alpha)
        default:
            self.init()
            return nil
        }
    }
    
    convenience init?(hexNumber: Int) {
        self.init(hexNumber: hexNumber, alpha: 1.0)
    }
    
    convenience init?(hexNumber: Int, alpha: Float) {
        guard (0x000000 ... 0xFFFFFF) ~= hexNumber else {
            self.init()
            return nil
        }
        self.init(hex6: hexNumber, alpha: alpha)
    }
}

private extension UIColor {
    convenience init?(hex3: Int, alpha: Float) {
        self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
                  green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
                  blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0,
                  alpha: CGFloat(alpha))
    }
    
    convenience init?(hex6: Int, alpha: Float) {
        self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
                  green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
                  blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0,
                  alpha: CGFloat(alpha))
    }
}

private extension Int {
    func duplicate4bits() -> Int {
        return (self << 4) + self
    }
}




