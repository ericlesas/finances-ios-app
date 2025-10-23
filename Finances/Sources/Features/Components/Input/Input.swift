//
//  Input.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 31/07/25.
//

import Foundation
import UIKit

public enum PlaceholderImagePosition {
	case left
	case right
}

class Input: UIView {
	
	// MARK: - Properties
	private var isTextVisible = false
	private var customWidth: CGFloat?
	
	let textField: UITextField = {
		let textField = UITextField()
		textField.font = Typography.input
		textField.textColor = Colors.gray700
		textField.borderStyle = .none
		textField.backgroundColor = Colors.gray200
		textField.layer.cornerRadius = Metrics.tiny
		textField.layer.borderWidth = 1
		textField.layer.borderColor = UIColor.clear.cgColor
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let imageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = true
		image.frame = CGRect(x: 0, y: 0, width: Metrics.inputImageSize, height: Metrics.inputImageSize)
		image.isUserInteractionEnabled = true
		return image
	}()
	
	// MARK: - Initializer
	init(placeholder: String, imageName: String?, imagePosition: PlaceholderImagePosition?, width: CGFloat? = nil) {
		super.init(frame: .zero)
		customWidth = width
		translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = placeholder
		textField.delegate = self
		configurePlaceholder(placeholder: placeholder)
		setPlaceholderImage(name: imageName, position: imagePosition)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Methods
	private func setupUI() {
		addSubview(textField)
		setupConstraints()
		setDefaultTextFieldPadding()
	}
	
	private func setPlaceholderImage(name: String?, position: PlaceholderImagePosition?) {
		guard let imageName = name, let position = position else { return }
		
		imageView.image = UIImage(named: imageName)
		setupImageGesture()
		
		let imagePosition: PlaceholderImagePosition = (position == .left) ? .left : .right
		
		textField.setImageView(imageView,
							   position: imagePosition,
							   padding: InputConfiguration.defaultImagePadding)
		
		if position == .left {
			textField.setPadding(right: InputConfiguration.defaultTextPadding)
		} else {
			textField.setPadding(left: InputConfiguration.defaultTextPadding)
		}
	}
	
	private func configurePlaceholder(placeholder: String) {
		textField.attributedPlaceholder = NSAttributedString(string: placeholder,
															 attributes: [NSAttributedString.Key.foregroundColor: Colors.gray400])
	}
	
	private func setDefaultTextFieldPadding() {
		if textField.leftView == nil && textField.rightView == nil {
			textField.setPadding(left: InputConfiguration.defaultTextPadding,
								 right: InputConfiguration.defaultTextPadding)
		}
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			self.heightAnchor.constraint(equalToConstant: 45),
			textField.topAnchor.constraint(equalTo: topAnchor),
			textField.leadingAnchor.constraint(equalTo: leadingAnchor),
			textField.trailingAnchor.constraint(equalTo: trailingAnchor),
			textField.heightAnchor.constraint(equalToConstant: 45),
		])
		
		if let width = customWidth {
			self.widthAnchor.constraint(equalToConstant: width).isActive = true
		}
	}
	
	private func setupImageGesture() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self,
														  action: #selector(toggleTextFieldText))
		imageView.addGestureRecognizer(tapGestureRecognizer)
	}
	
	private func updateBorder(isEditing: Bool) {
		let borderColor = isEditing ? Colors.magenta : UIColor.clear
		
		UIView.animate(withDuration: InputConfiguration.borderAnimationDuration) {
			self.textField.layer.borderColor = borderColor.cgColor
		}
	}
	
	// MARK: - Actions
	@objc
	private func toggleTextFieldText() {
		isTextVisible.toggle()
		if isTextVisible {
			imageView.image = UIImage(named: "eye-closed")
			textField.isSecureTextEntry = false
		} else {
			imageView.image = UIImage(named: "eye")
			textField.isSecureTextEntry = true
		}
	}
	
	// MARK: - Public Methods
	func getText() -> String {
		return textField.text ?? ""
	}
}

// MARK: - Extension
extension Input: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		updateBorder(isEditing: true)
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		updateBorder(isEditing: false)
	}
}
