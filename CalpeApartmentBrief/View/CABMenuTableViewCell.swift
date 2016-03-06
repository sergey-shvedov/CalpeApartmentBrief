//
//  CABMenuTableViewCell.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABMenuTableViewCell: UITableViewCell
{

	@IBOutlet private weak var nameLabel: UILabel!
	
	func configureBasedOn(menuSection: CABMenuSection) {
		self.backgroundColor = menuSection.favoriteColor()
		let selectedBackgroundColor = UIColor(between: menuSection.favoriteColor(), andColor: UIColor.yellowColor(), withProportion: 0.5)

		let bkgView = UIView()
		bkgView.backgroundColor = selectedBackgroundColor
		bkgView.layer.masksToBounds = true
		self.selectedBackgroundView = bkgView
		
		nameLabel.text = menuSection.name
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

		switch selected {
		case true: nameLabel.textColor = UIColor.blackColor()
		case false: nameLabel.textColor = UIColor.whiteColor()
		}
    }

}
