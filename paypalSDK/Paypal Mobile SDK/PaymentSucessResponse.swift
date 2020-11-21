//
//  PaymentSucessResponse.swift
//  paypalSDK
//
//  Created by Nouman Gul on 21/11/2020.
//

import Foundation

struct PaymentSucessResponse : Codable {
    
    let client : ClientResponse?
    let response : SucessResponse?
    let responseType : String?
    
    enum CodingKeys: String, CodingKey {
        case client = "client"
        case response = "response"
        case responseType = "response_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        client = try values.decodeIfPresent(ClientResponse.self, forKey: .client)
        responseType = try values.decodeIfPresent(String.self, forKey: .responseType)
        response = try values.decodeIfPresent(SucessResponse.self, forKey: .response)
    }
    
}
