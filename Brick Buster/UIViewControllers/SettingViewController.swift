//
//  SettingViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/24.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit
import AVKit

class SettingViewController: UIViewController, UIScrollViewDelegate {
    
    let backgroundImageView = UIImageView()
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var soundSlider: UISlider!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images: [String] = ["pig", "dog", "duck", "panda"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        setBackground()
        musicSlider.value = data.music
        soundSlider.value = data.sound
        pageControll.numberOfPages = images.count
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imageView = UIImageView(frame: frame)
            imageView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        scrollView.delegate = self
        self.scrollView.contentOffset.x = self.scrollView.frame.width * CGFloat(data.paddleSkin - 1)
        pageControll.currentPage = Int(data.paddleSkin - 1)
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNum = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControll.currentPage = Int(pageNum)
        data.paddleSkin = Int64(pageNum + 1)
    }
    
    @IBAction func confirm(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
        playSound()
        data.music = musicSlider.value
        data.sound = soundSlider.value
        DB.addOrUpdate(data: data)
    }
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.contentMode = .scaleAspectFill;
        
        backgroundImageView.image = UIImage(named: "bg1")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    @IBAction func musicVolume(_ sender: Any) {
        data.music = musicSlider.value
        musicPlayer.volume = data.music
    }
    
    @IBAction func soundVolume(_ sender: Any) {
        data.sound = soundSlider.value
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
