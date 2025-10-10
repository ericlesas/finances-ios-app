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
		self.navigationController?.dismiss(animated: false)
		let login = LoginViewController(flowDelegate: self)
		self.navigationController?.pushViewController(login, animated: false)
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
	func openNewExpenseBottomSheet() {
		let bottomSheet = NewExpenseBottomSheetViewController(flowDelegate: self)
		self.navigationController?.present(bottomSheet, animated: true)
	}
	
	func logout() {
		self.navigationController?.popViewController(animated: false)
		self.navigateToLogin()
	}
}

// MARK: - NewExpenseBottomSheet
extension FinancesFlowController: NewExpenseBottomSheetFlowDelegate {
	func closeBottomSheet() {
		self.navigationController?.presentedViewController?.dismiss(animated: true)
	}
}
