//
//  CABRoundView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 12.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

@IBDesignable
class CABRoundView: UIView
{
	
	override func layoutSubviews() {
		super.layoutSubviews()
		updateUI()
	}
	
	override func prepareForInterfaceBuilder() {
		updateUI()
	}
	
	private func updateUI() {
		layer.cornerRadius = frame.width / 2
	}

}
