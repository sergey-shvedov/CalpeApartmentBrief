//
//  CABDataProvider+Attraction.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 28.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

extension CABDataProvider
{
	func provideBasedAttractionsForSection(section: CABMenuSection) -> [CABAttractionMapPoint] {
		var result = [CABAttractionMapPoint]()
		if let justAttractions = parsedAttractions[section] {
			result = justAttractions
		} else {
			var fileName: String?
			switch section {
			case .POI: fileName = ModelConstant.PLIST.POISection
			default : break
			}
			if let justFileName = fileName {
				let bundle: String? = nil
				result = parseAttractionsWithContentsOfFileName(fileName: justFileName, bundle: bundle)
				parsedAttractions[section] = result
			}
		}
		
		return result
	}
	
	private func parseAttractionsWithContentsOfFileName(fileName aFileName: String, bundle aBundle: String?) -> [CABAttractionMapPoint] {
		
		var result = [CABAttractionMapPoint]()
		
		if let rawArray = NSArray(contentsOfFileNamed: aFileName, inBundle: aBundle) as? Array<[String: AnyObject]> {
			for justRawAttraction in rawArray {
				if let justAttraction = createAttractionFrom(justRawAttraction) {
					result.append(justAttraction)
				}
			}
		}
		
		return result
	}
	
	private func createAttractionFrom(aDictionary: Dictionary<String, AnyObject>) -> CABAttractionMapPoint? {
		var result: CABAttractionMapPoint?
		
		let iconName = aDictionary[ModelConstant.Attraction.IconNameKey] as? String
		let rawLatitude = aDictionary[ModelConstant.Attraction.LatitudeKey] as? String
		let rawLongitude = aDictionary[ModelConstant.Attraction.LongitudeKey] as? String
		let type = aDictionary[ModelConstant.Attraction.TypeKey] as? String
		let title = aDictionary[ModelConstant.Attraction.TitleKey] as? String
		let body = aDictionary[ModelConstant.Attraction.BodyKey] as? String
		let imageName = aDictionary[ModelConstant.Attraction.ImageNameKey] as? String
		let isTappable = aDictionary[ModelConstant.Attraction.TappableKey] as? Bool
		let id = aDictionary[ModelConstant.Attraction.ImageNameKey] as? String
		
		if let justRawLatitude = rawLatitude, let justRawLongitude = rawLongitude, justLatitude = Double(justRawLatitude), let justLongitude = Double(justRawLongitude), let justTitle = title
		{
			let attractionType = convertToAttractionType(type)
			result = CABAttractionMapPoint(latitude: justLatitude, longitude: justLongitude, iconName: iconName, type: attractionType, title: justTitle, body: body, imageName: imageName, isTappable: isTappable, id: id)
		} else {
			print("Latitude, Longitude and Title are required to create CABAttractionMapPoint")
		}
		
		return result
	}
	
	private func convertToAttractionType(string: String?) -> CABAttractionType {
		var result = CABAttractionType.Standart
		if let justString = string {
			switch justString {
			case CABAttractionType.Home.rawValue: result = .Home
			case CABAttractionType.Nature.rawValue: result = .Nature
			case CABAttractionType.Store.rawValue: result = .Store
			case CABAttractionType.Standart.rawValue: result = .Standart
			case CABAttractionType.ChineseStore.rawValue: result = .ChineseStore
			case CABAttractionType.Entertainment.rawValue: result = .Entertainment
			case CABAttractionType.Infrastructure.rawValue: result = .Infrastructure
			default: break
			}
		}
		return result
	}
	
}