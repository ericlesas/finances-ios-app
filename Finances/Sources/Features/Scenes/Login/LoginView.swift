//
//  LoginView.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 30/07/25.
//

import Foundation
import UIKit

class LoginView: UIView {
	public weak var delegate: LoginViewDelegate?
	private var isPasswordVisible = false
	
	let logoImageView: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "login-logo")
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let loginBackground: UIView = {
		let view = UIView()
		view.backgroundColor = Colors.gray100
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = Typography.titleSm
		label.text = "login.welcome.label.title".localized
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = Typography.textSmRegular
		label.textColor = Colors.gray500
		label.text = "login.welcome.label.description".localized
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let nameInput = Input(placeholder: "login.name.placeholder".localized,
						  imageName: nil,
						  imagePosition: nil)
	let emailInput = Input(placeholder: "login.email.placeholder".localized,
						   imageName: nil,
						   imagePosition: nil)
	let passwordInput = Input(placeholder: "login.password.placeholder".localized,
							  imageName: "eye-closed",
							  imagePosition: .right)
	
	let divider: UIView = {
		let divider = UIView()
		divider.backgroundColor = Colors.gray300
		divider.translatesAutoresizingMaskIntoConstraints = false
		return divider
	}()
	
	let loginButton: Button = {
		let button = Button(title: "login.button.title".localized,
							backgroundColor: Colors.magenta)
		button.addTarget(self, action: #selector(loginButtonDidTaped), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	private func setupUI() {
		addSubview(logoImageView)
		addSubview(loginBackground)
		loginBackground.addSubview(titleLabel)
		loginBackground.addSubview(descriptionLabel)
		loginBackground.addSubview(nameInput)
		loginBackground.addSubview(emailInput)
		loginBackground.addSubview(passwordInput)
		loginBackground.addSubview(divider)
		loginBackground.addSubview(loginButton)
		
		loginBackground.alpha = 0
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.tiny),
			logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.tiny),
			logoImageView.heightAnchor.constraint(equalToConstant: Metrics.logoImageSize),
			
			loginBackground.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
			loginBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			loginBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			loginBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			
			titleLabel.topAnchor.constraint(equalTo: loginBackground.topAnchor, constant: Metrics.huge),
			titleLabel.leadingAnchor.constraint(equalTo: loginBackground.leadingAnchor, constant: Metrics.high),
			titleLabel.trailingAnchor.constraint(equalTo: loginBackground.trailingAnchor, constant: -Metrics.high),
			
			descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
			descriptionLabel.leadingAnchor.constraint(equalTo: loginBackground.leadingAnchor, constant: Metrics.high),
			descriptionLabel.trailingAnchor.constraint(equalTo: loginBackground.trailingAnchor, constant: -Metrics.high),
			
			nameInput.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.medium),
			nameInput.leadingAnchor.constraint(equalTo: loginBackground.leadingAnchor, constant: Metrics.high),
			nameInput.trailingAnchor.constraint(equalTo: loginBackground.trailingAnchor, constant: -Metrics.high),
			
			emailInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: Metrics.small),
			emailInput.leadingAnchor.constraint(equalTo: loginBackground.leadingAnchor, constant: Metrics.high),
			emailInput.trailingAnchor.constraint(equalTo: loginBackground.trailingAnchor, constant: -Metrics.high),
			
			passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: Metrics.small),
			passwordInput.leadingAnchor.constraint(equalTo: loginBackground.leadingAnchor, constant: Metrics.high),
			passwordInput.trailingAnchor.constraint(equalTo: loginBackground.trailingAnchor, constant: -Metrics.high),
			
			divider.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: Metrics.high),
			divider.leadingAnchor.constraint(equalTo: loginBackground.leadingAnchor, constant: Metrics.high),
			divider.trailingAnchor.constraint(equalTo: loginBackground.trailingAnchor, constant: -Metrics.high),
			divider.heightAnchor.constraint(equalToConstant: 1),
			
			loginButton.leadingAnchor.constraint(equalTo: loginBackground.leadingAnchor, constant: Metrics.high),
			loginButton.trailingAnchor.constraint(equalTo: loginBackground.trailingAnchor, constant: -Metrics.high),
			loginButton.bottomAnchor.constraint(equalTo: loginBackground.bottomAnchor, constant: -Metrics.huge),
			loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
		])
	}
	
	@objc
	private func loginButtonDidTaped() {
		let email = emailInput.textField.text ?? ""
		let password = passwordInput.textField.text ?? ""
		delegate?.sendLoginData(email: email, password: password)
	}
}
