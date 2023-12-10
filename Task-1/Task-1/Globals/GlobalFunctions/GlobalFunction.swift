//
//  GlobalFunction.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation

func delay(time: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        closure()
    }
}
