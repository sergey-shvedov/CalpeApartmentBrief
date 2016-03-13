//
//  CABPostTitledButton.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABPostTitledButton: CABPost
{
	let type = CABPostType.TitledButton
	private(set) var title: String?
	private(set) var buttonTitle: String
	private(set) var action: String
	
	init(title aTitle: String?, buttonTitle aButtonTitle: String, action anAction: String) {
		title = aTitle
		buttonTitle = aButtonTitle
		action = anAction
	}
}