//
//  detailTypeCellTableViewCell.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 3/4/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit

class detailTypeCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageViewBox: UIImageView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var animal: animalM! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI()
    {
        typeLabel.text = animal.typeName
        if (animal.image == nil)
        {
            imageViewBox.image = UIImage(named: animal.imageName)
        }
        else
        {
            //  imageBox.image = animal.image
            imageViewBox.image = UIImage(data: animal?.image! as! Data)
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
