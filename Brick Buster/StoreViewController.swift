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
    @IBOutlet weak var balls: UILabel!
    @IBOutlet weak var lifeStepper: UIStepper!
    @IBOutlet weak var ballStepper: UIStepper!
    @IBOutlet weak var total: UILabel!
    
    var newLives = 0
    var newBalls = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func life(_ sender: Any) {
        newLives = Int(lifeStepper.value)
        lives.text = "\(newLives)"
        total.text = "\(5*newLives+10*newBalls)"
    }
    
    @IBAction func ball(_ sender: Any) {
        newBalls = Int(ballStepper.value)
        balls.text = "\(Int(newBalls))"
        total.text = "\(5*newLives+10*newBalls)"
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
