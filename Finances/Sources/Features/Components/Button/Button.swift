//
//  Button.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 01/08/25.
//

import Foundation
import UIKit

public protocol ButtonDelegate: AnyObject {
	func buttonAction()
}

class Button: UIButton {
	
	public weak var delegate: ButtonDelegate?
	
	public init(title: String, backgroundColor: UIColor = Colors.magenta) {
		super.init(frame: .zero)
		setupButton(title: title,
					backgroundColor: backgroundColor)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupButton(title: String,
							 backgroundColor: UIColor) {
		self.setTitle(title, for: .normal)
		self.titleLabel?.font = Typography.buttonMd
		self.setTitleColor(Colors.gray100, for: .normal)
		self.backgroundColor = backgroundColor
		self.layer.cornerRadius = Metrics.small
		self.isEnabled = true
		self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}
	
	@objc
	private func buttonTapped() {
		delegate?.buttonAction()
	}
}
