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
    @IBOutlet var searchBar: UISearchBar!
    
    private var parser: XMLParser!
    private var filteredArticles = [NewsModel]()
    private var isPerfomingSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset.top = 20
        
        searchBar.delegate = self
        
        parser = XMLParser()
        parser.delegate = self
        parser.parse(Constants.feedUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isPerfomingSearch ? filteredArticles.count : parser.articles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : NewsCell = tableView.dequeueReusableCellWithIdentifier("cell") as! NewsCell
        
        let artictlesToView = isPerfomingSearch ? filteredArticles : parser.articles
        
        cell.newsTitle.text = artictlesToView[indexPath.row].title
        cell.pubDate.text = artictlesToView[indexPath.row].pubDate

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dataForSelection = parser.articles[indexPath.row]
        
        let newsDetailsController = NewsDetailsControllerViewController(nibName: "NewsDetailsControllerViewController", bundle: nil)
        newsDetailsController.data = dataForSelection
        
        self.presentViewController(newsDetailsController, animated: true, completion: nil)
    }
    
    private func filterWithSearch(searchText: String) {
        filteredArticles = parser.articles.filter { article in
            return article.title.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
}

extension TableViewController: XMLParserDelegate {
    func didFinishParsing(success: Bool) {
        if success {
            tableView.reloadData()
        }
    }
}

extension TableViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        isPerfomingSearch = searchText.characters.count > 0 ? true : false
        filterWithSearch(searchBar.text!)
    }
}
