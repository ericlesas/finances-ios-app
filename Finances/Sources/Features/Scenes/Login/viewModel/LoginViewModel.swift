//
//  LoginViewModel.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 11/08/25.
//

import Foundation
import Firebase

class LoginViewModel {
	
	var successResult: ((String) -> Void)?
	var errorResult: ((String) -> Void)?
	
	func doAuth(email: String, password: String) {
		Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResut, error in
			if let error = error {
				self?.errorResult?("login.error.alert.message".localized)
			} else {
				self?.successResult?(email)
			}
		}
	}
}
