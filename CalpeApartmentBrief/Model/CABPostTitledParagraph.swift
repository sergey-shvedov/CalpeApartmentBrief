//
//  CABPostTitledParagraph.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABPostTitledParagraph: CABPost
{
	let type = CABPostType.TitledParagraph
	private(set) var title: String?
	private(set) var body: String?
	
	init(type aType: CABPostType, title aTitle: String?, body aBody: String?) {
		title = aTitle
		body = aBody
	}
}