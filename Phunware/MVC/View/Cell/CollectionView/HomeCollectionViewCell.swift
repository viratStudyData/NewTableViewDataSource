//
//  HomeCollectionViewCell.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell , ReusableCell {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var labelEventVenue: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelOccurence: UILabel!
    @IBOutlet weak var labelEventDetail: UILabel!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet weak var constraintTrailing: NSLayoutConstraint!
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    @IBOutlet weak var constraintLeading: NSLayoutConstraint!

    
    
    //MARK::- PROPERIES
    var item: Any?{
        didSet{
            guard let event = item as? EventData else { return }
            labelOccurence?.text = Date(fromString: /event.date , format: DateFormat.iso8601(ISO8601Format.DateTimeMilliSec)).toString(.custom("MMM d, yyyy")) + " at " + Date(fromString: /event.date , format: DateFormat.iso8601(ISO8601Format.DateTimeMilliSec)).toString(.custom("h:mm a"))
            labelEventName?.text = /event.title
            labelEventVenue?.text = /event.locationline1
            labelEventDetail?.text = /event.description
            imageBackground?.setImageKF(event.image)
            constraintTop?.constant = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 0 : 1
            constraintTrailing?.constant = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 0 : 1
            constraintBottom?.constant = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 0 : 1
            constraintLeading?.constant = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 0 : 1
            
            
        }
    }
    
    
}
