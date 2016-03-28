//
//  CABPostPinnedMap.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 19.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import MapKit

struct CABPostPinnedMap: CABPost
{
	let type = CABPostType.PinnedMap
	
	private(set) var annotations: [CABMapPoint]
	private(set) var region: MKCoordinateRegion?
	init(annotations anAnnotations: [CABMapPoint], region aRegion: MKCoordinateRegion?) {
		annotations = anAnnotations
		region = aRegion
	}
}