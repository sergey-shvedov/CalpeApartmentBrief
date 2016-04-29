//
//  InfoMapDescriptionTableViewCell.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 29.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class InfoMapDescriptionTableViewCell: UITableViewCell {

	@IBOutlet weak var textView: UITextView!

	func configureUI(text aText: String?) {
		textView.text = aText
		backgroundColor = UIColor.clearColor()
		layoutIfNeeded()
	}

}
