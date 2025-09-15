//  LoginViewController.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 30/07/25.
//

import Foundation
import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
	let viewModel = LoginViewModel()
	let contentView = LoginView()
	public weak var flowDelegate: LoginFlowDelegate?
	
	init(flowDelegate: LoginFlowDelegate) {
		self.flowDelegate = flowDelegate
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		contentView.delegate = self
		setupUI()
		self.presentLoginFieldsAnimation()
		bindViewModel()
	}
	
	deinit {
		disableKeyboardHandling()
	}
	
	private func setupUI() {
		self.view.addSubview(contentView)
		self.view.backgroundColor = Colors.gray100
		setupConstraints()
	}
	
	private func setupConstraints() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
	
	private func bindViewModel() {
		viewModel.successResult = { [weak self] email in
			self?.presentSavedLoginAlert(email: email)
		}
		
		viewModel.errorResult = { [weak self] errorMessage in
			self?.presentErrorAlert(message: errorMessage)
		}
	}
	
	private func presentSavedLoginAlert(email: String) {
		let alertControler = UIAlertController(title: "login.save.alert.title".localized,
											   message: "login.save.alert.message".localized,
											   preferredStyle: .alert)
		let saveAction = UIAlertAction(title: "login.save.alert.positiveText".localized,
									   style: .default) { _ in
			self.askEnabledFaceId(email: email)
		}
		let cancelAction = UIAlertAction(title: "login.save.alert.negativeText".localized,
										 style: .cancel) { _ in
			self.flowDelegate?.navigateToHome()
		}
		
		alertControler.addAction(saveAction)
		alertControler.addAction(cancelAction)
		self.present(alertControler, animated: false)
	}
	
	private func askEnabledFaceId(email: String) {
		let alert = UIAlertController(title: "login.save.biometry.alert.title".localized,
									  message: "login.save.biometry.alert.message".localized,
									  preferredStyle: .alert)
		let yesAction = UIAlertAction(title: "login.save.alert.positiveText".localized,
									  style: .default) { _ in
			let user = User(email: email, userIsSaved: true, hasBiometryEnabled: true)
			UserDefaultsManager.saveUser(user: user)
			self.flowDelegate?.navigateToHome()
		}
		let noAction = UIAlertAction(title: "login.save.alert.negativeText".localized,
									 style: .cancel) { _ in
			let user = User(email: email, userIsSaved: true, hasBiometryEnabled: false)
			UserDefaultsManager.saveUser(user: user)
			self.flowDelegate?.navigateToHome()
		}
		
		alert.addAction(yesAction)
		alert.addAction(noAction)
		self.present(alert, animated: false)
	}
	
	private func presentErrorAlert(message: String) {
		let errorAlert = UIAlertController(title: "login.error.alert.title".localized,
										   message: message,
										   preferredStyle: .alert)
		let retry = UIAlertAction(title: "login.error.alert.retry".localized,
								  style: .default)
		errorAlert.addAction(retry)
		self.present(errorAlert, animated: false)
	}
	
	private func presentLoginFieldsAnimation() {
		UIView.animate(withDuration: 1.5,
					   delay: 1.0,
					   animations: {
			self.contentView.loginBackground.alpha = 1.0
			self.enableKeyboardHandling()
			self.hideKeyboardWhenTappedAround()
		})
	}
}

// MARK: - Extension
extension LoginViewController: LoginViewDelegate {
	func sendLoginData(email: String, password: String) {
		viewModel.doAuth(email: email, password: password)
	}
}
