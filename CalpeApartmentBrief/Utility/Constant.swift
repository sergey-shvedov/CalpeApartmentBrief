//
//  Constant.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

protocol RegionCoordinates {
	static var Latitude: Double {get}
	static var Longitude: Double {get}
	static var SpanLatitude: Double {get}
	static var SpanLongitude: Double {get}
}

struct ConstantGlobal {
	static let Prefix = "CAB"
}

struct ConstantIdentifier {
	static let CellMenuItem = "Menu Item Cell"
	static let CellRuleBlank = "Blank Cell"
	static let CellRuleArticle = "Article Cell"
	static let CellRuleThanks = "Thanks Cell"
	static let CellAppliancesBlank = "Blank Cell"
	static let CellAppliancesArticle = "Article Imaged Cell"
	static let CellAppliancesHeader = "Partition Header Cell"
	static let CellInfoDescription = "Info Map Description Cell"
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
	static let StandartPin = "StandartPin"
	static let HomeIconName = "iconHome"
}

struct ConstantIntro {
	static let ImageNames = ["intro01", "intro02", "intro03", "intro04"]
}

struct ConstantActionIdentifier {
	static let CallElena = "call-elena"
	static let ElenaNumber = "tel://+34693777099"
	static let ShowRouteSection = "show-route-section"
	static let Routing = "goto-route"
}

struct ConstantSegueIdentifier {
	static let Prefix = "Show "
	static func fromMenuSection(menuSection: CABMenuSection) -> String {
		return menuSection.generateSegueIdentifier()
	}
	static let BackgroundView = "Show Background View"
	static let RoutingMapView = "Show Route"
	static let BackToRouteView = "Back to Route"
	static let InfoView = "Show Info View"
	static let InfoContainer = "Show Info Container"
	static let BackToPOIView = "Back to POI"
}

struct ConstantNibPostIdentifier {
	static let Prefix = ConstantGlobal.Prefix
	static let Postfix = "PostView"
}

struct ConstantStoryboardIdentifier {
	static let MainStoryboard = "Main"
	static let BaseGeneratedVC = "GeneratedView"
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
	
	struct TableAppearingAnimation {
		static let Duration: NSTimeInterval = 1.0
	}

	struct SpinnerAppearingAnimation {
		static let Duration: NSTimeInterval = 2.0
		static let TargetAlpha: CGFloat = 0.5
		static let OutDuration: NSTimeInterval = 0.5
	}
	
	struct MenuBackground {
		static let Size: CGSize = CGSize(width: 1, height: 300)
	}
	

	
	struct MapView {
		static let SpanLatitude: Double = 0.100
		static let SpanLongitude: Double = 0.100
		static let MapPadding = UIEdgeInsetsMake(30.0, 30.0, 30.0, 30.0)
		static let HomeLatitude: Double = 38.657705
		static let HomeLongitude: Double = 0.0477460
		static let PointName = "Partida Garduix, 31F"
		struct RegionLocal: RegionCoordinates {
			static let Latitude: Double = 38.647721
			static let Longitude: Double = 0.053062
			static let SpanLatitude: Double = 0.055
			static let SpanLongitude: Double = 0.055
		}
		struct RegionNorth: RegionCoordinates {
			static let Latitude: Double = 38.675183
			static let Longitude: Double = -0.064085
			static let SpanLatitude: Double = 0.350
			static let SpanLongitude: Double = 0.350
		}

	}
	
	struct SplitView {
		static let WidthFraction: CGFloat = 0.3
		static let MinimumWidth: CGFloat = 70
	}
	
	struct DraggableView {
		static let OrientationRatio: CGFloat = 1.2
		static let DraggingLag: CGFloat = 1 / 5.0
		static let OutResponseRate: CGFloat = 1 / 3.0
		static let TempStep: CGFloat = 1.0
		static let MerginStep: CGFloat = 20.0
		static let ZeroStep: CGFloat = 0.0
		static let HiddenStepDelta: CGFloat = 50.0
	}
	
	struct ConstantPin {
		static func colorFromType(type: CABAttractionType) -> UIColor {
			var result = UIColor.blackColor()
			switch type {
			case .Standart:			result = UIColor.redColor()
			case .Nature:			result = UIColor(red:  33.0/255.0, green: 230.0/255.0, blue:  103.0/255.0, alpha: 1.0)
			case .Store:			result = UIColor(red: 240.0/255.0, green:  74.0/255.0, blue:  83.0/255.0, alpha: 1.0)
			case .ChineseStore:		result = UIColor(red: 248.0/255.0, green: 171.0/255.0, blue:  45.0/255.0, alpha: 1.0)
			case .Entertainment:	result = UIColor(red: 104.0/255.0, green: 196.0/255.0, blue: 185.0/255.0, alpha: 1.0)
			case .Infrastructure:	result = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1.0)
			default: break
			}
			return result
		}
	}
	
	
}