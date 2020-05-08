//
//  TableViewCell.swift
//  AnimalKid
//
//  Created by ACN-LPT279 on 2/27/20.
//  Copyright © 2020 ACN. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    
    
    @IBOutlet weak var imageBox: UIImageView!
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
              imageBox.image = UIImage(named: animal.imageName)
        }
        else
        {
            //  imageBox.image = animal.image
            imageBox.image = UIImage(data: animal?.image! as! Data)
        }
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
