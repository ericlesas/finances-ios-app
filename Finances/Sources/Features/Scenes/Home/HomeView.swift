//
//  HomeView.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 15/09/25.
//

import Foundation
import UIKit

class HomeView: UIView {
	
	// MARK: - Properties
	weak public var delegate: HomeViewDelegate?
	
	let headerView: UIView = {
		let view = UIView()
		view.backgroundColor = Colors.gray100
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let profileImage: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.clipsToBounds = true
		imageView.isUserInteractionEnabled = true
		imageView.image = UIImage(systemName: "person.crop.circle")
		imageView.tintColor = Colors.gray500
		imageView.layer.cornerRadius = Metrics.medium
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	let profileName: UILabel = {
		let label = UILabel()
		label.font = Typography.titleMd
		label.textColor = Colors.gray700
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let welcomeFinancesLabel: UILabel = {
		let label = UILabel()
		label.text = "home.header.welcome.label".localized
		label.font = Typography.textSmRegular
		label.textColor = Colors.gray500
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let logoutButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "logout"), for: .normal)
		button.tintColor = Colors.gray500
		button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let contentBackgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = Colors.gray300
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let floatingButton: FloatingButton = {
		let button = FloatingButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Initializer
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		floatingButton.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Methods
	private func setupView(){
		addSubview(headerView)
		headerView.addSubview(profileImage)
		headerView.addSubview(profileName)
		headerView.addSubview(welcomeFinancesLabel)
		headerView.addSubview(logoutButton)
		addSubview(contentBackgroundView)
		addSubview(floatingButton)
		
		setupConstraints()
		setupImageGesture()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			headerView.heightAnchor.constraint(equalToConstant: Metrics.profileSize),
			
			profileImage.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
			profileImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Metrics.small),
			profileImage.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
			profileImage.widthAnchor.constraint(equalToConstant: Metrics.buttonSize),
			
			profileName.topAnchor.constraint(equalTo: profileImage.topAnchor),
			profileName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: Metrics.small),
			
			welcomeFinancesLabel.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: Metrics.tiny),
			welcomeFinancesLabel.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
			
			logoutButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: Metrics.high),
			logoutButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
			logoutButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Metrics.small),
			logoutButton.heightAnchor.constraint(equalToConstant: Metrics.huge),
			logoutButton.widthAnchor.constraint(equalToConstant: Metrics.huge),
			
			floatingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
			floatingButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.inputImageSize),
			floatingButton.widthAnchor.constraint(equalToConstant: Metrics.buttonSize),
			floatingButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
			
			contentBackgroundView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -Metrics.medium),
			contentBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
			contentBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
			contentBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
	
	private func setupImageGesture() {
		let gestureRecoganizer = UITapGestureRecognizer(target: self,
														action: #selector(profileImageTapped))
		profileImage.addGestureRecognizer(gestureRecoganizer)
	}
	
	// MARK: - Actions
	@objc
	private func logoutButtonTapped() {
		delegate?.didTapLogoutButton()
	}
	
	@objc
	private func profileImageTapped() {
		delegate?.didTapProfileImage()
	}
	
	// MARK: - Public Methods
	func updateProfileName(_ name: String) {
		profileName.text = name
	}
}

// MARK: - Extension
extension HomeView: FloatingButtonDelegate {
	func buttonAction() {
		delegate?.didTapFloatingButton()
	}
}
