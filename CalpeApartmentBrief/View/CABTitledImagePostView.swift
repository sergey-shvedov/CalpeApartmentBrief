//
//  CABTitledImagePostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 09.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABTitledImagePostView: CABSuperPostView, CABPostViewConfigurable
{

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!

	override func configureUI() {
		if let justPost = post as? CABPostTitledImage {
			titleLabel.text = justPost.title
			imageView.image = UIImage(named: justPost.imageName)
		}
	}
}
