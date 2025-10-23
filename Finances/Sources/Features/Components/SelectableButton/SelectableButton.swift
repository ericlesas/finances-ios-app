//
//  SelectableButton.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 21/10/25.
//

import Foundation
import UIKit

public protocol SelectableButtonDelegate: AnyObject {
	func didSelectButton(value: String)
}

public enum ButtonIconPosition {
	case leading
	case trailing
	case top
	case bottom
}

public enum ButtonState {
	case normal
	case selectable(value: String)
}

class SelectableButton: UIButton {
	
	// MARK: - Properties
	public weak var delegate: SelectableButtonDelegate?
	public var value: String
	private var buttonState: ButtonState = .normal
	private var selectedBackgroundColor: UIColor?
	private var selectedTitleColor: UIColor?
	private var selectedIconColor: UIColor?
	private var normalBackgroundColor: UIColor?
	private var normalTitleColor: UIColor?
	private var normalBorderColor: UIColor?
	private var normalIconColor: UIColor?
	
	public override var isSelected: Bool {
		didSet {
			updateAppearance()
		}
	}
	
	public var associatedValue: String? {
		if case .selectable(let value) = buttonState {
			return value
		}
		return nil
	}
	
	// MARK: - Initializer
	public init(title: String,
				value: String,
				state: ButtonState = .normal,
				backgroundColor: UIColor = Colors.magenta,
				titleColor: UIColor = Colors.gray100,
				borderColor: UIColor? = nil,
				selectedBackgroundColor: UIColor? = nil,
				selectedTitleColor: UIColor? = nil,
				selectedIconColor: UIColor? = nil,
				borderWidth: CGFloat = 1,
				icon: UIImage? = nil,
				iconColor: UIColor? = nil,
				iconPosition: ButtonIconPosition = .trailing) {
		self.value = value
		super.init(frame: .zero)
		
		self.buttonState = state
		self.normalBackgroundColor = backgroundColor
		self.normalTitleColor = titleColor
		self.normalBorderColor = borderColor
		self.normalIconColor = iconColor ?? titleColor
		self.selectedBackgroundColor = selectedBackgroundColor ?? backgroundColor.dark(by: 0.2)
		self.selectedTitleColor = selectedTitleColor ?? titleColor
		self.selectedIconColor = selectedIconColor ?? self.normalIconColor
		
		setupButton(title: title,
					backgroundColor: backgroundColor,
					titleColor: titleColor,
					borderColor: borderColor,
					borderWidth: borderWidth,
					icon: icon,
					iconPosition: iconPosition)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Setup Methods
	private func setupButton(title: String,
							 backgroundColor: UIColor,
							 titleColor: UIColor,
							 borderColor: UIColor?,
							 borderWidth: CGFloat,
							 icon: UIImage?,
							 iconPosition: ButtonIconPosition) {
		configureAppearance(title: title,
							backgroundColor: backgroundColor,
							titleColor: titleColor,
							icon: icon,
							iconPosition: iconPosition)
		configureBorder(color: borderColor, width: borderWidth)
		setupActions()
	}
	
	private func configureAppearance(title: String,
									 backgroundColor: UIColor,
									 titleColor: UIColor,
									 icon: UIImage?,
									 iconPosition: ButtonIconPosition) {
		var config = UIButton.Configuration.plain()
		config.title = title
		config.baseForegroundColor = titleColor
		config.background.backgroundColor = backgroundColor
		config.background.cornerRadius = Metrics.small
		config.contentInsets = NSDirectionalEdgeInsets(top: 12,
													   leading: 16,
													   bottom: 12,
													   trailing: 16)
		configureTitleFont(in: &config)
		configureIcon(icon, position: iconPosition, in: &config)
		
		self.configuration = config
	}
	
	private func configureTitleFont(in config: inout UIButton.Configuration) {
		config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
			var outgoing = incoming
			outgoing.font = Typography.buttonMd
			return outgoing
		}
	}
	
	private func configureIcon(_ icon: UIImage?, position: ButtonIconPosition, in config: inout UIButton.Configuration) {
		guard let icon = icon else { return }
		
		config.image = icon.withRenderingMode(.alwaysTemplate)
		config.imagePadding = 8
		
		switch position {
		case .leading:
			config.imagePlacement = .leading
		case .trailing:
			config.imagePlacement = .trailing
		case .top:
			config.imagePlacement = .top
		case .bottom:
			config.imagePlacement = .bottom
		}
	}
	
	private func configureBorder(color: UIColor?, width: CGFloat) {
		guard let color = color else { return }
		
		layer.borderColor = color.cgColor
		layer.borderWidth = width
		layer.cornerRadius = Metrics.small
	}
	
	private func updateAppearance() {
		UIView.animate(withDuration: 0.2) {
			if self.isSelected {
				self.configuration?.background.backgroundColor = self.selectedBackgroundColor
				self.configuration?.baseForegroundColor = self.selectedTitleColor
				self.tintColor = self.selectedIconColor
			} else {
				self.configuration?.background.backgroundColor = self.normalBackgroundColor
				self.configuration?.baseForegroundColor = self.normalTitleColor
				self.tintColor = self.normalIconColor
				self.layer.borderColor = UIColor.clear.cgColor
			}
		}
	}
	
	private func setupActions() {
		addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
	}
	
	// MARK: - Public Methods
	public func setSelected(_ selected: Bool) {
		self.isSelected = selected
	}
	
	// MARK: - Actions
	@objc
	private func buttonTapped() {
		isSelected = true
		delegate?.didSelectButton(value: value)
	}
}

