//
//  EntryList.swift
//  FlickrIOS
//
//  Created by Midhet Sulemani on 5/15/21.
//

import Foundation

class EntryList: NSObject {
    
    var allCells = [Collection]()
    var xmlDict = [String: Any]()
    var xmlSubDict = [String: Any]()
    var xmlDictArr = [[String: Any]]()
    var currentElement = ""
    var isauthorElement = false
    var handler: ((ServiceError?) -> Void)?
    
    private var session: URLSession
    
    override init() {
        self.session = URLSession(configuration: .default)
    }
    
    func fetchFeed(completionHandler: ((ServiceError?) -> Void)?) {
        
        let endPoint = "https://www.flickr.com/services/feeds/photos_public.gne"
        
        guard let url = URL(string: endPoint) else {
            print("Error in creating url")
            return
        }
        
        self.handler = completionHandler
        
        let urlRequest = URLRequest(url: url)
        session.dataTask(with: urlRequest) {(data, responseURL, error) in
            
            var serviceError: ServiceError?
            
            if let responseData = data {
                let parser = XMLParser(data: responseData)
                parser.delegate = self
                parser.parse()
            } else if let error = error {
                serviceError = ServiceError(details: error)
                completionHandler?(serviceError)
            }
        }.resume()
    }
    
    func addInfo(index: Int, offset: Int, completionHandler: (() -> Void)) {
        //1. Filter all prev info cells
        //2. Create Info model according to the index
        //3. Add info at index
        allCells.insert(Info(id: ""), at: index + offset)
        completionHandler()
    }
}

extension EntryList: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        //The current parsed tag is presented as `elementName` in this function
        switch elementName {
        case "entry":
            xmlDict = [:]
        case "link":
            if attributeDict["rel"] == "enclosure" {
                xmlDict["image"] = attributeDict["href"]
            }
        case "author":
            isauthorElement = true
        default:
            currentElement = elementName
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        //The value of current parsed tag is presented as `string` in this function
        if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if isauthorElement {
                xmlSubDict.updateValue(string, forKey: currentElement)
            } else if xmlDict[currentElement] == nil {
                   xmlDict.updateValue(string, forKey: currentElement)
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        //The closing tag is presented as `elementName` in this function
        if elementName == "entry" {
            xmlDictArr.append(xmlDict)
        } else if elementName == "author" {
            isauthorElement = false
            xmlDict.updateValue(xmlSubDict, forKey: "author")
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        //Called when the parsing is complete
        parsingCompleted()
    }
    
    func parsingCompleted() {
        allCells = xmlDictArr.map { Entry(details: $0) }
        handler?(nil)
    }
}


struct ServiceError {
    
    var code: Int?
    var message: String = "There was an error in the API call"
    
    init(details: Error) {
        message = details.localizedDescription
    }
}
