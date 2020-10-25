//
//  StageViewController.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/16.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit

class StageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        progressLabel.text = "\(progress)/9 🏆"
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width-40)/4, height: (self.collectionView.frame.size.width-40)/4)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StageCollectionViewCell.nib(), forCellWithReuseIdentifier: "StageCollectionViewCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func play(_ sender: Any) {
        startGame(s: 1, equips: [.life, .bat])
    }
    
    func startGame(s: Int64, equips: [equipment]) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        stage = s
        equipments = equips
        self.navigationController?.pushViewController(gameVC, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        stage = Int64(indexPath.item+1)
        cell.layer.borderColor = Colors.tropicGreen.cgColor
        cell.layer.borderWidth = 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = Colors.tropicGreen.cgColor
        cell?.layer.borderWidth = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCollectionViewCell", for: indexPath) as! StageCollectionViewCell
        cell.configure(with: UIImage(named: "\(indexPath.item+1)_square")!)
        cell.layer.borderColor = Colors.tropicGreen.cgColor
        cell.layer.borderWidth = 0
        return cell
    }

}
