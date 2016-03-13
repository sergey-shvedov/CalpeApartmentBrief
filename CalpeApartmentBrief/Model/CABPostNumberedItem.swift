//
//  CABPostNumberedItem.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABPostNumberedItem: CABPost
{
	let type = CABPostType.NumberedItem
	private(set) var title: String?
	private(set) var body: String?
	private(set) var number: String?
	private(set) var iconName: String?
	
	init(title aTitle: String?, body aBody: String?, number aNumber: String?, iconName anIconName: String?) {
		title = aTitle
		body = aBody
		number = aNumber
		iconName = anIconName
	}
}