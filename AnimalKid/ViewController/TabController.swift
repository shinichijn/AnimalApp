//
//  TabController.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/25/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit

class TabController:UITabBarController {

    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            print("t4st")
        }
    }



}
