//
//  CountViewController.swift
//  CategoryHabitsNews
//
//  Created by 近藤米功 on 2021/08/10.
//

import UIKit
import AVFoundation
class CountViewController: UIViewController {
    var player = AVPlayer()
    let path = Bundle.main.path(forResource: "ink", ofType: "mp4")
    var count=0
    @IBOutlet weak var firstArticle: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var secondArticle: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景を動画にする
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player.play()
        let playerLayer=AVPlayerLayer(player:player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        playerLayer.videoGravity = .resizeAspectFill
        //背景が一番奥
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
        //無限ループ
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (notification) in
            self.player.seek(to: .zero)
            self.player.play()
        }
        //保存しておいたcountデータを格納
        count = UserDefaults.standard.object(forKey: "countLabel") as! Int
        //カウントのインクリメント
        count+=1
        print(count)
        //countLabeltextに表示
        countLabel.text=String(count)
        countLabel.textColor = .white
        countLabel.backgroundColor = .clear
        firstArticle.textColor = .white
        secondArticle.textColor = .white
        dayLabel.textColor = .white
        UserDefaults.standard.set(count, forKey: "countLabel")
        
    }
    
}
