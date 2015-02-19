//
//  DataManager.swift
//  TopApps
//
//  Created by Peter Sterr on 19.02.15.
//  Copyright (c) 2015 Peter Sterr. All rights reserved.
//

import Foundation

let GBapiKey = "02f9d191e91dce081c2c28c04755ead9fd7934a9"
let SearchQuery = "http://www.giantbomb.com/api/games/?field_list=api_detail_url%2Cid%2Cname%2Cdeck&filter=name:the%20last%20of%20us&format=json"

class DataManager {
    
    class func searchGiantbomb(success: ((GBData: NSData!) -> Void)) {
        let apiKey = loadApiKey()
        let query = SearchQuery + "&api_key=" + apiKey
        loadDataFromURL(NSURL(string: query)!, completion:{(data, error) -> Void in
            if let urlData = data {
                success(GBData: urlData)
            } else {
                if let error = error {
                    println(error)
                }
            }
        })
    }
    
    class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
        
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    var statusError = NSError(domain:"com.petersterr", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        
        loadDataTask.resume()
    }
    
    class func loadApiKey() -> NSString {
        let path = NSBundle.mainBundle().pathForResource("GBapiKey", ofType: "txt")
        var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return text
    }
}