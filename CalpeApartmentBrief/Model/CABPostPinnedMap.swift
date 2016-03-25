//
//  CABPostPinnedMap.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 19.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

struct CABPostPinnedMap: CABPost
{
	let type = CABPostType.PinnedMap
	
	private(set) var mapPoint: CABMapPoint
	
	init(latitude aLatitude: Double, longitude aLongitude: Double) {
		mapPoint = CABMapPoint(latitude: aLatitude, longitude: aLongitude)
	}
}