//
//  ProductViewCell.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import UIKit
import Alamofire

protocol ProductViewCellDelegate: AnyObject {
    func doAddProduct(_ product: Product?, quantity: Int)
}

class ProductViewCell: UITableViewCell, BaseViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    private(set) var currentQuantity: Int = 0 {
        didSet {
            self.quantity.text = "\(self.currentQuantity)"
        }
    }
    
    private var product: Product?
    
    weak var delegate: ProductViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.productImage.image = nil
        self.productName.text = nil
        self.productPrice.text = nil
        self.currentQuantity = 0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setProductInfo(_ product: Product?) {
        self.product = product
        
        if let url = product?.imageURL {
            self.productImage.image = nil
            AF.download(url).responseData { response in
                if let data = response.value {
                    self.productImage.image = UIImage(data: data)
                }
            }
        }
        
        self.productName.text = product?.name ?? "N/A"
        self.productPrice.text = "฿ \(product?.price ?? 0)"
    }
    
    @IBAction func doMinus(_ sender: UIButton) {
        guard self.currentQuantity > 0 else {
            return
        }
        
        self.currentQuantity = self.currentQuantity - 1
        self.delegate?.doAddProduct(self.product, quantity: self.currentQuantity)
    }
    
    @IBAction func doPlus(_ sender: UIButton) {
        self.currentQuantity = self.currentQuantity + 1
        self.delegate?.doAddProduct(self.product, quantity: self.currentQuantity)
    }
}
