//
//  CharacterTableViewCell.swift
//  Game Of Thrones Favourites
//
//  Created by Rama Rai on 2019-05-20.
//  Copyright © 2019 Rama Rai All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favorit_button: UIButton!
   
    @IBOutlet weak var character_house: UILabel!
    @IBOutlet weak var character_Name: UILabel!
    
    @IBOutlet weak var character_Image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
