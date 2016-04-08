//
//  CABDataProvider.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import MapKit

class CABDataProvider
{
	static let sharedInstance = CABDataProvider()
	
	lazy private var parsedSections = [CABMenuSection: [CABPost]]()
	lazy private var parsedArticles = [CABMenuSection: [String]]()
	lazy private var parsedPartitions = [CABMenuSection: [CABTablePartition]]()
	
	// MARK: Parsing Post Objects
	
	func providePostSructureForSection(section: CABMenuSection) -> [CABPost] {
		var result: [CABPost]!
		if let justPosts = parsedSections[section] {
			result = justPosts
		} else {
			var fileName = ModelConstant.PLIST.ArrivalSection
			switch section {
			case .Arrival: fileName = ModelConstant.PLIST.ArrivalSection
			case .Departure: fileName = ModelConstant.PLIST.DepartureSection
			case .Route: fileName = ModelConstant.PLIST.RouteSection
			default : fileName = ModelConstant.PLIST.DepartureSection
			}
			let bundle: String? = nil
			result = parsePostsWithContentsOfFileName(fileName: fileName, bundle: bundle)
			parsedSections[section] = result
		}
		
		return result
	}
	
	private func parsePostsWithContentsOfFileName(fileName aFileName: String, bundle aBundle: String?) -> [CABPost] {
		var result = [CABPost]()
		
		if let rawArray = NSArray(contentsOfFileNamed: aFileName, inBundle: aBundle) as? Array<[String: AnyObject]> {
			for justPost in rawArray {
				if let postType = justPost[ModelConstant.Post.TypeKey] as? String {
					
					var post: CABPost?
					
					if let justStringPost = justPost as? [String: String] {
						switch postType {
						case CABPostType.Standart.rawValue :		post = createStandartPostFrom(justStringPost)
						case CABPostType.TitledImage.rawValue :		post = createTitledImageFrom(justStringPost)
						case CABPostType.TitledButton.rawValue :	post = createTitledButtonFrom(justStringPost)
						case CABPostType.TitledParagraph.rawValue : post = createTitledParagraphFrom(justStringPost)
						case CABPostType.CommentedButton.rawValue : post = createCommentedButtonFrom(justStringPost)
						case CABPostType.NumberedItem.rawValue :	post = createNumberedItemFrom(justStringPost)
						case CABPostType.NumberedItemWithImage.rawValue : post = createNumberedItemWithImageFrom(justStringPost)
						default : break
						}
					} else {
						switch postType {
						case CABPostType.PinnedMap.rawValue :		post = createPinnedMapFrom(justPost)
						default : break
						}
					}
					
					if let createdPost = post {
						result.append(createdPost)
					}
				}
			}
		}
				
		return result
	}
	
	// MARK: Parsing Table Objects
	
	func provideArticlesForSection(section: CABMenuSection) -> [String] {
		var result = [String]()
		if let justArticles = parsedArticles[section] {
			result = justArticles
		} else {
			var fileName: String?
			switch section {
			case .Rules: fileName = ModelConstant.PLIST.RulesSection
			default : break
			}
			if let justFileName = fileName {
				let bundle: String? = nil
				result = parseArticlesWithContentsOfFileName(fileName: justFileName, bundle: bundle)
				parsedArticles[section] = result
			}
		}
		
		return result
	}

	private func parseArticlesWithContentsOfFileName(fileName aFileName: String, bundle aBundle: String?) -> [String] {
		var result = [String]()
		
		if let justArticles = NSArray(contentsOfFileNamed: aFileName, inBundle: aBundle) as? Array<String> {
			result = justArticles
		}
		
		return result
	}
	
	func provideTablePartitionsForSection(section: CABMenuSection) -> [CABTablePartition] {
		var result = [CABTablePartition]()
		if let justPartitions = parsedPartitions[section] {
			result = justPartitions
		} else {
			var fileName: String?
			switch section {
			case .Appliances: fileName = ModelConstant.PLIST.AppliancesSection
			default : break
			}
			if let justFileName = fileName {
				let bundle: String? = nil
				result = parsePartitionsWithContentsOfFileName(fileName: justFileName, bundle: bundle)
				parsedPartitions[section] = result
			}
		}
		
		return result
	}
	
