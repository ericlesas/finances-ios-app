//
//  Colors.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 29/07/25.
//

import Foundation
import UIKit

public struct Colors {
	
	// MARK: - Gray
	static let gray100 = UIColor(red: 249/255, green: 251/255, blue: 249/255, alpha: 1)
	static let gray200 = UIColor(red: 239/255, green: 240/255, blue: 239/255, alpha: 1)
	static let gray300 = UIColor(red: 229/255, green: 230/255, blue: 229/255, alpha: 1)
	static let gray400 = UIColor(red: 161/255, green: 162/255, blue: 161/255, alpha: 1)
	static let gray500 = UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
	static let gray600 = UIColor(red: 73/255,  green: 74/255,  blue: 73/255,  alpha: 1)
	static let gray700 = UIColor(red: 15/255,  green: 15/255,  blue: 15/255,  alpha: 1)
	
	// MARK: - Magenta
	static let magenta = UIColor(red: 218/255, green: 75/255, blue: 221/255, alpha: 1)
	
	// MARK: - Red
	static let redAlert = UIColor(red: 217/255, green: 58/255, blue: 74/255, alpha: 1)
	
	// MARK: - Green
	static let greenSuccess = UIColor(red: 31/255, green: 163/255, blue: 66/255, alpha: 1)
	
	// MARK: - DarkGradient
	static func applyDarkGradient(to view: UIView) {
		let gradient = CAGradientLayer()
		
		let color1 = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1).cgColor
		let color2 = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1).cgColor
		
		gradient.colors = [color1, color2]
		gradient.locations = [0.0, 1.0]
		gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
		gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
		gradient.frame = view.bounds
		
		view.layer.insertSublayer(gradient, at: 0)
	}
}

// MARK: - Extension
extension UIColor {
	func light(opacity: CGFloat = 0.05) -> UIColor {
		return self.withAlphaComponent(opacity)
	}
	
	func dark(by percentage: CGFloat = 0.3) -> UIColor {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		
		return UIColor(
			red: red * (1 - percentage),
			green: green * (1 - percentage),
			blue: blue * (1 - percentage),
			alpha: alpha
		)
	}
}
