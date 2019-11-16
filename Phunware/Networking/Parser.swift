//
//  Parser.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    
    func parseModel(data: Data) -> Any? {
        
        print(data)
        switch self {
        case is HomeEP:
            let endpoint = self as! HomeEP
            switch endpoint {
            case .home():
                return JSONHelper<[EventData]>().getCodableModel(data: data)
                
            }
        default:
            return nil
        }
        
        
    }
}
