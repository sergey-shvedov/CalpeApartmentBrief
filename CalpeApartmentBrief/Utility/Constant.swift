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
	static let Arrival = "Arrival"
	static let Departure = "Departure"
	static let Route = "Route"
	static let POI = "POI"
	static let Tips = "Tips"
	static let Appliances = "Appliances"
	static let Rules = "Rules"
	static let Phone = "Phone"
	static let Book = "Book"
}

struct ConstantRowHeight {
	static let Small: CGFloat = 44.0
	static let Medium: CGFloat = 65.0
	static let Large: CGFloat = 80.0
}

struct ConstantMagicNumbers {
	struct MenuCellAnimation {
		static let InitialAlpha: CGFloat = 0.1
		static let Duration: NSTimeInterval = 0.8
	}
	struct MenuBackground {
		static let Size: CGSize = CGSize(width: 1, height: 300)
	}
}