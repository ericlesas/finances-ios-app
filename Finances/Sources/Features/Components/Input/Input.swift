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
	
	private var isTextVisible = false
	
	let textField: UITextField = {
		let textField = UITextField()
		textField.font = Typography.input
		textField.textColor = Colors.gray700
		textField.borderStyle = .roundedRect
		textField.backgroundColor = Colors.gray200
		textField.layer.cornerRadius = Metrics.tiny
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let imageView: UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFit
		image.clipsToBounds = true
		image.frame = CGRect(x: 0, y: 0, width: Metrics.small, height: Metrics.small)
		image.isUserInteractionEnabled = true
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	// TODO: - Adicionar novos parâmetros (width: CGFloat)
	init(placeholder: String, imageName: String?, imagePosition: PlaceholderImagePosition?) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		textField.placeholder = placeholder
		configurePlaceholder(placeholder: placeholder)
		setPlaceholderImage(name: imageName, 
							position: imagePosition)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		addSubview(textField)
		setupConstraints()
	}
	
	private func setPlaceholderImage(name: String?, position: PlaceholderImagePosition?) {
		guard let imageName = name, let position = position else { return }
		imageView.image = UIImage(named: imageName)
		setupImageGesture()
		if position == .left {
			textField.leftView = imageView
			textField.leftViewMode = .always
		} else {
			textField.rightView = imageView
			textField.rightViewMode = .always
		}
	}
	
	private func configurePlaceholder(placeholder: String) {
		textField.attributedPlaceholder = NSAttributedString(string: placeholder,
															 attributes: [NSAttributedString.Key.foregroundColor: Colors.gray400])
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			self.heightAnchor.constraint(equalToConstant: 45),
			textField.topAnchor.constraint(equalTo: topAnchor),
			textField.leadingAnchor.constraint(equalTo: leadingAnchor),
			textField.trailingAnchor.constraint(equalTo: trailingAnchor),
			textField.heightAnchor.constraint(equalToConstant: 45),
		])
	}
	
	func getText() -> String {
		return textField.text ?? ""
	}
	
	private func setupImageGesture() {
		let tapGestureRecognizer = UITapGestureRecognizer(target: self,
														  action: #selector(toggleTextFieldText))
		imageView.addGestureRecognizer(tapGestureRecognizer)
	}
	
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
}

// MARK: - Extension
extension Input: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
