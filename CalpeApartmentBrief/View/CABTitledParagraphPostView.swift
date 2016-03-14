//
//  CABTitledParagraphPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 14.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABTitledParagraphPostView: CABSuperPostView, CABPostViewConfigurable
{

	@IBOutlet weak var titleLeftTextView: UITextView!
	@IBOutlet weak var titleRightTextView: UITextView!
	@IBOutlet weak var bodyTextView: UITextView!

	override func configureUI() {
		if let justPost = post as? CABPostTitledParagraph {
			titleLeftTextView.text = justPost.title
			titleRightTextView.text = justPost.title
			bodyTextView.text = justPost.body
		}
	}
}
