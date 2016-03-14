//
//  CABNumberedItemWithImagePostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABNumberedItemWithImagePostView: CABSuperPostView, CABPostViewConfigurable
{

	@IBOutlet weak var bodyTextView: UITextView!
	@IBOutlet weak var numberLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	
	override func configureUI() {
		if let justPost = post as? CABPostNumberedItemWithImage {
			bodyTextView.text = justPost.body
			numberLabel.text = justPost.number
			imageView.image = UIImage(named: justPost.imageName)
		}
	}

}
