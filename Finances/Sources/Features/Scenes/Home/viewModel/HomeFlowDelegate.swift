//
//  HomeFlowDelegate.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 22/09/25.
//

import Foundation

public protocol HomeFlowDelegate: AnyObject {
	func logout()
	func openNewExpenseBottomSheet()
}
