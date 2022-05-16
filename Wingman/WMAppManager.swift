//
//  WMAppManager.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//

import Foundation
import UIKit

class WMAppManager {
    static let shared = WMAppManager()
    
    enum TabBarType: Int {
        case store = 0
        
        var title: String {
            switch self {
            case .store: return "Store"
            }
        }
    }
    
    func tabBar() -> UITabBarController {
        let tabBarView = UITabBarController()
        let viewControllers: [UIViewController?] = [
            storeView()
        ]
        
        tabBarView.viewControllers = viewControllers.compactMap { $0 }
        tabBarView.tabBar.isTranslucent = false
        tabBarView.view.backgroundColor = .white
        
        return tabBarView
    }
}

extension WMAppManager {
    func storeView() -> UIViewController? {
        guard let view: WMStoreViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WMStoreViewController") as? WMStoreViewController else {
            return nil
        }
        
        let tabbar = TabBarType.store
        view.tabBarItem = UITabBarItem(title: tabbar.title, image: UIImage(named: "store"), tag: tabbar.rawValue)
        view.hidesBottomBarWhenPushed = false
        view.title = tabbar.title
        
        return embededInNavigationController(view)
    }
}

extension WMAppManager {
    private func embededInNavigationController(_ view: UIViewController) -> UIViewController {
        return UINavigationController(rootViewController: view)
    }
}
