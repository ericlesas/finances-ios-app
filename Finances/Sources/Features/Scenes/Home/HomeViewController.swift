//
//  HomeViewController.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 15/09/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
	let contentView = HomeView()
	public weak var flowDelegate: HomeFlowDelegate?
	
	init(flowDelegate: HomeFlowDelegate) {
		self.flowDelegate = flowDelegate
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		getUsername()
		getProfileImage()
	}
	
	private func setupUI() {
		self.view.addSubview(contentView)
		self.view.backgroundColor = Colors.gray100
		contentView.delegate = self
		setupConstraints()
	}

	private func getUsername() {
		guard let user = UserDefaultsManager.loadUser() else { return }
		
		let greeting: String
		if !user.name.isEmpty {
			greeting = String(format: "home.header.username.label".localized, user.name)
		} else {
			greeting = "home.header.greeting.fallback".localized
		}
		contentView.updateProfileName(greeting)
	}
	
	private func getProfileImage() {
		if let userImage = UserDefaultsManager.loadProfileImage() {
			contentView.profileImage.image = userImage
		}
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
}

// MARK: - Extension
extension HomeViewController: HomeViewDelegate {
	func didTapLogoutButton() {
		UserDefaultsManager.removeUser()
		UserDefaultsManager.removeProfileImage()
		flowDelegate?.logout()
	}
	
	func didTapProfileImage() {
		changeProfileImage()
	}
	
	func didTapFloatingButton() {
		flowDelegate?.openNewExpenseBottomSheet()
	}
}

// MARK: - Extension
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	private func changeProfileImage() {
		let picker = UIImagePickerController()
		picker.delegate = self
		picker.sourceType = .photoLibrary
		picker.allowsEditing = true
		present(picker, animated: true)
	}
	
	internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let chosenImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
			contentView.profileImage.image = chosenImage
			UserDefaultsManager.saveProfileImage(chosenImage)
		}
		dismiss(animated: true)
	}
}
