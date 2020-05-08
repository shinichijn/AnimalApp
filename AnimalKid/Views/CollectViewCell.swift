//
//  CollectViewCell.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 3/3/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit






class CollectViewCell: UICollectionViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var typeText: UILabel!
    var data:animalCatgs? {
        didSet{
            setup()
        }
    }
    
    
   
   
    
    func setup(){
//        imageCell.image = UIImage(named: data!)
//
//        print(UIImage(named: data!))
        imageCell.backgroundColor = data?.color
        typeText.text = data?.type
        typeText.textColor = UIColor.white
        
        

        
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
