//
//  XMLParser.swift
//  HampusZetterberg
//
//  Created by Hampus Zätterberg on 2016-04-20.
//  Copyright © 2016 hampus. All rights reserved.
//

import Foundation

protocol XMLParserDelegate {
    func didFinishParsing(success: Bool)
}

class XMLParser : NSObject,NSXMLParserDelegate {
    private var parser = NSXMLParser()
    private var element = String()
    private var object: SBModel?
    var articles = [SBModel]()
    var delegate: XMLParserDelegate?
    

    func parse(feed: String) {
        parser = NSXMLParser(contentsOfURL:(NSURL(string:feed))!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName
        
        if elementName == "item" {
            object = SBModel()
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if object != nil {
            if element == "title" {
                object!.title += string
            } else if element == "link" {
                object!.link += string
            } else if element == "description" {
                object!.description += string
            }  else if element == "pubDate" {
                object!.pubDate += string
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if object != nil {
            if elementName == "item" {
                articles.append(object!)
            }
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        delegate?.didFinishParsing(true)
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        delegate?.didFinishParsing(false)
    }
}
