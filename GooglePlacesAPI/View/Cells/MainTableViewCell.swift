//
//  MainTableViewCell.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 07.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    func setup(for sight: PlaceModel){
        nameLabel.text = sight.name
        ratingLabel.text = String(sight.rating)
        let imageurl = sight.photos[0].photo_reference
        mainImageView.sd_setImage(with: URL(string: Endpoints.getImageURL(referense: imageurl)), completed: nil)
    }
    

}
