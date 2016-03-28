//
//  Constant.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

struct ConstantGlobal {
	static let Prefix = "CAB"
}

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

struct ConstantAnnotationIdentifier {
	static let MapPost = "MapPost"
	static let HomeIconName = "iconHome"
}

struct ConstantSegueIdentifier {
	static let Prefix = "Show "
	static func fromMenuSection(menuSection: CABMenuSection) -> String {
		return menuSection.generateSegueIdentifier()
	}
	static let BackgroundView = "Show Background View"
}

struct ConstantNibPostIdentifier {
	static let Prefix = ConstantGlobal.Prefix
	static let Postfix = "PostView"
}

struct ConstantRowHeight {
	private static let multiplier: CGFloat = 1.5
	static let Small: CGFloat = CGFloat(Int(multiplier * 44.0))
	static let Medium: CGFloat = CGFloat(Int(multiplier * 65.0))
	static let Large: CGFloat = CGFloat(Int(multiplier * 80.0))
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
	struct PostAppearingAnimation {
		static let Duration: NSTimeInterval = 0.5
		static let BethDelay: Double = 0.3
	}
	struct SpinnerAppearingAnimation {
		static let Duration: NSTimeInterval = 2.0
		static let TargetAlpha: CGFloat = 0.5
		static let OutDuration: NSTimeInterval = 0.5
	}
	struct MenuBackground {
		static let Size: CGSize = CGSize(width: 1, height: 300)
	}
	struct SplitView {
		static let WidthFraction: CGFloat = 0.3
		static let MinimumWidth: CGFloat = 70
	}
}