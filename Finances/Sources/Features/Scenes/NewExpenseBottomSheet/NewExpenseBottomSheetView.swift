//
//  NewExpenseBottomSheetView.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 06/10/25.
//

import Foundation
import UIKit

class NewExpenseBottomSheetView: UIView {
	
	// MARK: - Properties
	weak public var delegate: NewExpenseBottomSheetViewDelegate?
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "new.expense.bottom.sheet.label.title".localized
		label.font = Typography.titleMd
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let closeButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "close-button"), for: .normal)
		button.tintColor = Colors.gray500
		button.addTarget(self, action: #selector(closeButtonTaped), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let transactionTitleInput = Input(placeholder: "new.expense.bottom.sheet.transaction.placeholder".localized,
									  imageName: nil,
									  imagePosition: nil)
	
	let categoryInput = Input(placeholder: "new.expense.bottom.sheet.category.placeholder".localized,
							  imageName: "category",
							  imagePosition: .left)
	
	let expenseValueInput = Input(placeholder: "new.expense.bottom.sheet.expense.value.placeholder".localized,
								  imageName: "currency",
								  imagePosition: .left,
								  width: Metrics.width)
	
	let dateInput = Input(placeholder: "new.expense.bottom.sheet.date.placeholder".localized,
						  imageName: "calendar",
						  imagePosition: .left,
						  width: Metrics.width)
	
	let incomeButton: SelectableButton = {
		let incomeIcon = UIImage(named: "income-icon") ?? UIImage()
		let button = SelectableButton(title: "new.expense.bottom.sheet.income.button".localized, 
									  value: "income",
									  backgroundColor: Colors.greenSuccess.light(),
									  titleColor: Colors.greenSuccess,
									  borderColor: Colors.greenSuccess,
									  selectedBackgroundColor: Colors.greenSuccess,
									  selectedTitleColor: Colors.gray100,
									  selectedIconColor: Colors.gray100,
									  icon: incomeIcon)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let outcomeButton: SelectableButton = {
		let outcomeIcon = UIImage(named: "outcome-icon") ?? UIImage()
		let button = SelectableButton(title: "new.expense.bottom.sheet.outcome.button".localized, 
									  value: "outcome",
									  backgroundColor: Colors.redAlert.light(),
									  titleColor: Colors.redAlert,
									  borderColor: Colors.redAlert,
									  selectedBackgroundColor: Colors.redAlert,
									  selectedTitleColor: Colors.gray100,
									  selectedIconColor: Colors.gray100,
									  icon: outcomeIcon)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let divider: UIView = {
		let divider = UIView()
		divider.backgroundColor = Colors.gray300
		divider.translatesAutoresizingMaskIntoConstraints = false
		return divider
	}()
	
	let saveButton: Button = {
		let button = Button(title: "new.expense.bottom.sheet.button.save".localized,
							backgroundColor: Colors.magenta)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Initializer
	init() {
		super.init(frame: .zero)
		setupUI()
		// saveButton.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Methods
	private func setupUI() {
		addSubview(titleLabel)
		addSubview(closeButton)
		addSubview(transactionTitleInput)
		addSubview(categoryInput)
		addSubview(divider)
		addSubview(saveButton)
		addSubview(expenseValueInput)
		addSubview(dateInput)
		addSubview(incomeButton)
		addSubview(outcomeButton)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.medium),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			
			closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
			closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			
			transactionTitleInput.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.medium),
			transactionTitleInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			transactionTitleInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			
			categoryInput.topAnchor.constraint(equalTo: transactionTitleInput.bottomAnchor, constant: Metrics.medier),
			categoryInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			categoryInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			
			expenseValueInput.topAnchor.constraint(equalTo: categoryInput.bottomAnchor, constant: Metrics.medier),
			expenseValueInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			
			dateInput.topAnchor.constraint(equalTo: categoryInput.bottomAnchor, constant: Metrics.medier),
			dateInput.leadingAnchor.constraint(equalTo: expenseValueInput.trailingAnchor, constant: Metrics.medier),
			dateInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			
			incomeButton.topAnchor.constraint(equalTo: expenseValueInput.bottomAnchor, constant: Metrics.medium),
			incomeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			incomeButton.widthAnchor.constraint(equalToConstant: Metrics.width),
			incomeButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
			
			outcomeButton.topAnchor.constraint(equalTo: dateInput.bottomAnchor, constant: Metrics.medium),
			outcomeButton.leadingAnchor.constraint(equalTo: expenseValueInput.trailingAnchor, constant: Metrics.medier),
			outcomeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			outcomeButton.widthAnchor.constraint(equalToConstant: Metrics.width),
			outcomeButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
			
			divider.topAnchor.constraint(equalTo: incomeButton.bottomAnchor, constant: Metrics.high),
			divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			divider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			divider.heightAnchor.constraint(equalToConstant: 1),
			
			saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.medium),
			saveButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
		])
	}
	
	// MARK: - Actions
	@objc
	private func closeButtonTaped() {
		delegate?.didTapCloseButton()
	}
}
