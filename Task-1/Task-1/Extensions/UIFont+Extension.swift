//
//  UIFont+Extension.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation
import UIKit


extension UIFont {
    
    private static let Roboto_Black = "Roboto-Black"
    private static let Roboto_Bold = "Roboto-Bold"
    private static let Roboto_Medium = "Roboto-Medium"
    private static let Roboto_Regular = "Roboto-Regular"
    
    static func Roboto_Black(of size: CGFloat) -> UIFont {
        return UIFont(name: self.Roboto_Black, size: size)!
    }
    
    static func Roboto_Bold(of size: CGFloat) -> UIFont {
        return UIFont(name: self.Roboto_Bold, size: size)!
    }
    
    
    static func Roboto_Medium(of size: CGFloat) -> UIFont {
        return UIFont(name: self.Roboto_Medium, size: size)!
    }
    
    static func Roboto_Regular(of size: CGFloat) -> UIFont {
        return UIFont(name: self.Roboto_Regular, size: size)!
    }
}
