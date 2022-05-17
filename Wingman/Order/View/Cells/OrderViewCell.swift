//
//  OrderViewCell.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/18/22.
//

import UIKit
import Alamofire

class OrderViewCell: UITableViewCell, BaseViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.productImage.image = nil
        self.productName.text = nil
        self.totalPrice.text = nil
        self.quantity.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setOrderItemInfo(_ orderItem: OrderItem) {
        if let url = orderItem.product?.imageURL {
            self.productImage.image = nil
            
            AF.download(url).responseData { response in
                if let data = response.value {
                    self.productImage.image = UIImage(data: data)
                }
            }
        }
        
        self.productName.text = orderItem.product?.name ?? "N/A"
        
        let productPrice = orderItem.product?.price ?? 0
        let quantity = orderItem.quantity
        self.quantity.text = "\(quantity) x \(productPrice)"
        
        self.totalPrice.text = "฿ \(quantity * productPrice)"
    }
}
