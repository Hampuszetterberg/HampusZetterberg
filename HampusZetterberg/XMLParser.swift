//
//  XMLParser.swift
//  HampusZetterberg
//
//  Created by Hampus Zätterberg on 2016-04-20.
//  Copyright © 2016 hampus. All rights reserved.
//

import Foundation

class XMLParser : NSObject,NSXMLParserDelegate {
    private var parser = NSXMLParser()

    private var element = String()
//    private var elements = NSMutableDictionary()
//    private var element = String()
//    private var title1 = NSMutableString()
//    private var date = NSMutableString()
    
    var SBObject = SBModel()
    var articles = [SBModel]()
    
    
    required init(feed: String) {
        super.init()
        
        parser = NSXMLParser(contentsOfURL:(NSURL(string:feed))!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        print(elementName)
        if elementName == "item" {
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        print(string)
        if element == "item" {
            SBObject.name = string
        }
//        if element.isEqualToString("title") {
//            title1.appendString(string)
//        } else if element.isEqualToString("pubDate") {
//            date.appendString(string)
//        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
//        if (elementName as NSString).isEqualToString("item") {
//            if !title1.isEqual(nil) {
//                elements.setObject(title1, forKey: "title")
//            }
//            if !date.isEqual(nil) {
//                elements.setObject(date, forKey: "date")
//            }
//            posts.addObject(elements)
//        }
        
        
        articles.append(SBObject)
    }
}