	private func parsePartitionsWithContentsOfFileName(fileName aFileName: String, bundle aBundle: String?) -> [CABTablePartition] {
		var result = [CABTablePartition]()
		
		if let rawArray = NSArray(contentsOfFileNamed: aFileName, inBundle: aBundle) as? Array<[String: AnyObject]> {
			for justRawPartition in rawArray {
				if let justPartition = createPartitionTableArticlesFrom(justRawPartition) {
					result.append(justPartition)
				}
			}
		}
		
		return result
	}
	
}

extension CABDataProvider {
	
	// MARK: Creating Post Objects
	
	private func createStandartPostFrom(aDictionary: Dictionary<String, String>) -> CABPostStandart? {
		var result: CABPostStandart?
		
		let title = aDictionary[ModelConstant.Post.StandartTitleKey]
		let body = aDictionary[ModelConstant.Post.StandartBodyKey]
		let imageName = aDictionary[ModelConstant.Post.StandartImageNameKey]
		
		if let justImageName = imageName {
			result = CABPostStandart(title: title, body: body, imageName: justImageName)
		} else {
			print("ImageName is required to create StandartPost")
		}
		
		return result
	}
	
	private func createTitledImageFrom(aDictionary: Dictionary<String, String>) -> CABPostTitledImage? {
		var result: CABPostTitledImage?
		
		let title = aDictionary[ModelConstant.Post.TitledImageTitleKey]
		let imageName = aDictionary[ModelConstant.Post.TitledImageImageNameKey]
		
		if let justImageName = imageName {
			result = CABPostTitledImage(title: title, imageName: justImageName)
		} else {
			print("ImageName is required to create TitledImagePost")
		}
		
		return result
	}
	
	private func createTitledButtonFrom(aDictionary: Dictionary<String, String>) -> CABPostTitledButton? {
		var result: CABPostTitledButton?
		
		let title = aDictionary[ModelConstant.Post.TitledButtonTitleKey]
		let buttonTitle = aDictionary[ModelConstant.Post.TitledButtonButtonTitleKey]
		let action = aDictionary[ModelConstant.Post.TitledButtonActionKey]
		
		if let justButtonTitle = buttonTitle, let justAction = action {
			result = CABPostTitledButton(title: title, buttonTitle: justButtonTitle, action: justAction)
		} else {
			print("ButtonTitle and Action are required to create TitledButtonPost")
		}
		
		return result
	}
	
	private func createTitledParagraphFrom(aDictionary: Dictionary<String, String>) -> CABPostTitledParagraph? {
		var result: CABPostTitledParagraph?
		
		let title = aDictionary[ModelConstant.Post.TitledParagraphTitleKey]
		let body = aDictionary[ModelConstant.Post.TitledParagraphBodyKey]
		
		result = CABPostTitledParagraph(title: title, body: body)
		
		return result
	}
	
	private func createCommentedButtonFrom(aDictionary: Dictionary<String, String>) -> CABPostCommentedButton? {
		var result: CABPostCommentedButton?
		
		let comment = aDictionary[ModelConstant.Post.CommentedButtonCommentKey]
		let buttonTitle = aDictionary[ModelConstant.Post.CommentedButtonButtonTitleKey]
		let action = aDictionary[ModelConstant.Post.CommentedButtonActionKey]
		
		if let justButtonTitle = buttonTitle, let justAction = action {
			result = CABPostCommentedButton(comment: comment, buttonTitle: justButtonTitle, action: justAction)
		} else {
			print("ButtonTitle and Action are required to create CommentedButtonPost")
		}
		
		return result
	}
	
	private func createNumberedItemFrom(aDictionary: Dictionary<String, String>) -> CABPostNumberedItem? {
		var result: CABPostNumberedItem?
		
		let title = aDictionary[ModelConstant.Post.NumberedItemTitleKey]
		let body = aDictionary[ModelConstant.Post.NumberedItemBodyKey]
		let number = aDictionary[ModelConstant.Post.NumberedItemNumberKey]
		let iconName = aDictionary[ModelConstant.Post.NumberedItemIconNameKey]
		
		result = CABPostNumberedItem(title: title, body: body, number: number, iconName: iconName)
		
		return result
	}
	
