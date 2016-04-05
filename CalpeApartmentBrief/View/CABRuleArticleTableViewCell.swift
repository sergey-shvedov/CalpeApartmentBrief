//
//  CABRuleArticleTableViewCell.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 02.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABRuleArticleTableViewCell: UITableViewCell
{

	@IBOutlet weak var numberLabel: UILabel!
	@IBOutlet weak var textView: UITextView!

	func configureUI(numberItem aNumber: String, text aText: String) {
		numberLabel.text = aNumber
		textView.text = aText
	}
	
}
