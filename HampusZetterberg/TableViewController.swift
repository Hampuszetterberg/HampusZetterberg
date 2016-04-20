//
//  TableViewController.swift
//  HampusZetterberg
//
//  Created by Hampus Zätterberg on 2016-04-20.
//  Copyright © 2016 hampus. All rights reserved.
//

import UIKit

struct Constants {
    static let feedUrl = "http://www.systembolaget.se/api/assortment/products/xml"
}

class TableViewController: UITableViewController {
    private var parser: XMLParser!
    private var parsedData = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser = XMLParser(feed: Constants.feedUrl)
        parsedData = parser.posts
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 24
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : SBCell = tableView.dequeueReusableCellWithIdentifier("cell") as! SBCell
        cell.liquorName.text = "Hampus"
    
       
        return cell as UITableViewCell
    }
    
    
}
