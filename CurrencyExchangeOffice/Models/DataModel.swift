//
//  DataModel.swift
//  CurrencyExchangeOffice
//
//  Created by Leszek Baca on 06/09/2024.
//

import Foundation

struct DataModel: Codable {
    let id: String
    let name: String
    let min_size: String
}

struct MainModel: Codable {
    let data: [DataModel]
}
