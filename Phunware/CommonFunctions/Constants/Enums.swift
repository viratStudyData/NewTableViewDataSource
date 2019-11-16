//
//  Enums.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit

enum ReInstantiatePurpose: Int {
    case Success
  
    
    var vcLinked: UIViewController {
        switch self {
        case .Success:
            return StoryboardScene.Main.initialScene.instantiate()
        }
    }
}
