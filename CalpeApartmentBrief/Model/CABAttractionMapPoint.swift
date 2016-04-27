//
//  CABAttractionMapPoint.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 27.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABAttractionMapPoint: CABMapPoint
{
	private(set) var type = CABAttractionType.Standart
	private(set) var title: String
	private(set) var body: String?
	private(set) var imageName: String?
	private(set) var isTappable = true
	
	init(latitude: Double, longitude: Double, iconName: String?, type: CABAttractionType?, title: String, body: String?, imageName: String?, isTappable: Bool?) {
		if let justType = type { self.type = justType }
		self.title = title
		self.body = body
		self.imageName = imageName
		if let justTappable = isTappable { self.isTappable = justTappable }
		super.init(latitude: latitude, longitude: longitude, withIconName: iconName)
	}
}
