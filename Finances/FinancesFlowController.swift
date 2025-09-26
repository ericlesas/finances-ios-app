//
//  FinancesFlowController.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 28/08/25.
//

import Foundation
import UIKit

class FinancesFlowController {
	
	// MARK: - Propoerties
	private var navigationController: UINavigationController?
	
	// MARK: - startFlow
	func start() -> UINavigationController? {
		let startViewController = SplashViewController(flowDelegate: self)
		self.navigationController = UINavigationController(rootViewController: startViewController)
		return navigationController
	}
}

// MARK: - Splash
extension FinancesFlowController: SplashFlowDelegate {
	func navigateToLogin() {
		guard let nav = self.navigationController else { return }
		let login = LoginViewController(flowDelegate: self)
		login.view.alpha = 0
		nav.viewControllers = [login]
		
		UIView.transition(with: nav.view,
						  duration: 1.5,
						  options: [.transitionCrossDissolve],
						  animations: {
			login.view.alpha = 1
		},
						  completion: nil)
		
		nav.isNavigationBarHidden = true
	}
	
	func navigateToHomeFromSplash() {
		self.navigationController?.dismiss(animated: false)
		let home = HomeViewController(flowDelegate: self)
		self.navigationController?.pushViewController(home, animated: true)
	}
}

// MARK: - Login
extension FinancesFlowController: LoginFlowDelegate {
	func navigateToHome() {
		self.navigationController?.dismiss(animated: false)
		let home = HomeViewController(flowDelegate: self)
		self.navigationController?.pushViewController(home, animated: true)
	}
}

// MARK: - Home
extension FinancesFlowController: HomeFlowDelegate {
	func logout() {
		self.navigationController?.popViewController(animated: false)
		self.navigateToLogin()
	}
}
