//
//  ViewController.swift
//  Gentera-UI-App
//
//  Created by Miguel.mexicano on 16/12/25.
//

import UIKit
import Gentera_UI
class ViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 20
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var primaryButton: CustomButton = {
        let b = CustomButton(title: "Abrir una cuenta", style: .primary)
        b.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        return b
    }()

    private lazy var secondaryButton: CustomButton = {
        let b = CustomButton(title: "Ya soy cliente", style: .secondary)
        b.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
        return b
    }()

    private lazy var linkButton: CustomButton = {
        let b = CustomButton(title: "Olvidé mi contraseña", style: .link)
        b.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        view.addSubview(stackView)

        // Add arranged subviews from lazy vars
        stackView.addArrangedSubview(primaryButton)
        stackView.addArrangedSubview(secondaryButton)
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

