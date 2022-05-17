//
//  ProductViewCell.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import UIKit
import Alamofire

class ProductViewCell: UITableViewCell, BaseViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.productImage.image = nil
        self.productName.text = nil
        self.productPrice.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductInfo(_ product: Product?) {
        if let url = product?.imageURL {
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    self.productImage.image = UIImage(data: data)
                default: break
                }
            }
        }
        
        self.productName.text = product?.name ?? "N/A"
        self.productPrice.text = "฿ \(product?.price ?? 0)"
    }
    
}
