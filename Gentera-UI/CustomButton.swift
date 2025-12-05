//
//  Gentera_UI.swift
//  Gentera-UI
//
//  Created by Miguel.mexicano on 03/12/25.
//

import UIKit
import SwiftUI

enum CustomButtonStyle {
    case primary
    case secondary
    case link
}

class CustomButton: UIButton {
    let style: CustomButtonStyle
    
    init(title: String, style: CustomButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 8
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        switch style {
        case .primary:
            backgroundColor = UIColor(red: 0, green: 0.48, blue: 1, alpha: 1) // Azul
            setTitleColor(.white, for: .normal)
            layer.borderWidth = 0
            
        case .secondary:
            backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1) // Gris
            setTitleColor(.black, for: .normal)
            layer.borderWidth = 1
            layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
            
        case .link:
            backgroundColor = .clear
            setTitleColor(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1), for: .normal)
            layer.borderWidth = 0
        }
    }
}

class ButtonPreviewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray5
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // Primary Button
        let primaryButton = CustomButton(title: "Abrir una cuenta", style: .primary)
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(primaryButton)
        
        // Secondary Button
        let secondaryButton = CustomButton(title: "Ya soy cliente", style: .secondary)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(secondaryButton)
        
        // Link Button
        let linkButton = CustomButton(title: "Olvidé mi contraseña", style: .link)
        linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        stackView.addArrangedSubview(linkButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func primaryButtonTapped() {
        print("Primary button tapped")
    }
    
    @objc func secondaryButtonTapped() {
        print("Secondary button tapped")
    }
    
    @objc func linkButtonTapped() {
        print("Link button tapped")
    }
}

struct ButtonPreviewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ButtonPreviewViewController {
        return ButtonPreviewViewController()
    }
    
    func updateUIViewController(_ uiViewController: ButtonPreviewViewController, context: Context) {
        // No necesita actualización
    }
}

#Preview {
    ButtonPreviewRepresentable()
}
