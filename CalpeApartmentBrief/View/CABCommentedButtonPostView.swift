//
//  CABCommentedButtonPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 14.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABCommentedButtonPostView: CABSuperPostView, CABPostViewConfigurable
{

	@IBOutlet weak var commentTextView: UITextView!
	@IBOutlet weak var button: UIButton!
	weak var delegate: CABButtonPostViewDelegate?

	@IBAction func tappedButton(sender: UIButton) {
		if let justPost = post as? CABPostCommentedButton {
			delegate?.performActionWithIdentifier(justPost.action)
		}
	}
	
	override func configureUI() {
		if let justPost = post as? CABPostCommentedButton {
			commentTextView.text = justPost.comment
			button.setTitle(justPost.buttonTitle, forState: .Normal)
		}
	}
}
