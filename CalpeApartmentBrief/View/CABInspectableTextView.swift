//
//  CABInspectableTextView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 10.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

@IBDesignable
class CABInspectableTextView: UITextView
{
	
	@IBInspectable
	var topInset: CGFloat = 0
	@IBInspectable
	var leftInset: CGFloat = 0
	@IBInspectable
	var bottomInset: CGFloat = 0
	@IBInspectable
	var rightInset: CGFloat = 0
	
	override func awakeFromNib() {
		super.awakeFromNib()
		updateUI()
	}
	
	override func prepareForInterfaceBuilder() {
		updateUI()
	}
	
	private func updateUI() {
		textContainerInset = UIEdgeInsetsMake(topInset, leftInset, bottomInset, rightInset);
	}
}
