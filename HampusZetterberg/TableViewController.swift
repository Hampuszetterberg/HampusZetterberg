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
    private var Parser: XMLParser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Parser = XMLParser(feed: Constants.feedUrl)
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
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        if(cell.isEqual(NSNull)) {
            //cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as UITableViewCell;
        }
        //cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as NSString
        //cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("date") as NSString
        return cell as UITableViewCell
    }
    
    
}
