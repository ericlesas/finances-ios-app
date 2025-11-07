//
//  MonthSelectorViewDelegate.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 30/10/25.
//

import Foundation

protocol MonthSelectorViewDelegate: AnyObject {
	func monthSelectorView(_ view: MonthSelectorView, didSelectMonthAt index: Int)
}
