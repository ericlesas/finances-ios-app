//
//  Keyboard.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 10/09/25.
//

import Foundation
import UIKit

extension UIViewController {
	
	func enableKeyboardHandling() {
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}
	
	func disableKeyboardHandling() {
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillShowNotification,
												  object: nil)
		
		NotificationCenter.default.removeObserver(self,
												  name: UIResponder.keyboardWillHideNotification,
												  object: nil)
	}
	
	func hideKeyboardWhenTappedAround() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc
	private func keyboardWillShow(notification: NSNotification) {
		guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
		
		if self.view.frame.origin.y == 0 {
			self.view.frame.origin.y -= keyboard.height
		}
	}
	
	@objc
	private func keyboardWillHide(notification: NSNotification) {
		self.view.frame.origin.y = 0
	}
	
	@objc
	private func dismissKeyboard() {
		view.endEditing(true)
	}
}
