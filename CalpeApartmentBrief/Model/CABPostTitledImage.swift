//
//  CABPostTitledImage.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABPostTitledImage: CABPost
{
	let type = CABPostType.TitledImage
	private(set) var title: String?
	private(set) var imageName: String
	
	init(title aTitle: String?, imageName anImageName: String) {
		title = aTitle
		imageName = anImageName
	}
}