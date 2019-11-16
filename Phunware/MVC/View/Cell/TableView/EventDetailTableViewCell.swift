//
//  EventDetailTableViewCell.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit

class EventDetailTableViewCell: UITableViewCell , ReusableCell {
    
    //MARK::- OUTLETS
    
    @IBOutlet weak var labelEventVenue: UILabel!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelOccurence: UILabel!
    @IBOutlet weak var labelEventDetail: UILabel!
    
    //MARK::- PROPERIES
    var item: Any?{
        didSet{
            guard let event = item as? EventData else { return }
            labelOccurence?.text = Date(fromString: /event.date , format: DateFormat.iso8601(ISO8601Format.DateTimeMilliSec)).toString(.custom("MMM d, yyyy")) + " at " + Date(fromString: /event.date , format: DateFormat.iso8601(ISO8601Format.DateTimeMilliSec)).toString(.custom("h:mm a"))
            labelEventName?.text = /event.title
            labelEventVenue?.text = /event.locationline1 + "\n" + /event.locationline2
            labelEventDetail?.text = /event.description
        }
    }
    
    //MARK::- VIEW CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    
    
}
