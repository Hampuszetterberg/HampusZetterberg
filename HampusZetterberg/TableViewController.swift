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
    private var parsedData = [SBModel]()
    
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return parsedData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell : SBCell = tableView.dequeueReusableCellWithIdentifier("cell") as! SBCell

        cell.liquorName.text = parsedData[indexPath.row].title
    
       
        return cell as UITableViewCell
    }

    
    
}

extension TableViewController: XMLParserDelegate {
    func didFinishParsing(success: Bool) {
        if success {
            parsedData = parser.articles
            tableView.reloadData()
        }
    }
}
