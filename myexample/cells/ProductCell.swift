//
//  ProductCell.swift
//  myexample
//
//  Created by Luis Humberto Carlin Vargas on 18/10/23.
//

import UIKit

class ProductCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func configure(with product: Product) {
        nameLabel.text = product.title
        priceLabel.text = "$\(product.price)"
    }
}
