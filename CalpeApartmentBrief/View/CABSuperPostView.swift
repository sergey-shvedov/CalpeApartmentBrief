//
//  CABSuperPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 08.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABSuperPostView: UIView
{
	class func instanceFromPostType(postType: CABPostType) -> UIView? {
		return UINib(nibName: postType.nibIdentifier, bundle: nil).instantiateWithOwner(nil, options: nil)[0] as? UIView
	}

}
