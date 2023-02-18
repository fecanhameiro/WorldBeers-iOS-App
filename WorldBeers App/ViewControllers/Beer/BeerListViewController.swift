//
//  ViewController.swift
//  WorldBeers App
//
//  Created by Felipe C Canhameiro on 18/02/23.
//

import UIKit

class BeerListViewController: BaseViewController {
    
    @IBOutlet weak var beerTableView: UITableView!
    
    private var selectedBeer: Int?
    private let refreshControl = UIRefreshControl()
    
    var beerItems: [Beer]? {
        didSet {
            DispatchQueue.main.async {
                UIApplication.shared.applicationIconBadgeNumber = self.beerItems?.count ?? 0
                               self.beerTableView.reloadData()
                               self.refreshControl.endRefreshing()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.tintColor = .yellow
        self.refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        self.beerTableView.addSubview(refreshControl)
        self.beerTableView.dataSource = self
        self.beerTableView.delegate = self
        
        self.refreshControl.beginRefreshing()
        self.refreshData(self)
    }
    
    @objc private func refreshData(_ sender: Any) {
        DispatchQueue.global(qos: .userInitiated).async {
            BeerService().getBeerList(page: 1, perPage: 20){ (result) in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let beers):
                            self.beerItems = beers
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
        guard let items = self.beerItems else {
            return 0
        }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let beerItem = self.beerItems![indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "Beer-Cell", for: indexPath) as! BeerTableViewCell
        cell.beerTextLabel.text = beerItem.name

        return cell

    }
    
}

// MARK: UITableViewDelegate

extension BeerListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedBeer = self.beerItems![indexPath.row].id
        self.performSegue(withIdentifier: "details", sender: self)
    }
    
}
