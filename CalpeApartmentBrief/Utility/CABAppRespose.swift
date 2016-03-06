//
//  CABAppRespose.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

enum AppState: Int {
	case Welcome = 0
	case Primary = 1
}

class CABAppResponse
{
	static let sharedInstance = CABAppResponse()
	
	let currentTheme: CABTheme = CABThemeOrange()
	let numberOfMenuItems = CABMenuSection.caseCount
	private(set) var appState: AppState = .Welcome
	
	func confirmPrimaryState() {
		if appState != .Primary {
			appState = .Primary
		}
	}
}