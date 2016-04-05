//
//  CABAppliancesHeaderTableViewCell.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 04.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABAppliancesHeaderTableViewCell: UITableViewCell
{
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var commentLabel: UILabel!
	
	func configureUI(title aTitle: String?, comment aComment: String?) {
		titleLabel.text = aTitle
		commentLabel.text = aComment
		backgroundColor = UIColor.clearColor()
		layoutIfNeeded()
	}
	
}
