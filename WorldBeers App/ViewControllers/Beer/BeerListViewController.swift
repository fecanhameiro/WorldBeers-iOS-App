//
//  ViewController.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 18/02/23.
//

import UIKit

class BeerListViewController: BaseViewController  {
    
    @IBOutlet weak var beerSearchBar: UISearchBar!
    @IBOutlet weak var beerTableView: UITableView!
    
    private var selectedBeer: Int?
    private let refreshControl = UIRefreshControl()
    private var searchTimer: Timer?
 
    var filteredBeerItems: [Beer] = []
    var beerItems: [Beer]? {
        didSet {
            DispatchQueue.main.async {
                self.beerTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.tintColor = .yellow
        self.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        self.beerSearchBar.delegate = self
        
        self.beerTableView.addSubview(refreshControl)
        self.beerTableView.dataSource = self
        self.beerTableView.delegate = self

        self.refreshControl.beginRefreshing()
        self.refreshData(self)
    }
    
    @objc private func refreshData(_ sender: Any) {
        DispatchQueue.global(qos: .userInitiated).async {
            BeerService().getBeerList(){ (result) in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let beers):
                            self.beerItems = beers
                            self.filteredBeerItems = beers
                        case .failure(_):
                            self.alertMessageBox(title: "Error", message: "Error on api")
                    }
                }
            }
        }
    }
    
    
    
}



extension BeerListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBeerItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let beerItem = self.filteredBeerItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as! BeerTableViewCell
        cell.loadValues(beer: beerItem)
        
        return cell
        
    }
    
}

// MARK: UISearchBarDelegate

extension BeerListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTimer?.invalidate()
        
        // Start a new search timer with a delay of 1 second
        self.searchTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
            if searchText.isEmpty {
                // If search bar is empty, show all beers
                self.filteredBeerItems = self.beerItems ?? []
            } else {
                // Filter beers by name or description containing search text
                self.filteredBeerItems = self.beerItems?.filter { beer in
                    let searchTextLowercased = searchText.lowercased()
                    return beer.name.lowercased().contains(searchTextLowercased) || beer.description.lowercased().contains(searchTextLowercased)
                } ?? []
            }
            
            self.beerTableView.reloadData()
        })
    }
}

// MARK: UITableViewDelegate

extension BeerListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBeer = self.filteredBeerItems[indexPath.row].id
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
}
