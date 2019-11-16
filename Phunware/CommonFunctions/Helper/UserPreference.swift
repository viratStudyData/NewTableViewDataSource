//
//  UserPreference.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 MAC_MINI_6. All rights reserved.
//

import Foundation

class UserPreference {
  
  let DEFAULTS_KEY = "PHUN_KEYS"
  
  static let shared = UserPreference()
  
  var data : [EventData]? {
    get{
      return fetchData()
    }
    set{
      if let value = newValue {
        saveData(value)
      } else {
        removeData()
      }
    }
  }
  
  func saveData(_ value: [EventData]) {
    guard let data = JSONHelper<[EventData]>().getData(model: value) else {
      removeData()
      return
    }
    UserDefaults.standard.set(data, forKey: DEFAULTS_KEY)
  }
  
  func fetchData() -> [EventData]? {
    guard let data = UserDefaults.standard.data(forKey: DEFAULTS_KEY) else {
      return nil
    }
    return JSONHelper<[EventData]>().getCodableModel(data: data)
  }
  
  func removeData() {
    UserDefaults.standard.removeObject(forKey: DEFAULTS_KEY)
  }
}

