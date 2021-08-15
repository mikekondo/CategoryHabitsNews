//
//  NewsViewController.swift
//  CategoryHabitsNews
//
//  Created by 近藤米功 on 2021/08/10.
//

import UIKit
import SegementSlide
class NewsViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "今日のnews!!"
        //SegementSlideDefaultViewControllerによるもの(デリゲートメソッドではない)
        reloadData()
        defaultSelectedIndex = 0
    }
    //SegementSlideDefaultViewControllerによるもの
    override var titlesInSwitcher: [String]{
        return ["IT","国内","国外","Billboard","News Picks"]
    }
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
        case 0:
            return ITNewsTableViewController()
        case 1:
            return DomesticNewsTableViewController()
        case 2:
            return WorldNewsTableViewController()
        case 3:
            return BillboardTableViewController()
        case 4:
            return NPNewsTableViewController()
        default:
            return ITNewsTableViewController()
        }
    }
}
