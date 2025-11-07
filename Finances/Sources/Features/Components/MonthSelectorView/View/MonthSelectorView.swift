//
//  MonthSelectorView.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 27/10/25.
//

import Foundation
import UIKit

class MonthSelectorView: UIView {
	
	// MARK: - Properties
	private var buttons: [UIButton] = []
	private var months: [String] = []
	weak var delegate: MonthSelectorViewDelegate?
	private let viewModel = MonthSelectorViewModel()
	
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		return scrollView
	}()
	
	private let stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.spacing = Metrics.small
		return stackView
	}()
	
	private let leftButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "left-arrow"), for: .normal)
		button.tintColor = Colors.gray600
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let rightButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(UIImage(named: "right-arrow"), for: .normal)
		button.tintColor = Colors.gray600
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	// MARK: - Override Methods
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
		setupConstraints()
		setupActions()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Methods
	private func setupView() {
		addSubview(leftButton)
		addSubview(scrollView)
		addSubview(rightButton)
		scrollView.addSubview(stackView)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
			leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			
			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: Metrics.small),
			scrollView.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -Metrics.small),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
			scrollView.heightAnchor.constraint(equalToConstant: Metrics.medium),
			
			rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
			rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			
			stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Metrics.small),
			stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Metrics.small),
			stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
		])
	}
	
	private func setupActions() {
		leftButton.addTarget(self, action: #selector(scrollLeft), for: .touchUpInside)
		rightButton.addTarget(self, action: #selector(scrollRight), for: .touchUpInside)
	}
	
	// MARK: - Private Methods
	private func createButton(title: String, tag: Int) -> UIButton {
		let button = UIButton(type: .system)
		button.setTitle(title, for: .normal)
		button.setTitleColor(Colors.gray400, for: .normal)
		button.backgroundColor = Colors.gray300
		button.layer.cornerRadius = 0
		button.titleLabel?.font = Typography.titleXs
		button.heightAnchor.constraint(equalToConstant: 32).isActive = true
		button.widthAnchor.constraint(equalToConstant: 48).isActive = true
		button.tag = tag
		button.addTarget(self, action: #selector(monthTapped(_:)), for: .touchUpInside)
		return button
	}
	
	private func scrollToSelectedMonth(index: Int, animated: Bool = true) {
		guard index < buttons.count else { return }
		
		let button = buttons[index]
		let buttonFrame = button.frame
		let scrollViewWidth = scrollView.bounds.width
		let targetX = buttonFrame.midX - (scrollViewWidth / 2)
		let maxOffsetX = scrollView.contentSize.width - scrollViewWidth
		let offsetX = max(0, min(targetX, maxOffsetX))
		
		scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: animated)
	}
	
	// MARK: - Public Methods
	func configure(with months: [String], selectedIndex: Int) {
		self.months = months
		buttons.forEach { $0.removeFromSuperview() }
		buttons.removeAll()
		
		for (index, month) in months.enumerated() {
			let button = createButton(title: month, tag: index)
			buttons.append(button)
			stackView.addArrangedSubview(button)
		}
		
		updateSelection(at: selectedIndex)
	}
	
	func updateSelection(at index: Int) {
		for (i, button) in buttons.enumerated() {
			let isSelected = (i == index)
			let month = months[i]
			
			if isSelected {
				let attributes: [NSAttributedString.Key: Any] = [
					.foregroundColor: Colors.gray700,
					.underlineStyle: NSUnderlineStyle.thick.rawValue,
					.underlineColor: Colors.magenta,
					.font: Typography.titleSm as Any,
				]
				let attributedTitle = NSAttributedString(string: month, attributes: attributes)
				button.setAttributedTitle(attributedTitle, for: .normal)
			} else {
				let attributes: [NSAttributedString.Key: Any] = [
					.foregroundColor: Colors.gray400,
					.font: Typography.titleXs as Any
				]
				let attributedTitle = NSAttributedString(string: month, attributes: attributes)
				button.setAttributedTitle(attributedTitle, for: .normal)
			}
		}
	}
	
	func scrollToCurrentMonth() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.scrollToSelectedMonth(index: self.viewModel.selectedIndex, animated: false)
		}
	}
	
	// MARK: - Actions
	@objc
	private func monthTapped(_ sender: UIButton) {
		delegate?.monthSelectorView(self, didSelectMonthAt: sender.tag)
	}
	
	@objc
	private func scrollLeft() {
		let newOffset = max(scrollView.contentOffset.x - scrollView.bounds.width * 0.5, 0)
		scrollView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
	}
	
	@objc
	private func scrollRight() {
		let maxOffset = scrollView.contentSize.width - scrollView.bounds.width
		let newOffset = min(scrollView.contentOffset.x + scrollView.bounds.width * 0.5, maxOffset)
		scrollView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
	}
}
