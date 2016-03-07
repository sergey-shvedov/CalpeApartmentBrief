//
//  CABSections.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

enum CABMenuSection: Int {
	case Arrival = 0
	case Departure
	case Route
	case POI
	case Tips
	case Appliances
	case Rules
	case Phone
	case Book
	
	static let caseCount: Int = {
		var max = 0
		while let _ = CABMenuSection(rawValue: ++max) {}
		return max
	}()
	
	var name: String {
		var result = ""
		switch self {
		case .Arrival:		result = ConstantMenuIdentifier.Arrival
		case .Departure:	result = ConstantMenuIdentifier.Departure
		case .Route:		result = ConstantMenuIdentifier.Route
		case .POI:			result = ConstantMenuIdentifier.POI
		case .Tips:			result = ConstantMenuIdentifier.Tips
		case .Appliances:	result = ConstantMenuIdentifier.Appliances
		case .Rules:		result = ConstantMenuIdentifier.Rules
		case .Phone:		result = ConstantMenuIdentifier.Phone
		case .Book:			result = ConstantMenuIdentifier.Book
		}
		return result
	}
	
	func generateSegueIdentifier() -> String {
		return ConstantSegueIdentifier.Prefix + self.name
	}
	
	func favoriteColor() -> UIColor {
		
		return CABAppResponse.sharedInstance.currentTheme.colorOfMenuItemWithIndex(self.rawValue)
	}
	
	
}