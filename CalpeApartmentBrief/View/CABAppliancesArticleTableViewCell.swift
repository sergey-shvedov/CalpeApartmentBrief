//
//  CABAppliancesArticleTableViewCell.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 02.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABAppliancesArticleTableViewCell: UITableViewCell
{
	var article: CABTableArticleWithImage?
	
	@IBOutlet weak var articleImage: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var bodyTextView: UITextView!
	
	func configureUI(article anArticle: CABTableArticleWithImage) {
		article = anArticle
		
		articleImage.image = UIImage(named: anArticle.imageName)
		titleLabel.text = anArticle.title
		bodyTextView.text = anArticle.body
		backgroundColor = UIColor.clearColor()
	}
	
}
