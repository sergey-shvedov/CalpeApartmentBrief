//
//  CABBaseBackgroundViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 07.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABBaseBackgroundViewController: UIViewController
{

	@IBOutlet weak var backgroundLabel: UILabel!
	var section: CABMenuSection?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
    }

	private func setupBackground() {
		
		if let justSection = section {
			backgroundLabel.text = CABAppResponse.sharedInstance.nameOfMenuItem(justSection)
			
		}
		
		let originalX = backgroundLabel.frame.origin.x
		
		backgroundLabel.frame.origin.x = ConstantMagicNumbers.MenuCellAnimation.BackgroundSectionLabelStartXPoint
		backgroundLabel.alpha = ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelInitialAlpha
		
		UIView.animateWithDuration(ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelDuration,
			delay: 0.0,
			usingSpringWithDamping: ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelDamping,
			initialSpringVelocity: ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelVelocity,
			options: [],
			animations: {
				self.backgroundLabel.frame.origin.x = originalX
				self.backgroundLabel.alpha = 1.0
			},
			completion: nil)
	}

}
