//
//  UITextField+Extensions.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 13/10/25.
//

import Foundation
import UIKit

extension UITextField {
	
	func setPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
		if let leftPadding = left {
			let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: frame.height))
			leftView = paddingView
			leftViewMode = .always
		}
		
		if let rightPadding = right {
			let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: frame.height))
			rightView = paddingView
			rightViewMode = .always
		}
	}
	
	func setImageView(_ imageView: UIImageView, position: PlaceholderImagePosition, padding: CGFloat = 12) {
		let imageWidth = imageView.frame.width
		let containerWidth = imageWidth + padding * 2
		
		let containerView = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: frame.height))
		imageView.frame = CGRect(x: padding, y: (frame.height - imageView.frame.height) / 2, width: imageWidth, height: imageView.frame.height)
		imageView.contentMode = .center
		containerView.addSubview(imageView)
		
		switch position {
		case .left:
			leftView = containerView
			leftViewMode = .always
		case .right:
			rightView = containerView
			rightViewMode = .always
		}
	}
}
