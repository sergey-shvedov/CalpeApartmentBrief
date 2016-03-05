//
//  CABAppRespose.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

class CABAppResponse {
	static let sharedInstance = CABAppResponse()
	
	let currentTheme: CABTheme = CABThemeOrange()
	let numberOfMenuItems = CABMenuSection.caseCount
}