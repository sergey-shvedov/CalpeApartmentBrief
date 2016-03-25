//
//  CABPostType.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 08.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

enum CABPostType: String {
	case Standart
	case TitledImage
	case TitledButton
	case TitledParagraph
	case CommentedButton
	case NumberedItem
	case NumberedItemWithImage
	case PinnedMap
	
	var nibIdentifier: String {
		return ConstantNibPostIdentifier.Prefix + self.rawValue + ConstantNibPostIdentifier.Postfix
	}
}