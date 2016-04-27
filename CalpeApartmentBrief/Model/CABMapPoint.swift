//
//  CABMapPoint.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 19.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import MapKit

class CABMapPoint: NSObject, MKAnnotation
{
	private var latitude: Double
	private var longitude: Double
	private(set) var iconName: String?
	
	var coordinate: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	init(latitude: Double, longitude: Double, withIconName iconName: String?) {
		self.latitude = latitude
		self.longitude = longitude
		self.iconName = iconName
		super.init()
	}
}