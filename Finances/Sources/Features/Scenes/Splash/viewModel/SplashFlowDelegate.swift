//
//  SplashFlowDelegate.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 28/08/25.
//

import Foundation

public protocol SplashFlowDelegate: AnyObject {
	func navigateToLogin()
	func navigateToHomeFromSplash()
}
