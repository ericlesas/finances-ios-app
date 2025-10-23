//
//  FloatingButton.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 02/10/25.
//

import Foundation
import UIKit

public protocol FloatingButtonDelegate: AnyObject {
	func buttonAction()
}

class FloatingButton: UIButton {
	
	// MARK: - Properties
	public weak var delegate: FloatingButtonDelegate?
	
	// MARK: - Initializer
	public init(backgroundColor: UIColor = Colors.magenta) {
		super.init(frame: .zero)
		setupFloatingButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Methods
	private func setupFloatingButton() {
		self.setImage(UIImage(named: "floating-button"), for: .normal)
		self.layer.shadowColor = UIColor.black.cgColor
		self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}
	
	// MARK: - Actions
	@objc
	private func buttonTapped() {
		delegate?.buttonAction()
	}
}
