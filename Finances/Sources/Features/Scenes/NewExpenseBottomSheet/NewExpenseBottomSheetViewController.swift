//
//  NewExpenseBottomSheetViewController.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 06/10/25.
//

import Foundation
import UIKit

class NewExpenseBottomSheetViewController: UIViewController {
	
	// MARK: - Properties
	let contentView = NewExpenseBottomSheetView()
	public weak var flowDelegate: NewExpenseBottomSheetFlowDelegate?
	private let buttonGroup = ButtonGroup()
	
	// MARK: - Initializer
	init(flowDelegate: NewExpenseBottomSheetFlowDelegate) {
		self.flowDelegate = flowDelegate
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupButtonGroup()
	}
	
	// MARK: - Setup Methods
	private func setupUI() {
		self.view.addSubview(contentView)
		configureSheetPresentation()
		contentView.delegate = self
		view.backgroundColor = Colors.gray100
		setupConstraints()
	}
	
	private func setupConstraints() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setupButtonGroup() {
		buttonGroup.addButtons([
			contentView.incomeButton,
			contentView.outcomeButton
		])
	}
	
	private func configureSheetPresentation() {
		modalPresentationStyle = .pageSheet
		if let sheet = sheetPresentationController {
			sheet.detents = [.medium(), .large()]
			sheet.prefersGrabberVisible = false
			sheet.preferredCornerRadius = 20
		}
	}
}

// MARK: - Extension
extension NewExpenseBottomSheetViewController: NewExpenseBottomSheetViewDelegate {
	func didTapCloseButton() {
		flowDelegate?.closeBottomSheet()
	}
}
