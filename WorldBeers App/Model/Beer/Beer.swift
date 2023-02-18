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
    let imageUrl: String
    let abv: Double
    let ibu: Double
    let targetFg: Double
    let targetOg: Double
    let ebc: Double
    let srm: Double
    let ph: Double
    let attenuationLevel: Double
    let volume: Volume
    let boilVolume: Volume
    let method: Method
    let ingredients: Ingredients
    let foodPairing: [String]
    let brewersTips: String
    let contributedBy: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, firstBrewed = "first_brewed", description, imageUrl = "image_url", abv, ibu, targetFg = "target_fg", targetOg = "target_og", ebc, srm, ph, attenuationLevel = "attenuation_level", volume, boilVolume = "boil_volume", method, ingredients, foodPairing = "food_pairing", brewersTips = "brewers_tips", contributedBy = "contributed_by"
    }
}

struct Volume: Codable {
    let value: Int
    let unit: String
}

struct Method: Codable {
    let mashTemp: [MashTemp]
    let fermentation: Fermentation
    let twist: String?
    
    struct MashTemp: Codable {
        let temp: Temp
        let duration: Int
        
        struct Temp: Codable {
            let value: Double
            let unit: String
        }
    }
    
    struct Fermentation: Codable {
        let temp: Temp
        
        struct Temp: Codable {
            let value: Double
            let unit: String
        }
    }
}

struct Ingredients: Codable {
    let malt: [Malt]
    let hops: [Hops]
    let yeast: String
    
    struct Malt: Codable {
        let name: String
        let amount: Amount
        
        struct Amount: Codable {
            let value: Double
            let unit: String
        }
    }
    
    struct Hops: Codable {
        let name: String
        let amount: Amount
        let add: String
        let attribute: String
        
        struct Amount: Codable {
            let value: Double
            let unit: String
        }
    }
}
