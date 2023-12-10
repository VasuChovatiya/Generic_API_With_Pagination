//
//  UITableViewCell+Extension.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import UIKit

extension UITableViewCell {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}

//extension UICollectionViewCell {
//    /// Return Nib
//    public static var nib: UINib {
//        return UINib(nibName: identifier, bundle: nil)
//    }
//
//    /// Return Identifier
//    public static var identifier: String {
//        return String(describing: self)
//    }
//}

extension UICollectionReusableView {
    /// Return Nib
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    /// Return Identifier
    public static var identifier: String {
        return String(describing: self)
    }
}
