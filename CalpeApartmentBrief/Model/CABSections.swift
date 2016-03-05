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
	
	func favoriteColor() -> UIColor {
		
		return CABAppResponse.sharedInstance.currentTheme.colorOfMenuItemWithIndex(self.rawValue)
	}
	
	static let caseCount: Int = {
		var max = 0
		while let _ = CABMenuSection(rawValue: ++max) {}
		return max
	}()
}