	private func createNumberedItemWithImageFrom(aDictionary: Dictionary<String, String>) -> CABPostNumberedItemWithImage? {
		var result: CABPostNumberedItemWithImage?
		
		let body = aDictionary[ModelConstant.Post.NumberedItemWithImageBodyKey]
		let number = aDictionary[ModelConstant.Post.NumberedItemWithImageNumberKey]
		let imageName = aDictionary[ModelConstant.Post.NumberedItemWithImageImageNameKey]
		
		if let justImageName = imageName {
			result = CABPostNumberedItemWithImage(body: body, number: number, imageName: justImageName)
		} else {
			print("ImageName is required to create NumberedItemWithImagePost")
		}
		
		return result
	}
	
	// MARK: Creating Map Objects
	
	private func createPinnedMapFrom(aDictionary: Dictionary<String, AnyObject>) -> CABPostPinnedMap? {
		var result: CABPostPinnedMap?
		
		if let rawAnnotations = aDictionary[ModelConstant.Post.PinnedMapAnnotationsKey] as? Array<Dictionary<String, String>> {
			var annotations = [CABMapPoint]()
			for nextRawAnnotation in rawAnnotations {
				if let rawLatitude = nextRawAnnotation[ModelConstant.Post.PinnedMapLatitudeKey],
					let rawLongitude = nextRawAnnotation[ModelConstant.Post.PinnedMapLongitudeKey],
					let justLatitude = Double(rawLatitude),
					let justLongitude = Double(rawLongitude)
				{
					let iconName = nextRawAnnotation[ModelConstant.Post.PinnedMapIconNameKey]
					annotations.append(CABMapPoint(latitude: justLatitude, longitude: justLongitude, withIconName: iconName))
				}
			}
			
			var region: MKCoordinateRegion?
			if let rawCenterLatitude = aDictionary[ModelConstant.Post.PinnedMapCenterLatitudeKey] as? String,
				let rawCenterLongitude = aDictionary[ModelConstant.Post.PinnedMapCenterLongitudeKey] as? String,
				let rawSpanLatitude = aDictionary[ModelConstant.Post.PinnedMapSpanLatitudeKey] as? String,
				let rawSpanLongitude = aDictionary[ModelConstant.Post.PinnedMapSpanLongitudeKey] as? String,
				let justCenterLatitude = Double(rawCenterLatitude),
				let justCenterLongitude = Double(rawCenterLongitude),
				let justSpanLatitude = Double(rawSpanLatitude),
				let justSpanLongitude = Double(rawSpanLongitude)
			{
				region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: justCenterLatitude, longitude: justCenterLongitude), span: MKCoordinateSpanMake(justSpanLatitude, justSpanLongitude))
			}
			
			result = CABPostPinnedMap(annotations: annotations, region: region)
		}
		
		return result
	}
	
	// MARK: Creating Table Objects
	
	private func createPartitionTableArticlesFrom(aDictionary: Dictionary<String, AnyObject>) -> CABTablePartition? {
		var result: CABTablePartition?
		
		let title = aDictionary[ModelConstant.TableArticle.PartitionTitleKey] as? String
		let comment = aDictionary[ModelConstant.TableArticle.PartitionCommentKey] as? String
		
		if let rawArticles = aDictionary[ModelConstant.TableArticle.PartitionArticlesKey] as? Array<Dictionary<String, String>> {
			var articles = [CABTableArticleWithImage]()
			for nextRawArticle in rawArticles {
				if let justArticle = createTableArticleFrom(nextRawArticle) {
					articles.append(justArticle)
				}
			}
			
			result = CABTablePartition(articles: articles, title: title, comment: comment)
		} else {
			print("Articles are required to create CABTablePartition")
		}
		
		return result
	}
	
	private func createTableArticleFrom(aDictionary: Dictionary<String, String>) -> CABTableArticleWithImage? {
		var result: CABTableArticleWithImage?
		
		let title = aDictionary[ModelConstant.TableArticle.TitleKey]
		
		if let justBody = aDictionary[ModelConstant.TableArticle.BodyKey],
			let justImageName = aDictionary[ModelConstant.TableArticle.ImageNameKey]
		{
			result = CABTableArticleWithImage(title: title, body: justBody, imageName: justImageName)
			
		} else {
			print("Body and ImageName are required to create CABTableArticleWithImage")
		}
		
		return result
	}
	
}