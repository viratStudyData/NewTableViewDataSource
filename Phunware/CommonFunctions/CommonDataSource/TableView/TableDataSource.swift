//
//  File.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import UIKit

enum TableType<T : HeaderFooterDataProvider, U> {
  case SingleListing(items: [U], identifier: String, height: CGFloat)
  case MultipleSection(items: [T])
}

enum UpdateType<T: HeaderFooterDataProvider, U> {
  case SingleListing(items: [U])
  case MultipleSection(items: [T])
}

enum ReloadType {
  case FullReload
  case ReloadSectionAt(indexSet: IndexSet, animation: UITableView.RowAnimation)
  case Reload(indexPaths: [IndexPath], animation: UITableView.RowAnimation)
  case ReloadSectionTitles
  case None
}

enum ScrollDirection {
  case Up
  case Down
}

class TableDataSource<T : HeaderFooterDataProvider>: NSObject, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
  
  private var tableView: UITableView?
  private var items = Array<T>()
  private var tableType: TableType<T, Any>?
  private var identifier: String?
  private var height: CGFloat?
  
  typealias  DidSelectedRow = (_ indexPath : IndexPath, _ item: Any?) -> Void
  typealias  ViewForHeaderFooterInSection = (_ section : Int, _ headerFooterItem: T, _ view: UIView, _ isHeader: Bool) -> Void
  typealias  ListCellConfigureBlock = (_ cell : UITableViewCell , _ item : Any?, _ indexpath: IndexPath, _ property: HeaderFooterValues?) -> ()
  typealias DirectionForScroll = (_ direction: ScrollDirection) -> Void
  
  var didSelectRow: DidSelectedRow?
  var configureHeaderFooter: ViewForHeaderFooterInSection?
  var configureCell: ListCellConfigureBlock?
  var scrollDirection: DirectionForScroll?
  
  init(_ _type: TableType<T, Any>, _ _tableView: UITableView) {
    super.init()
    tableType = _type
    tableView = _tableView
    switch _type {
    case .SingleListing(let _items, let _identifier, let _height):
      identifier = _identifier
      height = _height
      items = HeaderFooterData.getSingleSectionItems(items: _items, id: _identifier, height: _height) as! [T]
    case .MultipleSection(let _items):
      items = _items
    }
    tableView?.delegate = self
    tableView?.dataSource = self
    tableView?.reloadData()
  }

  public func updateAndReload(for type: UpdateType<T, Any>, _ reloadType: ReloadType) {
    switch type {
    case .SingleListing(let _items):
      items = HeaderFooterData.getSingleSectionItems(items: _items, id: identifier ?? "", height: height ?? 0.0) as! [T]
    case .MultipleSection(let _items):
      items = _items
    }
    reloadTableView(type: reloadType)
  }
  
  private func reloadTableView(type: ReloadType) {
    switch type {
    case .FullReload:
      tableView?.reloadData()
    case .Reload(let indexPaths, let animation):
      tableView?.reloadRows(at: indexPaths, with: animation)
    case .ReloadSectionAt(let indexSet, let animation):
      tableView?.reloadSections(indexSet, with: animation)
    case .ReloadSectionTitles:
      tableView?.reloadSectionIndexTitles()
    case .None:
      break
    }
  }
  
  internal func numberOfSections(in tableView: UITableView) -> Int {
    return items.count
  }
  
  internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items[section].items?.count ?? 0
  }
  
  internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let item = items[section]
    guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.property?.headerIdentifier ?? "") else {
      return nil
    }
    configureHeaderFooter?(section, item, headerView, true)
    return headerView
  }
  
  internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let property = items[indexPath.section].property
    let cell = tableView.dequeueReusableCell(withIdentifier: property?.cellIdentifier ?? "", for: indexPath)
    configureCell?(cell, items[indexPath.section].items?[indexPath.row], indexPath, property)
    return cell
  }
  
  internal func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let item = items[section]
    guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.property?.footerIdentifier ?? "") else {
      return nil
    }
    configureHeaderFooter?(section, item, footerView, false)
    return footerView
  }
  
  internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return items[section].property?.headerHeight ?? 0.0001
  }
  
  internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return items[section].property?.footerHeight ?? 0.0001
  }
  
  internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return items[indexPath.section].property?.cellHeight ?? UITableView.automaticDimension
  }
  
  internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    didSelectRow?(indexPath, items[indexPath.section].items?[indexPath.row])
  }
  
  internal func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    switch velocity {
    case _ where velocity.y < 0:
      // swipes from top to bottom of screen -> down
      scrollDirection?(.Down)
    case _ where velocity.y > 0:
      // swipes from bottom to top of screen -> up
      scrollDirection?(.Up)
    default: break
    }
  }
  
}
