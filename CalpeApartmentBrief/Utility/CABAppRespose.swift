//
//  CABAppRespose.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import MapKit

enum AppState: Int {
	case Welcome = 0
	case Primary = 1
}

class CABAppResponse
{
	static let sharedInstance = CABAppResponse()
	
	let currentTheme: CABTheme = CABThemeOrange()
	private(set) var appState: AppState = .Welcome
	
	var latestPOIViewSettings: MKCoordinateRegion?
	
	let menu: [CABMenuSection] = [
				CABMenuSection.Arrival,
				CABMenuSection.Departure,
				CABMenuSection.Route,
				CABMenuSection.POI,
				CABMenuSection.Appliances,
				CABMenuSection.Rules]
	
	var numberOfMenuItems: Int {
		return menu.count
	}
	
	func indexOfMenuItem(secton: CABMenuSection) -> Int? {
		return menu.indexOf(secton)
	}
	
	func nameOfMenuItem(secton: CABMenuSection) -> String {
		//return ""
		return NSLocalizedString(secton.name, comment: "")
	}
	
	func confirmPrimaryState() {
		if appState != .Primary {
			appState = .Primary
		}
	}
	
	
}