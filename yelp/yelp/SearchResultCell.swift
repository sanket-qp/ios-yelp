//
//  SearchResultCell.swift
//  yelp
//
//  Created by sanket patel on 9/19/14.
//  Copyright (c) 2014 sanket patel. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    
    @IBOutlet weak var businessImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var numOfReviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
   
    var searchResult: SearchResult!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func populate(searchResult: SearchResult) {
    
        businessImage.setImageWithURL(NSURL(string: searchResult.imageUrl))
        nameLabel.text = searchResult.name
        starsImage.setImageWithURL(NSURL(string: searchResult.stars))
        priceRangeLabel.text = randomPriceRange()
        numOfReviewsLabel.text = "\(searchResult.numOfReviews) Reviews"
        addressLabel.text = searchResult.address
        categoriesLabel.text = searchResult.categoryStr
    }
    
    func randomPriceRange() -> String {
    
        var priceRanges = ["$", "$$", "$$$", "$$$$"]
        var randomNumber : Int = Int(rand()) % (priceRanges.count - 1)
        return priceRanges[randomNumber]
    }
}
