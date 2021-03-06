//
//  LoginViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/16.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit
import AVKit
import MBProgressHUD

class LoginViewController: UIViewController {
    
    let backgroundImageView = UIImageView()

    @IBOutlet weak var firstNameInput: LoginText!
    @IBOutlet weak var lastNameInput: LoginText!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setBackground()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        playSound()
        showHUD(progressLabel: "loading")
        data.first = self.firstNameInput.text ?? "Spider"
        if data.first.isEmpty {
            data.first = "Spider"
        }
        data.last = self.lastNameInput.text ?? "Man"
        if data.last.isEmpty {
            data.last = "Man"
        }
        
        DispatchQueue.global().async() {
            if let fetchedData = DB.getData(first: data.first, last: data.last) {
                data = fetchedData
            } else {
                DB.addOrUpdate(data: data)
            }

            DispatchQueue.main.async {
                self.dismissHUD(isAnimated: true)
                Alert.fancyAlert(with: "Login Success!", message: "\tWelcome, \(data.first) \(data.last)!") {
                    DispatchQueue.main.async {
                        playSound()
                        let transition = CATransition()
                        transition.duration = 0.5
                        transition.type = CATransitionType(rawValue: "cube")
                        transition.subtype = CATransitionSubtype.fromBottom
                        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
                        self.navigationController?.popViewController(animated: false)
                    }
                }
            }
        }
    }
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.contentMode = .scaleAspectFill;
        
        backgroundImageView.image = UIImage(named: "loginbg")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
