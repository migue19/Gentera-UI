//
//  CustomLabel.swift
//  Gentera-UI
//
//  Created by Miguel.mexicano on 03/12/25.
//

import UIKit
import SwiftUI
enum CustomLabelStyle {
    case title
    case subtitle
}

class CustomLabel: UILabel {
    let style: CustomLabelStyle
    
    init(text: String, style: CustomLabelStyle) {
        self.style = style
        super.init(frame: .zero)
        
        self.text = text
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        
        switch style {
        case .title:
            font = UIFont.systemFont(ofSize: 24, weight: .bold)
            textColor = .black
            textAlignment = .center
            
        case .subtitle:
            font = UIFont.systemFont(ofSize: 16, weight: .regular)
            textColor = .darkGray
            textAlignment = .center
        }
    }
}

class CustomLabelPreviewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Title Label
        let titleLabel = CustomLabel(text: "Ingresa tus datos", style: .title)
        stackView.addArrangedSubview(titleLabel)
        
        // Subtitle Label
        let subtitleLabel = CustomLabel(text: "Necesitamos verificar tu identidad", style: .subtitle)
        stackView.addArrangedSubview(subtitleLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

struct CustomLabelRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CustomLabelPreviewViewController {
        return CustomLabelPreviewViewController()
    }
    
    func updateUIViewController(_ uiViewController: CustomLabelPreviewViewController, context: Context) {
        // No necesita actualización
    }
}

#Preview {
    CustomLabelRepresentable()
}
