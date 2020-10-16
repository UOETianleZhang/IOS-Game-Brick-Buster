//
//  MainViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/16.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
