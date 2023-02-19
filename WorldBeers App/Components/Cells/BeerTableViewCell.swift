//
//  BeerTableViewCell.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 18/02/23.
//

import UIKit

class BeerTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameTextLabel: UILabel!
    @IBOutlet weak var beerDescriptionTextLabel: UILabel!
    @IBOutlet weak var beerABVTextLabel: UILabel!
    @IBOutlet weak var beerIBUTextLabel: UILabel!
    static let identifier = "Beer-Cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func loadValues(beer: Beer){
        
        self.cardView.cardView()
        self.beerNameTextLabel.text = beer.name
        self.beerDescriptionTextLabel.text = beer.description
        self.beerABVTextLabel.text = beer.abv != nil ? String(format: "%.1f%%", beer.abv!) : "N/A"
        self.beerIBUTextLabel.text = beer.ibu != nil ? String(format: "%.1f", beer.ibu!) : "N/A"
        
        self.beerImageView.image = nil
        if let imageUrl =  beer.imageUrl{
            if let url = URL(string: imageUrl)
            {
                self.beerImageView.loadAsync(from: url)
            }
        }
    }
    
}


