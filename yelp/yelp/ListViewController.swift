//
//  ListViewController.swift
//  yelp
//
//  Created by sanket patel on 9/19/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    let consumerKey = "UqvuPXyQvL7ry65aw6CF2w"
    let consumerSecret = "3Vv_TwZd5x8FYdr_58AO_jXDHhM"
    let accessToken = "JGCPhfIy6DupUtQRvF3gY5z3ZkNFnGl6"
    let accessSecret = "j6-2z91Tq-PgkQrvGU1qZ0FCkKU"
    var yelpClient: YelpClient!
    var searchResults: [SearchResult] = []
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.searchDisplayController?.displaysSearchBarInNavigationBar = true
        /*
        searchBar = UISearchBar(frame: CGRect(x: -5.0, y: 0.0, width: 320.0, height: 44.0))
        searchBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        let searchView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 310.0, height: 44.0))
        searchView.autoresizingMask = UIViewAutoresizing.None
        searchBar.delegate = self
        searchView.addSubview(searchBar)
        self.navigationItem.titleView = searchView
        */
        yelpClient = YelpClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken, accessSecret: accessSecret)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData:" , name: "searchFinished", object: nil)
        
        yelpClient.search("food")
        //tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func refreshData(sender: AnyObject) {
        
        
        searchResults = yelpClient.searchResults!
        println("search results : \(searchResults.count)")
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("SearchResultCell") as SearchResultCell
        var searchResult = searchResults[indexPath.row]
        cell.populate(searchResult)
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
