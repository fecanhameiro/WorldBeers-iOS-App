//
//  BeerDetailsViewController.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 19/02/23.
//

import UIKit

class BeerDetailsViewController: UIViewController {
    
    @IBOutlet weak var beerFirstBrewedTextLabel: UILabel!
    @IBOutlet weak var beerFoodPairingTextLabel: UILabel!
    @IBOutlet weak var beerBrewersTipsTextLabel: UILabel!
    
    var beerName: String?
    var beerFirstBrewed: String?
    var beerFoodPairing: [String]?
    var beerBrewersTips: String?

    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.title = self.beerName ?? "Details"
        self.beerFirstBrewedTextLabel.text = self.beerFirstBrewed ?? "N/A"
        self.beerFoodPairingTextLabel.text = self.beerFoodPairing?.joined(separator: "\n") ?? "N/A"

        self.beerBrewersTipsTextLabel.text = self.beerBrewersTips ?? "N/A"
    }
    

}
