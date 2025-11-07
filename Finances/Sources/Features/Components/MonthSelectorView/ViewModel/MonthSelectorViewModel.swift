//
//  MonthSelectorViewModel.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 27/10/25.
//

import Foundation

class MonthSelectorViewModel {
	
	// MARK: - Properties
	let months = ["JAN", "FEV", "MAR", "ABR", "MAI", "JUN", "JUL", "AGO", "SET", "OUT", "NOV", "DEZ"]
	private let calendar = Calendar.current
	private(set) var selectedIndex: Int
	
	var onMonthSelected: ((Int) -> Void)?
	
	// MARK: - Initializer
	init() {
		let month = calendar.component(.month, from: Date())
		self.selectedIndex = month - 1
	}
	
	// MARK: - Public Methods
	func selectMonth(at index: Int) {
		guard index >= 0 && index < months.count else { return }
		selectedIndex = index
		onMonthSelected?(index)
	}
	
	func getCurrentMonthIndex() -> Int {
		return selectedIndex
	}
}
