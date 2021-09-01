//
//  Country.swift
//  Know Your Country
//
//  Created by Abilash Francis on 29/8/21.
//

import Foundation

struct Country: Codable {
    let alpha2Code: String
    let name: String
    let flag: String
    let region: String
    let capital: String
    let latlng: [Double]
    let languages: [Language]?
    let currencies: [Currency]?
    let numericCode: String?
    let area: Double?
    let population: Int?
}

struct Language: Codable {
    let name: String?
}

struct Currency: Codable {
    let name: String?
}

