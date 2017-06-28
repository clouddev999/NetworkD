//
//  UIImage+Extensions.swift
//  MYSO-iOS
//
//  Created by Mario Andres Villamizar Palacio on 7/9/16.
//  Copyright © 2016 The App Chefs. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init(fromView view: UIView, withSize size: CGSize) {
        UIGraphicsBeginImageContext(size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let imageData = UIImageJPEGRepresentation(image!, 1.0)
        self.init(data: imageData!)!
    }
    
    
    func scaleTo(size: CGSize) -> UIImage {
        if self.size.equalTo(size) {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func scaleTo(width: CGFloat) -> UIImage {
        let oldWidth = self.size.width
        let scaleFactor = width/oldWidth
        let newHeight = self.size.height*scaleFactor
        let newWidth = oldWidth*scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func scaleTo(height: CGFloat) -> UIImage {
        let oldHeight = self.size.height
        let scaleFactor = height/oldHeight
        let newWidth = self.size.width*scaleFactor
        let newHeight = oldHeight*scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func fromColor(color:UIColor, size:CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIGraphicsBeginImageContext(size)
        image?.draw(in: rect)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
