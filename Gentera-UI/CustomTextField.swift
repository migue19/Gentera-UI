//
//  CustomTextField.swift
//  Gentera-UI
//
//  Created by Miguel Mexicano Herrera on 05/12/25.
//

import UIKit
import SwiftUI

public enum CustomTextFieldType {
    case normal
    case phone
    case idCard
    case date
}

public class CustomTextField: UIView {
    public let type: CustomTextFieldType

    // Convertido a lazy vars
    public lazy var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.clearButtonMode = .whileEditing
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.delegate = self
        return tf
    }()

    private lazy var container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 8
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        v.backgroundColor = .clear
        return v
    }()

    private lazy var rightButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tintColor = .darkGray
        b.isHidden = true
        return b
    }()

    // New: integrated title label
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        l.textColor = .black
        return l
    }()

    // Callbacks
    public var onCameraTap: (() -> Void)?
    public var onCalendarTap: (() -> Void)?

    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        df.locale = Locale(identifier: "es_MX")
        return df
    }()

    // Add optional title parameter; keep defaults so existing callers don't break
    public init(placeholder: String = "", type: CustomTextFieldType = .normal, title: String? = nil) {
        self.type = type
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        configure(for: type, placeholder: placeholder)
        // Configure title label text if provided
        titleLabel.text = title ?? ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Use lazy properties which already configure subviews
        addSubview(titleLabel)
        addSubview(container)
        container.addSubview(textField)
        container.addSubview(rightButton)

        NSLayoutConstraint.activate([
            // Title label at top
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),

            // Container below title
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            textField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            textField.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            textField.topAnchor.constraint(greaterThanOrEqualTo: container.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -8),

            rightButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            rightButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            rightButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 32),
            rightButton.heightAnchor.constraint(equalToConstant: 32),
        ])

        // rightButton's hidden state is set in configure(for:)
    }

    private func configure(for type: CustomTextFieldType, placeholder: String) {
        textField.placeholder = placeholder

        switch type {
        case .normal:
            textField.keyboardType = .default
            rightButton.isHidden = true

        case .phone:
            textField.keyboardType = .numberPad
            rightButton.isHidden = true
            // add editing changed for formatting
            textField.addTarget(self, action: #selector(phoneTextChanged), for: .editingChanged)

        case .idCard:
            textField.keyboardType = .default
            rightButton.isHidden = false
            let image = UIImage(systemName: "camera")
            rightButton.setImage(image, for: .normal)
            rightButton.addTarget(self, action: #selector(cameraTapped), for: .touchUpInside)

        case .date:
            textField.keyboardType = .default
            rightButton.isHidden = false
            let image = UIImage(systemName: "calendar")
            rightButton.setImage(image, for: .normal)
            rightButton.addTarget(self, action: #selector(calendarTapped), for: .touchUpInside)
            setupDatePicker()
        }
    }

    // Public getter for current text
    public var value: String {
        return textField.text ?? ""
    }

    // MARK: - Actions
    @objc private func cameraTapped() {
        onCameraTap?()
    }

    @objc private func calendarTapped() {
        // If using UIDatePicker as inputView, show keyboard (becomeFirstResponder) to present it
        if textField.inputView != nil {
            textField.becomeFirstResponder()
        }
        onCalendarTap?()
    }

    // MARK: - Phone formatting
    @objc private func phoneTextChanged() {
        guard type == .phone else { return }
        let original = textField.text ?? ""
        let digits = original.filter { $0.isWholeNumber }
        let formatted = formatPhone(digits)
        if formatted != original {
            textField.text = formatted
        }
    }

    private func formatPhone(_ digits: String) -> String {
        // Simple formatting: (XXX) XXX-XXXX for up to 10 digits
        let maxDigits = 10
        let trimmed = String(digits.prefix(maxDigits))
        var result = ""
        let chars = Array(trimmed)
        if chars.count > 0 {
            result += "("
            for i in 0..<min(3, chars.count) { result.append(chars[i]) }
            if chars.count >= 3 { result += ") " }
            if chars.count > 3 {
                let start = 3
                let end = min(6, chars.count)
                for i in start..<end { result.append(chars[i]) }
                if chars.count >= 6 { result += "-" }
            }
            if chars.count > 6 {
                for i in 6..<chars.count { result.append(chars[i]) }
            }
        }
        return result
    }

    // MARK: - Date Picker
    private func setupDatePicker() {
        let picker = UIDatePicker()
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "es_MX")
        picker.maximumDate = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)

        textField.inputView = picker

        // Add toolbar with Done
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Hecho", style: .plain, target: self, action: #selector(datePickerDone))
        toolbar.items = [flex, done]
        textField.inputAccessoryView = toolbar
    }

    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        textField.text = dateFormatter.string(from: sender.date)
    }

    @objc private func datePickerDone() {
        textField.resignFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // For phone type, we allow only digits and formatting will be applied in editingChanged
        if type == .phone {
            // Allow deletion
            if string.isEmpty { return true }
            // Allow only digits
            return string.allSatisfy { $0.isWholeNumber }
        }
        return true
    }
}

// MARK: - Preview
class CustomTextFieldPreviewViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        let phone = CustomTextField(placeholder: "Ingresa tu teléfono", type: .phone, title: "Teléfono")
        let id = CustomTextField(placeholder: "Ingresa ID o escanea con la cámara", type: .idCard, title: "ID Cliente o Número de Tarjeta")
        let date = CustomTextField(placeholder: "DD/MM/AAAA", type: .date, title: "Fecha de Nacimiento")
        let normal = CustomTextField(placeholder: "Campo normal", type: .normal, title: "Normal")

        stack.addArrangedSubview(phone)
        stack.addArrangedSubview(id)
        stack.addArrangedSubview(date)
        stack.addArrangedSubview(normal)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Example callbacks
        id.onCameraTap = { print("Camera tapped") }
        date.onCalendarTap = { print("Calendar tapped") }
    }
}

struct CustomTextFieldRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CustomTextFieldPreviewViewController { CustomTextFieldPreviewViewController() }
    func updateUIViewController(_ uiViewController: CustomTextFieldPreviewViewController, context: Context) {}
}

#Preview {
    CustomTextFieldRepresentable()
}
