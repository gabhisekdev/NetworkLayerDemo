//
//  RestaurantTableCell.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 17/08/19.
//  Copyright © 2019 G Abhisek. All rights reserved.
//

import UIKit

class RestaurantTableCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var vicinityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(with restaurant: Restaurant) {
        restaurantNameLabel.text = restaurant.name
        vicinityLabel.text = restaurant.vicinity
    }

}
