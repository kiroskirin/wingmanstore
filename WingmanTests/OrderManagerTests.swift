//
//  OrderManagerTests.swift
//  WingmanTests
//
//  Created by Kraisorn Soisakhu on 5/18/22.
//

import XCTest
@testable import Wingman

class OrderManagerTests: XCTestCase {
    
    var productA: Product?
    var productB: Product?
        
    override func setUp() {
        super.setUp()
        
        let jsonA: [String: Any] = [
            "name": "Latte",
            "price": 50,
            "imageUrl": "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg"
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonA, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(Product.self, from: data)
            
            self.productA = model
            
        } catch let e {
            print(e.localizedDescription)
        }
        
        let jsonB: [String: Any] = [
            "name": "Coffee",
            "price": 20,
            "imageUrl": "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg"
        ]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonB, options: .fragmentsAllowed)
            let model = try JSONDecoder().decode(Product.self, from: data)
            
            self.productB = model
            
        } catch let e {
            print(e.localizedDescription)
        }
    }

    func testAddOrderItemWithNoProductToOrder() throws {
        
        let orderItem1 = OrderItem(product: nil, quantity: 0)
        let orderItem2 = OrderItem(product: nil, quantity: 1)
        let orderItem3 = OrderItem(product: nil, quantity: 2)
        
        WMOrderManager.shared.addItemToOrder(orderItem1)
        WMOrderManager.shared.addItemToOrder(orderItem2)
        WMOrderManager.shared.addItemToOrder(orderItem3)
        
        let orderCount = WMOrderManager.shared.listOrders.count
        XCTAssertEqual(orderCount, 0, "Order without product should not be list")
    }

    func testAddOrderItemToOrder() throws {
        let orderItem1 = OrderItem(product: self.productA, quantity: 1)
        
        WMOrderManager.shared.addItemToOrder(orderItem1)
        
        let orderCount = WMOrderManager.shared.listOrders.count
        
        XCTAssertEqual(orderCount, 1, "Order should have 1 item")
    }
    
    func testAddSameOrderItemWithDifferenceQuantityToOrder() throws {
        let orderItem1 = OrderItem(product: self.productA, quantity: 1)
        let orderItem2 = OrderItem(product: self.productA, quantity: 2)
        
        WMOrderManager.shared.addItemToOrder(orderItem1)
        WMOrderManager.shared.addItemToOrder(orderItem2)
        
        let orderCount = WMOrderManager.shared.listOrders.count
        
        XCTAssertEqual(orderCount, 1, "Order should have 1 item")
        
        let orderItem = WMOrderManager.shared.listOrders.first
        XCTAssertEqual(orderItem?.quantity, 2, "Quantity should be the latest one")
    }
    
    func testAddMultipleOrderItemToOrder() throws {
        let orderItem1 = OrderItem(product: self.productA, quantity: 1)
        let orderItem2 = OrderItem(product: self.productB, quantity: 1)
        
        WMOrderManager.shared.addItemToOrder(orderItem1)
        WMOrderManager.shared.addItemToOrder(orderItem2)
        
        let orderCount = WMOrderManager.shared.listOrders.count
        
        XCTAssertEqual(orderCount, 2, "Order should have 2 item")
    }
    
    func testOrderSumTotal() throws {
        let orderItem1 = OrderItem(product: self.productA, quantity: 1)
        
        WMOrderManager.shared.addItemToOrder(orderItem1)
        
        let sumSingleItem = WMOrderManager.shared.sumTotalPrice
        
        XCTAssertEqual(sumSingleItem, 50, "Sum total should be 50 -> (1*50) ")
        
        let orderItem2 = OrderItem(product: self.productB, quantity: 2)
        WMOrderManager.shared.addItemToOrder(orderItem2)
        
        let sumTotal = WMOrderManager.shared.sumTotalPrice
        XCTAssertEqual(sumTotal, 90, "Sum total should be 90 -> (1*50 + 2*20) ")
    }
}
