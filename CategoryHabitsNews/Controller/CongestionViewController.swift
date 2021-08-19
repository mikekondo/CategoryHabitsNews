//
//  CongestionViewController.swift
//  CategoryHabitsNews
//
//  Created by 近藤米功 on 2021/08/19.
//

import UIKit
import WebKit
class CongestionViewController: UIViewController,WKNavigationDelegate {
    var webView = WKWebView()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var toolBar: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.isHidden = true
        
        //大きさをきめていく
        
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - toolBar.frame.size.height)
        
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        //URLをロード
        let url = URL(string: "https://mobakumap.jp/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
        indicator.layer.zPosition = 2
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        //ロードが完了したときに呼ばれるデリゲートメソッド
        indicator.isHidden = true
        indicator.stopAnimating()
        
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        //読み込みが開始された時に呼ばれるデリゲートメソッド
        indicator.isHidden = false
        indicator.startAnimating()
        
    }

}
