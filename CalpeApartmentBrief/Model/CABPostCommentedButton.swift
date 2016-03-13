//
//  CABPostCommentedButton.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABPostCommentedButton: CABPost
{
	let type = CABPostType.CommentedButton
	private(set) var comment: String?
	private(set) var buttonTitle: String
	private(set) var action: String
	
	init(comment aComment: String?, buttonTitle aButtonTitle: String, action anAction: String) {
		comment = aComment
		buttonTitle = aButtonTitle
		action = anAction
	}
}