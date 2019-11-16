//
//  EndPoint.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import Foundation
import Moya

enum HomeEP {
    case home()
    
}

extension HomeEP: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        return URL(string: APIConstant.basePath)!
    }
    
    var path: String {
        switch self {
        case .home(_):
            return APIConstant.home
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .home():
            return .get
            
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return Task.requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
        }
    }
    
    var headers: [String : String]? {
        switch self {
            
        default: return nil
        }
    }
    
    var authorizationType: AuthorizationType {
        return .bearer
    }
    
    //Custom Varaibles
    
    var parameters: [String: Any]? {
        
        switch self {
        default:
            return [:]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .home():
            return URLEncoding.queryString
            //        default:
            //            return JSONEncoding.default
        }
    }
    
    
    var multipartBody: [MultipartFormData]? {
        switch self {
            
        default:
            return []
        }
    }
}

