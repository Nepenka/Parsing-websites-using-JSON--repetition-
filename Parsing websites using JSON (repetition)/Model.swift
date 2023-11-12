//
//  Model.swift
//  Parsing websites using JSON (repetition)
//
//  Created by 123 on 12.11.23.
//

import Foundation


struct BitcoinPrice: Codable {
    let time: BitcoinTime
    let bpi: BitcoinPriceIndex
}

struct BitcoinTime: Codable {
    let updated: String
}

struct BitcoinPriceIndex: Codable {
    let USD: BitcoinRate
  
}

struct BitcoinRate: Codable {
    let rate: String
}

