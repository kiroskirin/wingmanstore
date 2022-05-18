//
//  WMOrderManager.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import Foundation

class WMOrderManager {
    static let shared = WMOrderManager()
    
    private var orders: [OrderItem] = []
    
    func addItemToOrder(_ item: OrderItem) {
        self.removeItemFromOrder(item)
        guard item.quantity > 0 else { return }
        self.orders.append(item)
    }
    
    func removeItemFromOrder(_ item: OrderItem) {
        guard let index = self.orders.lastIndex(where: { order in
            return order.product?.name == item.product?.name
        }) else {
            return
        }
        
        self.orders.remove(at: index)
    }
    
    func clearOrder() {
        self.orders = []
    }
}

extension WMOrderManager {
    var listOrders: [OrderItem] {
        return self.orders.filter { $0.product != nil }
    }
    
    var sumTotalPrice: Int {
        let sum = self.listOrders.reduce(0) {
            let price = $1.product?.price ?? 0
            let quantity = $1.quantity
            return $0 + (price * quantity)
        }
        
        return sum
    }
}

// MARK: Order Item

struct OrderItem {
    let product: Product?
    let quantity: Int
}
