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
