//
//  CABPostNumberedItemWithImage.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABPostNumberedItemWithImage: CABPost
{
	let type = CABPostType.NumberedItemWithImage
	private(set) var body: String?
	private(set) var number: String?
	private(set) var imageName: String
	
	init(body aBody: String?, number aNumber: String?, imageName anImageName: String) {
		body = aBody
		number = aNumber
		imageName = anImageName
	}
}