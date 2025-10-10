//
//  NewExpenseBottomSheetView.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 06/10/25.
//

import Foundation
import UIKit

class NewExpenseBottomSheetView: UIView {
	
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
	
	let divider: UIView = {
		let divider = UIView()
		divider.backgroundColor = Colors.gray300
		divider.translatesAutoresizingMaskIntoConstraints = false
		return divider
	}()
	
	let saveButton: Button = {
		let button = Button(title: "new.expense.bottom.sheet.button.save".localized, // TODO: - Adicionar no localized
							backgroundColor: Colors.magenta)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	init() {
		super.init(frame: .zero)
		setupUI()
		// saveButton.delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		addSubview(titleLabel)
		addSubview(closeButton)
		addSubview(transactionTitleInput)
		addSubview(categoryInput)
		addSubview(divider)
		addSubview(saveButton)
		
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
			
			categoryInput.topAnchor.constraint(equalTo: transactionTitleInput.bottomAnchor, constant: Metrics.medium),
			categoryInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			categoryInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			
			divider.topAnchor.constraint(equalTo: categoryInput.bottomAnchor, constant: Metrics.high),
			divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			divider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			divider.heightAnchor.constraint(equalToConstant: 1),
			
			saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
			saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
			saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.medium),
			saveButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize)
		])
	}
	
	@objc
	private func closeButtonTaped() {
		delegate?.didTapCloseButton()
	}
}
