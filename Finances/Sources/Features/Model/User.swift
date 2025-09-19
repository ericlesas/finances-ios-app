//
//  User.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 01/09/25.
//

import Foundation

struct User: Codable {
	let name: String
	let email: String
	let userIsSaved: Bool
	let hasBiometryEnabled: Bool
}
