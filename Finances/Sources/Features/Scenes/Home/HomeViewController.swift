//
//  HomeViewController.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 15/09/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
	let contentView = HomeView()
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	private func setupUI() {
		self.view.addSubview(contentView)
		self.view.backgroundColor = Colors.gray100
		setupConstraints()
	}
	
	private func setupConstraints() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
}
