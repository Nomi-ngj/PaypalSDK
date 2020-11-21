//
//  SucessResponse.swift
//  paypalSDK
//
//  Created by Nouman Gul on 21/11/2020.
//

import Foundation

struct SucessResponse : Codable {
    
    let createTime : String?
    let id : String?
    let intent : String?
    let orderId : String?
    let state : String?
    
    enum CodingKeys: String, CodingKey {
        case createTime = "create_time"
        case id = "id"
        case intent = "intent"
        case orderId = "order_id"
        case state = "state"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createTime = try values.decodeIfPresent(String.self, forKey: .createTime)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        intent = try values.decodeIfPresent(String.self, forKey: .intent)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        state = try values.decodeIfPresent(String.self, forKey: .state)
    }
    
}
