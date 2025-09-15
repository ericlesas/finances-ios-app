//
//  HomeView.swift
//  Finances
//
//  Created by Éricles de Alencar Santos on 15/09/25.
//

import Foundation
import UIKit

class HomeView: UIView {
	
	let headerView: UIView = {
		let view = UIView()
		view.backgroundColor = Colors.gray100
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	// TODO: Adicionar demais elementos ao header
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupView(){
		addSubview(headerView)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: topAnchor),
			headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			headerView.heightAnchor.constraint(equalToConstant: Metrics.profileSize),
		])
	}
}
