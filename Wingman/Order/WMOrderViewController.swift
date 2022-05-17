//
//  WMOrderViewController.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/17/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift HELM Xcode Templates
//  https://github.com/HelmMobile/clean-swift-templates

import UIKit

protocol WMOrderViewControllerInput {
    
}

protocol WMOrderViewControllerOutput {
    
}

class WMOrderViewController: UIViewController, WMOrderViewControllerInput {
    
    var output: WMOrderViewControllerOutput?
    var router: WMOrderRouter?
    
    // MARK: Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        WMOrderConfigurator.sharedInstance.configure(viewController: self)
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Requests
    
    
    // MARK: Display logic
    
}

//This should be on configurator but for some reason storyboard doesn't detect ViewController's name if placed there
extension WMOrderViewController: WMOrderPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.passDataToNextScene(for: segue)
    }
}
