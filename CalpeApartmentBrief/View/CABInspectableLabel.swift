//
//  CABInspectableLabel.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 08.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

@IBDesignable
class CABInspectableLabel: UILabel
{
	
	@IBInspectable
	var topInset: CGFloat = 0
	@IBInspectable
	var leftInset: CGFloat = 0
	@IBInspectable
	var bottomInset: CGFloat = 0
	@IBInspectable
	var rightInset: CGFloat = 0
	
	override func drawTextInRect(rect: CGRect) {
		let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
		super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
	}
}
