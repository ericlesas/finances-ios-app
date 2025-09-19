//
//  LoginViewDelegate.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 11/08/25.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
	func sendLoginData(name: String, email: String, password: String)
}
