//
//  LoginViewDelegate.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 11/08/25.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
	func sendLoginData(email: String, password: String)
}
