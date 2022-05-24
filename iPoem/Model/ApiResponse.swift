//
//  ApiResponse.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/23.
//

import Foundation

struct TokenResponse: Codable {
    var status: String
    var data: String
    
//    enum CodingKeys: String, CodingKey {
//        case token = "data"
//    }
}

struct SentenceResponse: Codable {
    var status: String
    var data: Data
    
    struct Data: Codable {
        var origin: Origin
        var matchTags: [String]
    }
    
    struct Origin: Codable {
        var title: String
        var dynasty: String
        var author: String
        var content: [String]
    }
    
    
   
}


