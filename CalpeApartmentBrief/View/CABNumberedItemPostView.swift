//
//  CABNumberedItemPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 14.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABNumberedItemPostView: CABSuperPostView, CABPostViewConfigurable
{

	@IBOutlet weak var titleLabel: CABInspectableLabel!
	@IBOutlet weak var bodyTextView: UITextView!
	@IBOutlet weak var numberLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	
	override func configureUI() {
		if let justPost = post as? CABPostNumberedItem {
			titleLabel.text = justPost.title
			bodyTextView.text = justPost.body
			if let justIconName = justPost.iconName {
				iconImageView.image = UIImage(named: justIconName)
				numberLabel.text = nil
			} else {
				iconImageView.image = nil
				numberLabel.text = justPost.number
			}
		}
	}
}
