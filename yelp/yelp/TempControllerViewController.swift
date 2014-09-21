//
//  TempControllerViewController.swift
//  yelp
//
//  Created by sanket patel on 9/20/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class TempControllerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    let consumerKey = "UqvuPXyQvL7ry65aw6CF2w"
    let consumerSecret = "3Vv_TwZd5x8FYdr_58AO_jXDHhM"
    let accessToken = "JGCPhfIy6DupUtQRvF3gY5z3ZkNFnGl6"
    let accessSecret = "j6-2z91Tq-PgkQrvGU1qZ0FCkKU"
    var yelpClient: YelpClient!
    var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        filterButton.enabled = true
        self.navigationItem.backBarButtonItem = filterButton
        
        tableView.delegate = self
        tableView.dataSource = self
        self.searchDisplayController?.displaysSearchBarInNavigationBar = true
        yelpClient = YelpClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken, accessSecret: accessSecret)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refreshData:" , name: "searchFinished", object: nil)
        yelpClient.search("food", location: "Fremont", limit:20)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData(sender: AnyObject) {
        
        
        searchResults = yelpClient.searchResults!
        println("search results : \(searchResults.count)")
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("TempCell") as TempCellTableViewCell
        var searchResult = searchResults[indexPath.row]
        cell.populate(searchResult)
        return cell
    }

}
