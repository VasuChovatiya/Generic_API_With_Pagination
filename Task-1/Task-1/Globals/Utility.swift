//
//  Utility.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import Foundation
import UIKit
import CoreLocation
import LocalAuthentication

class Utility {
    
    // MARK: - Variables
    static let shared = Utility()
    
    var enableLog = true
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var timeStampInterval: TimeInterval {
        return Date().timeIntervalSince1970
    }
    
    var timeStampString: String {
        return "\(Date().timeIntervalSince1970)"
    }
    
    
    // MARK: - Functions
    class func isLogEnable() -> Bool {
        return self.shared.enableLog
    }
    
    class func enableLog() {
        self.shared.enableLog = true
    }
    
    class func disableLog() {
        self.shared.enableLog = false
    }
    
    class func appDelegate() -> AppDelegate {
        return self.shared.appDelegate
    }
    
    class func sceaneDelegate() -> SceneDelegate? {
        return SceneDelegate.shared
    }
    
    class func windowMain() -> UIWindow? {
        return SceneDelegate.shared?.window
    }
    

    
    class func rootViewControllerMain() -> UIViewController? {
        return self.windowMain()?.rootViewController
    }
    
    class func applicationMain() -> UIApplication {
        return UIApplication.shared
    }
    
    class func getMajorSystemVersion() -> Int {
        let systemVersionStr = UIDevice.current.systemVersion   //Returns 7.1.1
        let mainSystemVersion = Int((systemVersionStr.split(separator: "."))[0])
        
        return mainSystemVersion!
    }
    
    class func getAppUniqueId() -> String {
        let uniqueId: UUID = UIDevice.current.identifierForVendor! as UUID
        
        return uniqueId.uuidString
    }
    
    class func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
    
    class func showMessageAlert(title: String, andMessage message: String, withOkButtonTitle okButtonTitle: String = "OK") {
        let alertWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) -> Void in
            
            alertWindow.isHidden = true
            
        }))
        
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    class func showMessageAlert(inVc: UIViewController, title: String, andMessage message: String, withOkButtonTitle okButtonTitle: String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) -> Void in
            
        }))
        
        inVc.present(alertController, animated: true, completion: nil)
    }
    
    class func showAlertForAppSettings(title: String, message: String, allowCancel: Bool = true, completion: @escaping (Bool) -> ()) {
            var alertWindow: UIWindow! = UIWindow(frame: UIScreen.main.bounds)
            
            let windowScene = UIApplication.shared
                .connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
            if let windowScene = windowScene as? UIWindowScene {
                alertWindow = nil
                alertWindow = UIWindow(windowScene: windowScene)
            }
            
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindow.Level.alert + 1
            alertWindow.makeKeyAndVisible()
            
            let alertController: UIAlertController = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(message, comment: ""), preferredStyle: .alert)
            
            if allowCancel {
                alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { (action) -> Void in
                    
                    alertWindow.isHidden = true
                    completion(false)
                    
                }))
            }
            
            alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default, handler: { (action) -> Void in
                
                alertWindow.isHidden = true
                
                let settingURL = URL(string: UIApplication.openSettingsURLString)!
                
                if(UIApplication.shared.canOpenURL(settingURL)) {
                    UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
                }
                
                completion(true)
                
            }))
            
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    
    class func jsonStringFromDict(_ dict: [String: Any]) -> String? {
        var jsonString: String?
        
        // try to create JSON string
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
            print("Could not create JSON from dict.")
        }
        return jsonString
    }
    
    class func nonNilString(string: String?) -> String {
        guard let string = string else {
            return ""
        }
        if string.isKind(of: NSNull.self) || string == "null" || string == "<null>" || string == "(null)" {
            return ""
        }
        return string
    }
    
    class func isEmptyString(string: String?) -> Bool {
        return self.nonNilString(string: string).trimmed().isEmpty
    }
    
    class func currentTimeMillis() -> Int64 {
        let nowDouble = Date().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    class func currentTimeSeconds() -> Int64 {
        let nowDouble = Date().timeIntervalSince1970
        return Int64((Int(nowDouble) % 3600) % 60)
    }
    
    
    class func isLocationServiceEnable(completion: @escaping ((Bool) -> Void)) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                completion(false)
            case .restricted:
                completion(false)
            case .denied:
                completion(false)
            case .authorizedAlways:
                completion(true)
            case .authorizedWhenInUse:
                completion(true)
            @unknown default:
                completion(false)
            }
        } else {
            completion(false)
        }
    }
}


// MARK: - QueueType
public enum QueueType {
    case Main
    case Background
    case LowPriority
    case HighPriority
    
    var queue: DispatchQueue {
        switch self {
        case .Main:
            return DispatchQueue.main
        case .Background:
            return DispatchQueue(label: "com.app.queue",
                                 qos: .background,
                                 target: nil)
        case .LowPriority:
            return DispatchQueue.global(qos: .userInitiated)
        case .HighPriority:
            return DispatchQueue.global(qos: .userInitiated)
        }
    }
}

func performOn(_ queueType: QueueType, closure: @escaping () -> Void) {
    queueType.queue.async(execute: closure)
}
