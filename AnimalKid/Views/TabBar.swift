//
//  TabBar.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/25/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit

class TabBar: UITabBar {

    
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(size)
        size.height = 70
        return size
        
    }

}
