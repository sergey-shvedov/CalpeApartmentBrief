//
//  UIColor+Extension.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
	
	convenience init(between startColor: UIColor, andColor endColor: UIColor, withProportion proportion: Double) {
		var startRed:	CGFloat = 0
		var startGreen: CGFloat = 0
		var startBlue:	CGFloat = 0
		var startAlpha: CGFloat = 0
		var endRed:		CGFloat = 0
		var endGreen:	CGFloat = 0
		var endBlue:	CGFloat = 0
		var endAlpha:	CGFloat = 0
		startColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
		endColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
		
		let share = CGFloat( fabs(proportion) > 1 ? (1 / fabs(proportion)) :  fabs(proportion) )
		
		
		func newComponentFrom(start: CGFloat, end: CGFloat, share: CGFloat) -> CGFloat {
			return start + (end - start) * share
		}
		
		let newRed = newComponentFrom(startRed, end: endRed, share: share)
		let newGreen = newComponentFrom(startGreen, end: endGreen, share: share)
		let newBlue = newComponentFrom(startBlue, end: endBlue, share: share)
		let newAlpha = newComponentFrom(startAlpha, end: endAlpha, share: share)
		
		self.init(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
	}
	
}
