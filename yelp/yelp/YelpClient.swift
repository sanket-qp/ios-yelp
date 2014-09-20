//
//  YelpClient.swift
//  yelp
//
//  Created by sanket patel on 9/19/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import Foundation
import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    var searchResults: [SearchResult]? {
    
        didSet {
        
             println("search done")
             NSNotificationCenter.defaultCenter().postNotificationName("searchFinished", object: self)
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func search(term: String, location: String = "San Francisco", limit: Int = 10) {

        var parameters = ["term": term, "location": location, "limit": limit]
        var data = self.GET("search", parameters: parameters, success: { (operation, response) -> Void in
            
            var object = response as NSDictionary
            var businesses = object["businesses"] as [NSDictionary]
            let mapped = businesses.map({ (business: NSDictionary) -> SearchResult in
                
                SearchResult(dict: business)
            })
            
            self.searchResults = mapped
        
        }) { (operation, error) -> Void in
            
            self.searchResults = []
            println(error)
        }
    }
        
    func searchWithTerm(term: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "location": "San Francisco"]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
}