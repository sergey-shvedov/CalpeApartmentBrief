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
	
	private(set) var annotations: [CABMapPoint]
	
	init(annotations anAnnotations: [CABMapPoint]) {
		annotations = anAnnotations
	}
}