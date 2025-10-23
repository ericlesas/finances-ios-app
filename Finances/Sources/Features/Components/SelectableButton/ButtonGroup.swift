//
//  ButtonGroup.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 22/10/25.
//

import Foundation
import UIKit

class ButtonGroup {
	
	// MARK: - Properties
	private var buttons: [SelectableButton] = []
	private weak var selectedButton: SelectableButton?
	
	var selectedValue: String? {
		return selectedButton?.value
	}
	
	// MARK: - Public Methods
	func addButton(_ button: SelectableButton) {
		buttons.append(button)
		button.delegate = self
	}
	
	func addButtons(_ buttons: [SelectableButton]) {
		buttons.forEach { addButton($0) }
	}
	
	func deselectAll() {
		buttons.forEach { $0.isSelected = false }
		selectedButton = nil
	}
	
	func selectButton(withValue value: String) {
		buttons.forEach { $0.isSelected = false }
		
		if let button = buttons.first(where: { $0.value == value }) {
			button.isSelected = true
			selectedButton = button
		}
	}
}

// MARK: - Extension
extension ButtonGroup: SelectableButtonDelegate {
	func didSelectButton(value: String) {
		selectButton(withValue: value)
		print("🔄 Botão selecionado no grupo: \(value)")
	}
}
