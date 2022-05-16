//
//  StoreInfoViewCell.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import UIKit

class StoreInfoViewCell: UITableViewCell, BaseViewCell {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeRating: UILabel!
    @IBOutlet weak var storeTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setStoreInfo(_ storeData: StoreData?) {
        self.storeName.text = storeData?.name ?? "N/A"
        self.storeRating.text = "\(storeData?.rating ?? 0.0)"
        let open = storeData?.getDisplayText(storeData?.openingTime) ?? "N/A"
        let close = storeData?.getDisplayText(storeData?.closingTime) ?? "N/A"
        self.storeTime.text = "\(open) - \(close)"
    }

}
