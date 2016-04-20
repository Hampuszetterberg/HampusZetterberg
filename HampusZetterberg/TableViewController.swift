//
//  TableViewController.swift
//  HampusZetterberg
//
//  Created by Hampus Zätterberg on 2016-04-20.
//  Copyright © 2016 hampus. All rights reserved.
//

import UIKit

struct Constants {
    static let feedUrl = "http://rss.nytimes.com/services/xml/rss/nyt/Sports.xml"
}

class TableViewController: UITableViewController {
    private var parser: XMLParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser = XMLParser()
        parser.delegate = self
        parser.parse(Constants.feedUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parser.articles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : SBCell = tableView.dequeueReusableCellWithIdentifier("cell") as! SBCell

        cell.newsTitle.text = parser.articles[indexPath.row].title
        cell.pubDate.text = parser.articles[indexPath.row].pubDate
        cell.link = parser.articles[indexPath.row].link

        return cell as UITableViewCell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dataForSelection = parser.articles[indexPath.row]
        
        let newsDetailsController = NewsDetailsControllerViewController(nibName: "NewsDetailsControllerViewController", bundle: nil)
        newsDetailsController.data = dataForSelection
        
        self.presentViewController(newsDetailsController, animated: true, completion: nil)
    }
}

extension TableViewController: XMLParserDelegate {
    func didFinishParsing(success: Bool) {
        if success {
            tableView.reloadData()
        }
    }
}
