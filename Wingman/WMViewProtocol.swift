//
//  ViewProtocol.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import UIKit

protocol CellProtocol {
    static var nib: UINib { get }
    static var identifier: String { get }
}

protocol BaseViewCell: CellProtocol {}

// Table view cell
extension BaseViewCell where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }

    static var identifier: String {
        return "\(Self.self)"
    }
}

// Table view header footer
extension BaseViewCell where Self: UITableViewHeaderFooterView {
    static var nib: UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }

    static var identifier: String {
        return "\(Self.self)"
    }
}
