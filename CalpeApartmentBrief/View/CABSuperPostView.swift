//
//  CABSuperPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 08.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

protocol CABPostViewConfigurable {
	func configureUI()
}

@IBDesignable
class CABSuperPostView: UIView
{
	var view: UIView!
	private(set) var post: CABPost?
	
	class func instanceFromPostType(postType: CABPostType) -> UIView? {
		return UINib(nibName: postType.nibIdentifier, bundle: nil).instantiateWithOwner(nil, options: nil)[0] as? UIView
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupNib()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupNib()
	}
	
	func attachData(post aPost: CABPost) {
		post = aPost
	}
	
	private func setupNib() {
		view = loadViewFromNib()
		
		view.frame = bounds
		view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
		addSubview(view)
	}
	
	private func loadViewFromNib() -> UIView {
		let nibName = String(self.dynamicType)
		let bundle = NSBundle(forClass: self.dynamicType)
		let nib = UINib(nibName: nibName, bundle: bundle)
		let view = nib.instantiateWithOwner(self, options: nil)[0] as? UIView
		if nil == view { print("Insantiation from '\(nibName)' nib file failed!") } else {print("+")}
		
		let result = (nil != view ? view! : UIView())
		return result
	}
	
	func configureUI() {
		print("configureUI() – Must be called on a subclass of CABSuperPostView")
	}
	
	func configureUIWithData(post aPost: CABPost) {
		post = aPost
		configureUI()
	}
	
	func fitText(string: String) -> String {
		return string
	}
	
	func fitImage(imageName: String) -> UIImage? {
		return UIImage(named: imageName)
	}
	
	

}
