//
//  MainViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/16.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: false)
        setBackground()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func stages(_ sender: Any) {
        let stageVC = self.storyboard?.instantiateViewController(withIdentifier: "stageVC") as! StageViewController
        self.navigationController?.pushViewController(stageVC, animated: true)
    }
    @IBAction func leaderboards(_ sender: Any) {
    }
    @IBAction func store(_ sender: Any) {
    }
    @IBAction func settings(_ sender: Any) {
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
