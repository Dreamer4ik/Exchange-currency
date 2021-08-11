//
//  Implements.swift
//  Currency change
//
//  Created by Ivan Potapenko on 23.07.2021.
//

import Foundation

//struct Currency {
//    var ccy: String = "USD"
//    var baseCcy: String = "UAH"
//    var buy: Double = 27.05
//    var sale: Double = 27.20
//}


struct Currency: Codable {
    var ccy: String?
    var baseCcy: String?
    var buy: String?
    var sale: String?
    
    enum CodingKeys: String, CodingKey {
        case ccy
        case baseCcy = "base_ccy"
        case buy
        case sale
    }
}




