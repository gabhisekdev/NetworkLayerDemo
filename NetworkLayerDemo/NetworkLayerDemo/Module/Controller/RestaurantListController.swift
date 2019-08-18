//
//  RestaurantListController.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 17/08/19.
//  Copyright © 2019 G Abhisek. All rights reserved.
//

import UIKit

class RestaurantListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    
    private var restaurantList: [Restaurant] = []
    private var fetchSession: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.locationAvailable(notification:)), name: Notification.Name("LocationAvailable"), object: nil)
    }
    
    private func fetchNearbyRestaurants() {
        if !(fetchSession?.progress.isFinished ?? true) {
            return
        }
        showLoader()
        let queryModel = RestaurantAPIQueryParamModel(coordinate: LocationManager.sharedManager.userCurrentCoordinate, lookupRadius: 200)
        fetchSession = RestaurantServiceRequests().getAllNearbyRestaurant(apiQueryModel: queryModel) { [weak self] apiResult in
            self?.fetchSession = nil
            DispatchQueue.main.async {
                self?.hideLoader()
                switch apiResult {
                case .success(let restaurantList):
                    self?.restaurantList = restaurantList
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showAPIError(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAPIError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let refreshAction = UIAlertAction(title: "Refresh", style: .default) { [weak self] alertAction in
            self?.tableView.reloadData()
        }
        alertController.addAction(okAction)
        alertController.addAction(refreshAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showLoader() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    private func hideLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        tableView.isHidden = false
    }
    
    /// Handler to observe notification events from LocationManager.
    @objc private func locationAvailable(notification: Notification) {
        fetchNearbyRestaurants()
    }

}

extension RestaurantListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurantCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableCell", for: indexPath) as! RestaurantTableCell
        restaurantCell.updateCell(with: restaurantList[indexPath.row])
        return restaurantCell
    }
}

