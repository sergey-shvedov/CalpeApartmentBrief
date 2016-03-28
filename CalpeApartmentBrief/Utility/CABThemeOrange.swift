//
//  CABThemeOrange.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

struct CABThemeOrange: CABTheme {
	
	private static let startMenuColor = UIColor.init(red: 255/255, green: 213/255, blue: 36/255, alpha: 1.0)
	private static let endMenuColor =	UIColor.init(red: 255/255, green: 085/255, blue: 00/255, alpha: 1.0)
	let baseColor =	UIColor.init(red: 255/255, green: 235/255, blue: 59/255, alpha: 1.0)
	
	func colorOfMenuItemWithIndex(index: Int) -> UIColor {
		var proportion = Double(index) / Double(CABAppResponse.sharedInstance.numberOfMenuItems)
		if proportion > 1.0 { proportion = 1.0 }
		return UIColor(between: CABThemeOrange.startMenuColor, andColor: CABThemeOrange.endMenuColor, withProportion: proportion)
	}
	
	func imageForMenuBackground() -> UIImage {
		return UIImage.gradientImageFrom(CABThemeOrange.startMenuColor, toEndColor: CABThemeOrange.endMenuColor, usingVerlicalDirection: true)
	}
}