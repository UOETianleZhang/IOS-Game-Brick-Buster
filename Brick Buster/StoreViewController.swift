//
//  StoreViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/16.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit
import AVKit

class StoreViewController: UIViewController {
    @IBOutlet weak var life: UILabel!
    @IBOutlet weak var bat: UILabel!
    @IBOutlet weak var currLife: UILabel!
    @IBOutlet weak var currBat: UILabel!
    @IBOutlet weak var wallet: UILabel!
    @IBOutlet weak var lifeStepper: UIStepper!
    @IBOutlet weak var batStepper: UIStepper!
    @IBOutlet weak var total: UILabel!
    
    var newLives: Int64 = 0
    var newBats: Int64 = 0
    var totalPrice: Int64 = 0
    
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setBackground()
        currLife.text = "\(data.lives)"
        currBat.text = "\(data.bats)"
        wallet.text = "\(data.coins)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func life(_ sender: Any) {
        newLives = Int64(lifeStepper.value)
        life.text = "\(newLives)"
        totalPrice = 5*newLives+10*newBats
        total.text = "\(totalPrice)"
    }
    
    @IBAction func ball(_ sender: Any) {
        newBats = Int64(batStepper.value)
        bat.text = "\(Int(newBats))"
        totalPrice = 5*newLives+10*newBats
        total.text = "\(totalPrice)"
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
    
    @IBAction func checkout(_ sender: Any) {
        if data.coins < totalPrice {
            playSound()
            popup()
            return
        }
        data.coins -= totalPrice
        data.lives += newLives
        data.bats += newBats
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
        playSound()
    }
    
    func playSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundFile)
            audioPlayer.volume = data.sound
            audioPlayer.play()
        } catch {
            print("sound error")
        }
    }
    
    func popup() {
        let alert = UIAlertController(title: "Alert", message: "You don't have enough coins", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
