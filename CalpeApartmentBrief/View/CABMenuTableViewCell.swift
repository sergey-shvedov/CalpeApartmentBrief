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
	
	private(set) var section: CABMenuSection?
	
	func configureBasedOn(menuSection: CABMenuSection) {
		
		self.section = menuSection
		
		self.backgroundColor = menuSection.favoriteColor()
		let selectedBackgroundColor = UIColor(between: menuSection.favoriteColor(), andColor: UIColor.yellowColor(), withProportion: 0.5)

		let bkgView = UIView()
		bkgView.backgroundColor = selectedBackgroundColor
		bkgView.layer.masksToBounds = true
		self.selectedBackgroundView = bkgView
		
		nameLabel.text = CABAppResponse.sharedInstance.nameOfMenuItem(menuSection)
		
		if CABAppResponse.sharedInstance.appState == AppState.Welcome {
			let originalX = nameLabel.frame.origin.x
			
			nameLabel.frame.origin.x = ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelStartXPoint
			nameLabel.alpha = ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelInitialAlpha
			
			UIView.animateWithDuration(ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelDuration,
				delay: NSTimeInterval(Double(menuSection.rawValue) * ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelBethDelay),
				usingSpringWithDamping: ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelDamping,
				initialSpringVelocity: ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelVelocity,
				options: [],
				animations: {
					self.nameLabel.frame.origin.x = originalX
					self.nameLabel.alpha = 1.0
				},
				completion: nil)
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

		switch selected {
		case true:
			nameLabel.textColor = UIColor.blackColor()
			nameLabel.alpha = ConstantMagicNumbers.MenuCellAnimation.SelectedLabelInitialAlpha
			UIView.animateWithDuration(ConstantMagicNumbers.MenuCellAnimation.SelectedLabelDuration) { self.nameLabel.alpha = 1.0 }
		case false: nameLabel.textColor = UIColor.whiteColor()
		}
    }

}
