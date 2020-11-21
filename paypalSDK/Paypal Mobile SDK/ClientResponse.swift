//
//  ClientResponse.swift
//  paypalSDK
//
//  Created by Nouman Gul on 21/11/2020.
//

import Foundation

struct ClientResponse : Codable {
    
    let environment : String?
    let paypalSdkVersion : String?
    let platform : String?
    let productName : String?
    
    enum CodingKeys: String, CodingKey {
        case environment = "environment"
        case paypalSdkVersion = "paypal_sdk_version"
        case platform = "platform"
        case productName = "product_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        environment = try values.decodeIfPresent(String.self, forKey: .environment)
        paypalSdkVersion = try values.decodeIfPresent(String.self, forKey: .paypalSdkVersion)
        platform = try values.decodeIfPresent(String.self, forKey: .platform)
        productName = try values.decodeIfPresent(String.self, forKey: .productName)
    }
    
}
