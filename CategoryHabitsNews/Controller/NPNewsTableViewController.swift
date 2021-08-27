//
//  NPNewsTableViewController.swift
//  CategoryHabitsNews
//
//  Created by 近藤米功 on 2021/08/10.
//

import UIKit
import SegementSlide
class NPNewsTableViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    //XMLParserのインスタンスを作成する
    var parser = XMLParser()
    //RSSのパース中の現在の要素名
    var currentElementName:String!
    var newsItems = [NewsItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableViewを透明にする
        tableView.backgroundColor = .clear
        //画像をtableViewの下に置く
        let image = UIImage(named:  "newsPicks")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: self.tableView.frame.size.height))
        imageView.image = image
        self.tableView.backgroundView = imageView
        //XMLパース
        let urlString = "https://news.yahoo.co.jp/rss/media/newspicksn/all.xml"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
    }
    @objc var scrollView: UIScrollView{
        return tableView
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath:IndexPath)-> CGFloat
    {
        return view.frame.size.height/4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //UITableViewControllerを親クラスでもつとこのように書ける
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        cell.backgroundColor = .clear
        let newsItems = self.newsItems[indexPath.row]
        cell.textLabel?.text = newsItems.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 25.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 1
        cell.detailTextLabel?.text = newsItems.pubDate
        cell.detailTextLabel?.textColor = .white
        cell.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        return cell
    }
    //XMLParserDelegateのデリゲードメソッド
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item"{
            //NewsItems()=NewsItemsの初期化
            self.newsItems.append(NewsItems())
        }
        else{
            currentElementName = elementName
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count>0{
            let lastItem = self.newsItems[self.newsItems.count-1]
            switch self.currentElementName{
            case "title":
                lastItem.title = string
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.pubDate = string
            default:break
                
            }
        }
    }
    //<title>タイトル</title>
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //WebViewControllerにurlを渡して、表示したい
        let webViewController = WebViewController()
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row]
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        present(webViewController,animated: true,completion: nil)
    }

}
