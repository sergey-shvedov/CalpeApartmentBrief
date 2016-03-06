//
//  UIImage+Extension.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

extension UIImage
{
	class func gradientImageFrom(startColor: UIColor, toEndColor endColor: UIColor, usingVerlicalDirection direction: Bool) -> UIImage {
		
		var result = UIImage()
		
		let layer = CAGradientLayer()
		layer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: ConstantMagicNumbers.MenuBackground.Size)
		layer.colors = [startColor.CGColor, endColor.CGColor]
		layer.locations = [0.0 , 1.0]
		
		switch direction{
		case true:	layer.startPoint = CGPoint(x: 0.5, y: 0.0); layer.endPoint = CGPoint(x: 0.5, y: 1.0)
		case false: layer.startPoint = CGPoint(x: 0.0, y: 0.5); layer.endPoint = CGPoint(x: 1.0, y: 0.5)
		}
		
		UIGraphicsBeginImageContext(ConstantMagicNumbers.MenuBackground.Size)
		if let context = UIGraphicsGetCurrentContext() {
			layer.renderInContext(context)
			result = UIGraphicsGetImageFromCurrentImageContext()
		}

		UIGraphicsEndImageContext()
		
		return result
	}
}