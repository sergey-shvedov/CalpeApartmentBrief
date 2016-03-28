//
//  ModelConstant.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 14.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct ModelConstant {
	struct PLIST {
		static let ArrivalSection = "CABArrivalSection.plist"
		static let DepartureSection = "CABDepartureSection.plist"
	}
	
	struct Post {
		static let TypeKey =				"Post-type"
		static let StandartTitleKey =		"Title"
		static let StandartBodyKey =		"Body"
		static let StandartImageNameKey =	"Image-name"
		static let TitledImageTitleKey =		"Title"
		static let TitledImageImageNameKey =	"Image-name"
		static let TitledButtonTitleKey =		"Title"
		static let TitledButtonButtonTitleKey =	"Button-text"
		static let TitledButtonActionKey =		"Action-id"
		static let TitledParagraphTitleKey =	"Title"
		static let TitledParagraphBodyKey =		"Body"
		static let CommentedButtonCommentKey =		"Comment"
		static let CommentedButtonButtonTitleKey =	"Button-text"
		static let CommentedButtonActionKey =		"Action-id"
		static let NumberedItemTitleKey =				"Title"
		static let NumberedItemBodyKey =				"Body"
		static let NumberedItemNumberKey =				"Number"
		static let NumberedItemIconNameKey =			"Icon-name"
		static let NumberedItemWithImageBodyKey =		"Body"
		static let NumberedItemWithImageNumberKey =		"Number"
		static let NumberedItemWithImageImageNameKey =	"Image-name"
		static let PinnedMapAnnotationsKey =			"Annotations"
		static let PinnedMapIconNameKey =				"Icon-name"
		static let PinnedMapLatitudeKey =				"Latitude"
		static let PinnedMapLongitudeKey =				"Longitude"
		static let PinnedMapCenterLatitudeKey =			"Center-latitude"
		static let PinnedMapCenterLongitudeKey =		"Center-longitude"
		static let PinnedMapSpanLatitudeKey =			"Span-latitude"
		static let PinnedMapSpanLongitudeKey =			"Span-longitude"
	}
}