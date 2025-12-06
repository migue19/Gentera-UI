//
//  TermsView.swift
//  Gentera-UI
//
//  Created by Miguel Mexicano Herrera on 05/12/25.
//

import UIKit
import SwiftUI

public class TermsView: UIView {
    // Public callbacks
    public var onToggle: ((Bool) -> Void)?
    public var onTermsTap: (() -> Void)?

    // State
    private(set) public var isChecked: Bool = false

    // Subviews
    public lazy var checkboxButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(toggleChecked), for: .touchUpInside)
        return b
    }()

    public lazy var termsLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = .black
        l.isUserInteractionEnabled = true
        // Add tap gesture to handle taps (for link)
        let tap = UITapGestureRecognizer(target: self, action: #selector(termsTapped))
        l.addGestureRecognizer(tap)
        return l
    }()

    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [checkboxButton, termsLabel])
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.alignment = .top
        s.spacing = 8
        return s
    }()

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)

        NSLayoutConstraint.activate([
            checkboxButton.widthAnchor.constraint(equalToConstant: 20),
            checkboxButton.heightAnchor.constraint(equalToConstant: 20),
            termsLabel.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor),

            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        // Default text
        setTermsText(mainText: "He leído y acepto los ", linkText: "Términos y Condiciones")
        updateAppearance()

        // Accessibility
        isAccessibilityElement = false
        accessibilityElements = [checkboxButton, termsLabel]
    }

    // MARK: - Public API
    public func setTermsText(mainText: String, linkText: String) {
        let attr = NSMutableAttributedString()
        let normalAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.black]
        let linkAttrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .semibold), .foregroundColor: UIColor.black, .underlineStyle: NSUnderlineStyle.single.rawValue]
        attr.append(NSAttributedString(string: mainText, attributes: normalAttrs))
        attr.append(NSAttributedString(string: linkText, attributes: linkAttrs))
        termsLabel.attributedText = attr
    }

    public func setChecked(_ checked: Bool, animated: Bool) {
        guard checked != isChecked else { return }
        isChecked = checked
        updateAppearance(animated: animated)
        onToggle?(isChecked)
    }

    // MARK: - Actions
    @objc private func toggleChecked() {
        setChecked(!isChecked, animated: true)
    }

    @objc private func termsTapped() {
        onTermsTap?()
    }

    // MARK: - Appearance
    private func updateAppearance(animated: Bool = false) {
        let update = {
            // Use SF Symbols for the checkbox image instead of background color + overlay
            let imageName = self.isChecked ? "checkmark.square.fill" : "square"
            let image = UIImage(systemName: imageName)
            self.checkboxButton.setImage(image, for: .normal)
            // Ensure tint and border reflect state
            self.checkboxButton.tintColor = .black
            self.checkboxButton.backgroundColor = .clear
        }
        if animated {
            UIView.animate(withDuration: 0.18, animations: update)
        } else {
            update()
        }
        // update accessibility value
        checkboxButton.accessibilityValue = isChecked ? "checked" : "not checked"
    }
}

// MARK: - Preview
class TermsViewPreviewViewController: UIViewController {
    private lazy var v1: TermsView = {
        let v = TermsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTermsText(mainText: "He leído y acepto los ", linkText: "Términos y Condiciones")
        v.onToggle = { print("v1 toggled: \($0)") }
        v.onTermsTap = { print("Terms tapped") }
        return v
    }()

    private lazy var v2: TermsView = {
        let v = TermsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTermsText(mainText: "He leído y acepto los ", linkText: "Términos y Condiciones")
        v.setChecked(true, animated: false)
        return v
    }()

    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [v1, v2])
        s.axis = .vertical
        s.spacing = 16
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

struct TermsViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TermsViewPreviewViewController { TermsViewPreviewViewController() }
    func updateUIViewController(_ uiViewController: TermsViewPreviewViewController, context: Context) {}
}

#Preview {
    TermsViewRepresentable()
}
