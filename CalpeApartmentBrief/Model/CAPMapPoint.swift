//
//  CAPMapPoint.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 19.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import MapKit

class CABMapPoint: NSObject, MKAnnotation
{
	var latitude: Double
	var longitude: Double
	
	var coordinate: CLLocationCoordinate2D {
		return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}
	
	init(latitude: Double, longitude: Double) {
		self.latitude = latitude
		self.longitude = longitude
		super.init()
	}
}