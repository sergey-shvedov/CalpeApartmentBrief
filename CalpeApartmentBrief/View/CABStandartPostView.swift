//
//  CABStandartPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 08.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABStandartPostView: CABSuperPostView, CABPostViewConfigurable
{
	
	@IBOutlet weak var titleLabel: CABInspectableLabel!
	@IBOutlet weak var bodyTextField: UITextView!
	@IBOutlet weak var imageView: UIImageView!
	
	override func configureUI() {
		if let justPost = post as? CABPostStandart {
			titleLabel.text = justPost.title
			bodyTextField.text = justPost.body
			imageView.image = UIImage(named: justPost.imageName)
		}
	}
	
}
