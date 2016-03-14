//
//  CABDataProvider.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

class CABDataProvider
{
	static let sharedInstance = CABDataProvider()
	
	private var parsedSections = [CABMenuSection: [CABPost]]()
	
	func providePostSructureForSection(section: CABMenuSection) -> [CABPost] {
		var result: [CABPost]!
		if let justPosts = parsedSections[section] {
			result = justPosts
		} else {
			let fileName = ModelConstant.PLIST.ArrivalSection
			let bundle: String? = nil
			result = parsePostsWithContentsOfFileName(fileName: fileName, bundle: bundle)
			parsedSections[section] = result
		}
		
		return result
	}
	
	private func parsePostsWithContentsOfFileName(fileName aFileName: String, bundle aBundle: String?) -> [CABPost] {
		var result = [CABPost]()
		
		if let rawArray = NSArray(contentsOfFileNamed: aFileName, inBundle: aBundle) as? Array<[String: String]> {
			for justPost in rawArray {
				if let postType = justPost[ModelConstant.Post.TypeKey] {
					
					var post: CABPost?
					
					switch postType {
					case CABPostType.Standart.rawValue :		post = createStandartPostFrom(justPost)
					case CABPostType.TitledImage.rawValue :		post = createTitledImageFrom(justPost)
					case CABPostType.TitledButton.rawValue :	post = createTitledButtonFrom(justPost)
					case CABPostType.TitledParagraph.rawValue : post = createTitledParagraphFrom(justPost)
					case CABPostType.CommentedButton.rawValue : post = createCommentedButtonFrom(justPost)
					case CABPostType.NumberedItem.rawValue :	post = createNumberedItemFrom(justPost)
					case CABPostType.NumberedItemWithImage.rawValue : post = createNumberedItemWithImageFrom(justPost)
					default : break
					}
					
					if let createdPost = post {
						result.append(createdPost)
					}
				}
			}
		}
				
		return result
	}
	
}

extension CABDataProvider {
	
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
}