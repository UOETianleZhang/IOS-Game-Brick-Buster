//
//  MainViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/16.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit
import AVKit

enum equipment {
    case life
    case bat
}

var coins: Int64 = 10
var lives: Int64 = 0
var bats: Int64 = 0
var progress: Int64 = 0
var music: Float = 0.1
var sound: Float = 1.0
let soundFile = URL(fileURLWithPath: Bundle.main.path(forResource: "btn_click_sound", ofType: "mp3")!)
let musicFile = URL(fileURLWithPath: Bundle.main.path(forResource: "Astronomia", ofType: "mp3")!)
var musicPlayer = AVAudioPlayer()
var audioPlayer = AVAudioPlayer()

class MainViewController: UIViewController {
    
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.navigationController?.pushViewController(loginVC, animated: false)
        setBackground()
        playMusic()
        // Do any additional setup after loading the view.
    }
    
    func playSound() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundFile)
            audioPlayer.volume = sound
            audioPlayer.play()
        } catch {
            print("sound error")
        }
    }
    
    func playMusic() {
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: musicFile)
            musicPlayer.volume = music
            musicPlayer.play()
        } catch {
            print("music error")
        }
    }
    
    @IBAction func stages(_ sender: Any) {
        let stageVC = self.storyboard?.instantiateViewController(withIdentifier: "stageVC") as! StageViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(stageVC, animated: false)
        playSound()
    }
    @IBAction func rankings(_ sender: Any) {
        let rankVC = self.storyboard?.instantiateViewController(withIdentifier: "rankVC") as! RankViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(rankVC, animated: false)
        playSound()
    }
    @IBAction func store(_ sender: Any) {
        let storeVC = self.storyboard?.instantiateViewController(withIdentifier: "storeVC") as! StoreViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(storeVC, animated: false)
        playSound()
    }
    @IBAction func settings(_ sender: Any) {
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "settingVC") as! SettingViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromRight
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(settingVC, animated: false)
        playSound()
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
