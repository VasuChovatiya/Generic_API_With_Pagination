//
//  Application.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation
import Nuke
import UIKit

struct Application {
        ///Debuging
    static let debug: Bool = true

    
    
    //placeholder
    static let placeHolderImageCommon = UIImage(named: "")
    static let placeHolderAvatarImageCommon = UIImage(named: "ic_sidemenu_user")
    static let placeHolderOptionsNuke = ImageLoadingOptions(
        placeholder: Application.placeHolderImageCommon,
        transition: .fadeIn(duration: 0.1)
    )
    
    static let placeHolderOptionsNukeForAvatarImage = ImageLoadingOptions(
        placeholder: Application.placeHolderAvatarImageCommon,
        transition: .fadeIn(duration: 0.1)
    )
    
    
    /// API key
    static let API_KEY  =   "c06fbbce4ce34af58db24330bc01d2e2"
                          //"c06fbbce4ce34af58db24330bc01d2e2"
}
