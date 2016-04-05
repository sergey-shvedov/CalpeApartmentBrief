//
//  CABTablePartition.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 02.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABTablePartition
{
	private(set) var articles: [CABTableArticleWithImage]
	private(set) var title: String?
	private(set) var comment: String?
	
	init(articles anArticles: [CABTableArticleWithImage], title aTitle: String?, comment aComment: String?) {
		articles = anArticles
		title = aTitle
		comment = aComment
	}
}