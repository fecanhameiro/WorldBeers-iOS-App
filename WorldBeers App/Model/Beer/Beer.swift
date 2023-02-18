//
//  Beer.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 18/02/23.
//

import Foundation

struct Beer: Codable {
    let id: Int
    let name: String
    let tagline: String
    let firstBrewed: String
    let description: String
    let imageUrl: String?
    let abv: Double?
    let ibu: Double?
    let targetFg: Double?
    let targetOg: Double?
    let ebc: Double?
    let srm: Double?
    let ph: Double?
    let attenuationLevel: Double?
    let volume: Volume
    let boilVolume: BoilVolume
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, description, abv, ibu, ebc, srm, ph, volume, method, ingredients
        case firstBrewed = "first_brewed"
        case imageUrl = "image_url"
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case attenuationLevel = "attenuation_level"
        case boilVolume = "boil_volume"
        case contributedBy = "contributed_by"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
}

struct Volume: Codable {
    let value: Int?
    let unit: String
}

struct BoilVolume: Codable {
    let value: Int?
    let unit: String
}

struct Method: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

struct MashTemp: Codable {
    let temp: Temp
    let duration: Int?
}

struct Temp: Codable {
    let value: Int?
    let unit: String
}

struct Fermentation: Codable {
    let temp: Temp
}

struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hop]
    let yeast: String
}

struct Malt: Codable {
    let name: String
    let amount: Amount
}

struct Hop: Codable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String
}

struct Amount: Codable {
    let value: Double?
    let unit: String
}
