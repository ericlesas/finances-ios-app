//
//  SplashViewController.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 29/07/25.
//

import Foundation
import UIKit
import LocalAuthentication

class SplashViewController: UIViewController {
	let contentView = SplashView()
	public weak var flowDelegate: SplashFlowDelegate?
	
	init(flowDelegate: SplashFlowDelegate) {
		self.flowDelegate = flowDelegate
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		contentView.logoImageView.alpha = 0.0
		setup()
		startAnimations()
	}
	
	private func setup() {
		self.view.addSubview(contentView)
		self.navigationController?.navigationBar.isHidden = true
		Colors.applyDarkGradient(to: self.view)
		setupConstraints()
	}
	
	private func setupConstraints() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
	
	private func startAnimations() {
		startBreathingAnimation()
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			self.animateLogoUp()
		}
	}
	
	
	private func decideNavigationFlow() {
		if let user = UserDefaultsManager.loadUser(), user.userIsSaved {
			user.hasBiometryEnabled ? authenticateWithFaceId() : flowDelegate?.navigateToHomeFromSplash()
		} else {
			flowDelegate?.navigateToLogin()
		}
	}
}

// MARK: - Animations
extension SplashViewController {
	private func startBreathingAnimation() {
		UIView.animate(withDuration: 1.5,
					   delay: 0.0,
					   animations: {
			self.contentView.logoImageView.alpha = 1.0
			self.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
		})
	}
	
	private func animateLogoUp() {
		UIView.animate(withDuration: 1.5,
					   delay: 0.0,
					   options: [.curveEaseOut],
					   animations: {
			self.contentView.logoImageView.transform = self.contentView.logoImageView.transform.translatedBy(x: 0, y: -100)
		}, completion: { _ in
			self.decideNavigationFlow()
		})
	}
}

// MARK: - Biometry Access Configuration
extension SplashViewController {
	private func authenticateWithFaceId() {
		let context = LAContext()
		var authError: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
									 error: &authError) {
			let reason = "login.save.biometry.alert.message".localized
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
								   localizedReason: reason) { success, evaluateError in
				DispatchQueue.main.async {
					if success {
						self.flowDelegate?.navigateToHomeFromSplash()
					} else {
						self.flowDelegate?.navigateToLogin()
					}
				}
			}
		} else {
			flowDelegate?.navigateToLogin()
		}
	}
}
