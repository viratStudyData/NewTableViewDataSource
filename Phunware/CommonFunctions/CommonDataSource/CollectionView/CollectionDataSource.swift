//
//  CollectionDataSource.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import UIKit

class CollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    typealias  DidSelectedItem = (_ indexPath : IndexPath, _ item: Any?) -> Void
    typealias  ListCellConfigureBlock = (_ cell : UICollectionViewCell , _ item : Any?, _ indexpath: IndexPath) -> ()
    
    var items: Array<Any>?
    private var identifier: String?
    private var collectionView: UICollectionView?
    var size: CGSize?
    private var edgeInsets: UIEdgeInsets?
    private var minLineSpacing: CGFloat?
    private var minInterItemSpacing: CGFloat?
    
    var didSelectItem: DidSelectedItem?
    var configureCell: ListCellConfigureBlock?
    
    init(_ _items: Array<Any>?, _ _identifier: String?, _ _collectionView: UICollectionView, _ _size: CGSize?, _ _edgeInsets: UIEdgeInsets?, _ _lineSpacing: CGFloat?, _ _interItemSpacing: CGFloat?) {
        super.init()
        items = _items
        identifier = _identifier
        collectionView = _collectionView
        size = _size
        edgeInsets = _edgeInsets
        minLineSpacing = _lineSpacing
        minInterItemSpacing = _interItemSpacing
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.reloadData()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier ?? "", for: indexPath)
        configureCell?(cell, items?[indexPath.item], indexPath)
        return cell
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets ?? UIEdgeInsets.zero
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minLineSpacing ?? CGFloat.leastNonzeroMagnitude
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minInterItemSpacing ?? CGFloat.leastNonzeroMagnitude
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size ?? CGSize.zero
    }
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath, items?[indexPath.item])
    }
}
