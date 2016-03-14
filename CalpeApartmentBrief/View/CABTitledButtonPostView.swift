//
//  CABTitledButtonPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 14.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABTitledButtonPostView: CABSuperPostView, CABPostViewConfigurable
{

	@IBOutlet weak var titleLeftTextView: UITextView!
	@IBOutlet weak var titleRightTextView: UITextView!
	@IBOutlet weak var button: UIButton!

	@IBAction func tappedButton(sender: UIButton) {
		
	}
	
	override func configureUI() {
		if let justPost = post as? CABPostTitledButton {
			titleLeftTextView.text = justPost.title
			titleLeftTextView.text = justPost.title
			button.setTitle(justPost.buttonTitle, forState: .Normal)
		}
	}

}
