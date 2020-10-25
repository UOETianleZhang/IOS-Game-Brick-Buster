//
//  StoreViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/16.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    @IBOutlet weak var lives: UILabel!
    @IBOutlet weak var bats: UILabel!
    @IBOutlet weak var lifeStepper: UIStepper!
    @IBOutlet weak var batStepper: UIStepper!
    @IBOutlet weak var total: UILabel!
    
    var newLives = 0
    var newBats = 0
    
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setBackground()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func life(_ sender: Any) {
        newLives = Int(lifeStepper.value)
        lives.text = "\(newLives)"
        total.text = "\(5*newLives+10*newBats)"
    }
    
    @IBAction func ball(_ sender: Any) {
        newBats = Int(batStepper.value)
        bats.text = "\(Int(newBats))"
        total.text = "\(5*newLives+10*newBats)"
    }
    
    @IBAction func back(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
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
