//
//  UIColor+Extension.swift
//  Networkd
//
//  Created by Mario Andres Villamizar Palacio on 5/2/17.
//  Copyright © 2017 Refundo LLC. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, withAlpha alpha: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    
    convenience init(hex:Int, alpha: CGFloat) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, withAlpha: alpha)
    }
    
    convenience init(hexString:String) {
        
        let hexString = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
    
    
    func changeBrightness(amount: CGFloat) -> UIColor? {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness += (amount-1.0)
            brightness = max(min(brightness, 1.0), 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        
        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            white += (amount-1.0)
            white = max(min(white, 1.0), 0.0)
            return UIColor(white: white, alpha: alpha)
        }
        
        return nil
    }
    
    var isDarkColor: Bool {
        let RGB = self.cgColor.components
        let redComponent = 0.2126 * RGB![0]
        let greenComponent = 0.7152 * RGB![1]
        let blueComponent = 0.0722 * RGB![2]
        return redComponent + greenComponent + blueComponent < 0.5
    }
}
