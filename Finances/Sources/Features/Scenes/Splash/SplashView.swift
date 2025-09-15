//
//  SplashView.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 29/07/25.
//

import Foundation
import UIKit

class SplashView: UIView {
	
	let logoImageView: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "splash-logo")
		image.contentMode = .scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	init() {
		super.init(frame: .zero)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		addSubview(logoImageView)
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -Metrics.huge),
		])
	}
}
