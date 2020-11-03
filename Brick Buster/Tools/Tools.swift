//
//  Tools.swift
//  Brick Buster
//
//  Created by Tianle Zhang on 2020/10/21.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit
import MBProgressHUD
import PokerCard
import AVKit

public extension Int {
    public static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }

    public static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
}

extension UIViewController {

    func showHUD(progressLabel:String){
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
    }

    func dismissHUD(isAnimated:Bool) {
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
    }
}

class Alert {
    static func showBasicAlert(on vc: UIViewController, with titile:String, message : String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: titile, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        vc.present(alert, animated: true)
    }
    
    static func showActionSheetAlert(on vc: UIViewController, with titile:String?, message : String?, actions : [UIAlertAction]) {
        let alert = UIAlertController(title: titile, message: message, preferredStyle: .actionSheet)
        for ac in actions {
            alert.addAction(ac)
        }
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func fancyAlert(with titile:String, message : String, handler: (() -> Void)? = nil) {
        if #available(iOS 13.0, *) {
            currentWindow?.overrideUserInterfaceStyle = .dark
            UISelectionFeedbackGenerator().selectionChanged()
        }
        PokerCard.showAlert(title: titile, detail: message)
            .confirm(title: "Done", style: .success, cancelTitle: nil, handler: handler ?? {})
    }
}
