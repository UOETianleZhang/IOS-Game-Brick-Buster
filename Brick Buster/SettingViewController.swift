//
//  SettingViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/24.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit
import AVKit

class SettingViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var soundSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setBackground()
        musicSlider.value = music
        soundSlider.value = sound
        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirm(_ sender: Any) {
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
            audioPlayer.volume = sound
            audioPlayer.play()
        } catch {
            print("sound error")
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
    
    @IBAction func musicVolume(_ sender: Any) {
        music = musicSlider.value
        musicPlayer.volume = music
    }
    
    @IBAction func soundVolume(_ sender: Any) {
        sound = soundSlider.value
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
