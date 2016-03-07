//
//  Constant.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

struct ConstantIdentifier {
	static let CellMenuItem = "Menu Item Cell"
}

struct ConstantMenuIdentifier {
	static let Arrival =	"Arrival"
	static let Departure =	"Departure"
	static let Route =		"Route"
	static let POI =		"POI"
	static let Tips =		"Tips"
	static let Appliances = "Appliances"
	static let Rules =		"Rules"
	static let Phone =		"Phone"
	static let Book =		"Book"
}

struct ConstantSegueIdentifier {
	static let Prefix = "Show "
	static func fromMenuSection(menuSection: CABMenuSection) -> String {
		return menuSection.generateSegueIdentifier()
	}
	
	static let BackgroundView = "Show Background View"
}

struct ConstantRowHeight {
	static let Small: CGFloat = 44.0
	static let Medium: CGFloat = 65.0
	static let Large: CGFloat = 80.0
}

struct ConstantMagicNumbers {
	struct MenuCellAnimation {
		static let SelectedLabelInitialAlpha: CGFloat = 0.1
		static let SelectedLabelDuration: NSTimeInterval = 0.8
		static let WelcomeLabelStartXPoint: CGFloat = -200
		static let WelcomeLabelDuration: NSTimeInterval = 1.0
		static let WelcomeLabelDamping: CGFloat = 0.8
		static let WelcomeLabelVelocity: CGFloat = 10.0
		static let WelcomeLabelBethDelay: Double = 0.1
		static let WelcomeLabelInitialAlpha: CGFloat = 0.1
		static let BackgroundSectionLabelStartXPoint: CGFloat = -500
	}
	struct MenuBackground {
		static let Size: CGSize = CGSize(width: 1, height: 300)
	}
	struct SplitView {
		static let WidthFraction: CGFloat = 0.3
		static let MinimumWidth: CGFloat = 70
	}
}