//
//  UserDefaultsManager.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 01/09/25.
//

import Foundation
import UIKit

class UserDefaultsManager {
	
	// MARK: - Properties
	private static let userKey = "userKey"
	private static let profileImageKey = "profileImageKey"
	
	// MARK: - Static Methods
	static func saveUser(user: User) {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(user) {
			UserDefaults.standard.set(encoded, forKey: userKey)
			UserDefaults.standard.synchronize()
		}
	}
	
	static func loadUser() -> User? {
		if let userData = UserDefaults.standard.data(forKey: userKey) {
			let decoder = JSONDecoder()
			if let user = try? decoder.decode(User.self, from: userData) {
				return user
			}
		}
		return nil
	}
	
	static func saveProfileImage(_ image: UIImage) {
		if let imageData = image.pngData() {
			UserDefaults.standard.set(imageData, forKey: profileImageKey)
		}
	}
	
	static func loadProfileImage() -> UIImage? {
		if let imageData = UserDefaults.standard.data(forKey: profileImageKey) {
			return UIImage(data: imageData)
		}
		return nil
	}
	
	static func removeUser() {
		UserDefaults.standard.removeObject(forKey: userKey)
		UserDefaults.standard.synchronize()
	}
	
	static func removeProfileImage() {
		UserDefaults.standard.removeObject(forKey: profileImageKey)
		UserDefaults.standard.synchronize()
	}
}
