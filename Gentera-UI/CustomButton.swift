//
//  Gentera_UI.swift
//  Gentera-UI
//
//  Created by Miguel.mexicano on 03/12/25.
//

import UIKit
import SwiftUI

public enum CustomButtonStyle {
    case primary
    case secondary
    case link
}

public class CustomButton: UIButton {
    let style: CustomButtonStyle
    
    public init(title: String, style: CustomButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        // Setup basic appearance
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 8
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true

        // Aplicar apariencia según estilo y estado actual
        applyStyleForCurrentState(animated: false)
    }

    // Aplica la apariencia según el estilo y si el control está enabled/disabled
    private func applyStyleForCurrentState(animated: Bool = false) {
        let apply = { [weak self] in
            guard let self = self else { return }
            switch self.style {
            case .primary:
                if self.isEnabled {
                    self.backgroundColor = .black
                    self.setTitleColor(.white, for: .normal)
                    self.layer.borderWidth = 0
                    self.alpha = 1.0
                } else {
                    self.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
                    self.setTitleColor(UIColor.white.withAlphaComponent(0.7), for: .normal)
                    self.layer.borderWidth = 0
                    self.alpha = 0.8
                }

            case .secondary:
                if self.isEnabled {
                    let c = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
                    self.backgroundColor = c
                    self.setTitleColor(.black, for: .normal)
                    self.layer.borderWidth = 1
                    self.layer.borderColor = c.cgColor
                    self.alpha = 1.0
                } else {
                    self.backgroundColor = UIColor(white: 0.95, alpha: 1)
                    self.setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .normal)
                    self.layer.borderWidth = 1
                    self.layer.borderColor = UIColor(white: 0.8, alpha: 1).cgColor
                    self.alpha = 0.8
                }

            case .link:
                self.backgroundColor = .clear
                if self.isEnabled {
                    self.setTitleColor(.white, for: .normal)
                    self.alpha = 1.0
                } else {
                    self.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
                    self.alpha = 0.6
                }
            }
        }

        if animated {
            UIView.animate(withDuration: 0.18) {
                apply()
            }
        } else {
            apply()
        }
    }

    // Override para detectar cambios de isEnabled y actualizar la UI
    public override var isEnabled: Bool {
        get { super.isEnabled }
        set {
            super.isEnabled = newValue
            applyStyleForCurrentState(animated: true)
        }
    }

    /// Convenience: set disabled state (true = disabled)
    public func setDisabled(_ disabled: Bool, animated: Bool = true) {
        isEnabled = !disabled
        applyStyleForCurrentState(animated: animated)
    }
}
