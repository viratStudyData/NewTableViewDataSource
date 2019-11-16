//
//  EventDetailViewController.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit
import MXParallaxHeader

class EventDetailViewController: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var visualEffectViewNavBar: UIVisualEffectView!
    @IBOutlet weak var visualEffectViewHeader: UIVisualEffectView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK::- PROPERTIES
    var event: EventData?
    private var dataSource: TableDataSource<HeaderFooterData>?
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
    }
    
    //MARK::- FUNCTIONS
    func onLoad(){
        imageEvent?.setImageKF(/event?.image)
        configureTableView()
        configureParallax()
    }
    
    //MARK::- CONFIGURE DATASOURCE
    func configureTableView(){
        dataSource = TableDataSource<HeaderFooterData>(.SingleListing(items: [event ?? EventData()] , identifier: EventDetailTableViewCell.identfier , height: UITableView.automaticDimension), tableView)
        
        dataSource?.configureCell = { (cell, item, indexPath, property) in
            (cell as? EventDetailTableViewCell)?.item = item
        }
    }
    
    //MARK::- CONFIGURE Parallax
    func configureParallax(){
        tableView.parallaxHeader.view = headerView
        tableView.parallaxHeader.height = TableHeight.BusinessDetailTableViewHeader_MAX
        tableView.parallaxHeader.minimumHeight = TableHeight.BusinessDetailTableViewHeader_MIN
        tableView.parallaxHeader.delegate = self
    }
    
    //MARK::- FUNCTIONS
    
    func getherEventDetails() -> String{
        return /("Event Details" + "\n" + /event?.title + "\n" + /event?.description + "\n" + "on " + /event?.date + "\n" + "at " + /event?.locationline1 + "\n" + /event?.locationline2 )
    }
    
    //MARK::- ACTIONS
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.popVC()
    }
    
    @IBAction func btnActionShare(_ sender: UIButton) {
        Utility.functions.shareTextImage(shareData: [getherEventDetails()])
    }
}


//MARK:- MXParralaxHeaderDelegate
extension EventDetailViewController: MXParallaxHeaderDelegate {
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        visualEffectViewHeader.alpha = 1 - parallaxHeader.progress
        visualEffectViewNavBar.isHidden = (parallaxHeader.progress != 0.0)
        visualEffectViewHeader.isHidden = (parallaxHeader.progress == 0.0)
    }
}

