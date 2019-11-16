//
//  HomeViewController.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    //MARK::- OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK::- PROPERTIES
    var dataSource: CollectionDataSource?
    var item: Any? {
        didSet{
            configureCollectionView()
        }
    }
    
    //MARK::- VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //handle view transition
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIScreen.main.traitCollection.userInterfaceIdiom == .phone{
            let width = (UIDevice.current.orientation.isLandscape ? (size.width - (/(UIApplication.shared.keyWindow?.safeAreaInsets.top) + /(UIApplication.shared.keyWindow?.safeAreaInsets.bottom))) : size.width)
            dataSource?.size = CGSize(width:width , height: size.width * 0.5)
            collectionView.performBatchUpdates({ [weak self] in
                self?.collectionView.reloadData()
            }) { (isCompleted) in
            }
        }else{
            let width = size.width
            let height = (width/2) * 0.5
            dataSource?.size = CGSize(width: width/2, height: height)
            collectionView.performBatchUpdates({ [weak self] in
                self?.collectionView.reloadData()
            }) { (isCompleted) in
            }
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK::- FUNCTIONS
    
    func onLoad(){
        UserPreference.shared.data == nil ? retrieveEvents() : loadCacheData()
    }
    
    func loadCacheData(){
        item = UserPreference.shared.data
    }
    
    //MARK::- CONFIGURE COLLECTIONVIEW
    func configureCollectionView(){
        
        if let businesses = (item as? [EventData]) {
            let width = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? UIScreen.main.bounds.width : (UIScreen.main.bounds.width * 0.5)
            dataSource = CollectionDataSource.init(businesses, HomeCollectionViewCell.identfier, collectionView, CGSize.init(width: width, height: width * 0.5), UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0), UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 0.0 : 0.0, 0.0)
        }
        
        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? HomeCollectionViewCell)?.item = item
        }
        
        dataSource?.didSelectItem = { (indexPath, selectedItem) in
            if let event = selectedItem as? EventData {
                let destVC = StoryboardScene.Main.EventDetailViewController.instantiate()
                destVC.event = event
                UIApplication.topVC()?.pushVC(destVC)
            }
        }
        
    }
    
}

//MARK::- API HANDLER
extension HomeViewController {
    
    func retrieveEvents() {
        HomeEP.home().request(success: { [weak self] (response) in
            //remove the object which is completely blank
            let retrievedEvents = response as? [EventData]
            let itemsWithInfo = retrievedEvents?.filter({ (event) -> Bool in
                return /event.image?.isNotBlank && /event.title?.isNotBlank && /event.locationline1?.isNotBlank && /event.locationline2?.isNotBlank && /event.description?.isNotBlank && /event.date?.isNotBlank
            })
            self?.item = itemsWithInfo
            guard let data = itemsWithInfo else { return }
            UserPreference.shared.data = data
        })
    }
}
