//
//  CABTableArticleWithImage.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 02.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABTableArticleWithImage
{
	private(set) var title: String?
	private(set) var body: String
	private(set) var imageName: String
	
	init(title aTitle: String?, body aBody: String, imageName anImageName: String) {
		title = aTitle
		body = aBody
		imageName = anImageName
	}

}