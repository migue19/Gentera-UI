//
//  OTPView.swift
//  Gentera-UI
//
//  Created by Miguel.mexicano on 10/12/25.
//

import UIKit
import SwiftUI

public class OTPView: UIView {
    // MARK: - Properties
    private let numberOfDigits: Int
    private var otpDigits: [String] = []
    private var textFields: [UITextField] = []
    
    public var onOTPComplete: ((String) -> Void)?
    public var onOTPChange: ((String) -> Void)?
    
    private let stackView = UIStackView()
    
    // MARK: - Initialization
    public init(numberOfDigits: Int = 6) {
        self.numberOfDigits = numberOfDigits
        self.otpDigits = Array(repeating: "", count: numberOfDigits)
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        // Configurar constraints del stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Crear los campos de OTP
        for index in 0..<numberOfDigits {
            let textField = createOTPTextField(index: index)
            textFields.append(textField)
            stackView.addArrangedSubview(textField)
            
            // Configurar width del field
            NSLayoutConstraint.activate([
                textField.widthAnchor.constraint(equalToConstant: 50),
                textField.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
    }
    
    private func createOTPTextField(index: Int) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        textField.keyboardType = .numberPad
        textField.textContentType = .oneTimeCode
        textField.delegate = self
        textField.tag = index
        
        // Configurar apariencia
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        
        // Padding
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        // Agregar target para cambios
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        
        return textField
    }
    
    // MARK: - Actions
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let index = textField.tag
        let text = textField.text ?? ""
        
        // Solo permitir un dígito
        if text.count > 1 {
            if let lastChar = text.last {
                textField.text = String(lastChar)
            } else {
                textField.text = ""
            }
        }
        
        // Validar que sea solo números
        if !text.isEmpty && !text.allSatisfy({ $0.isNumber }) {
            textField.text = ""
            return
        }
        
        otpDigits[index] = textField.text ?? ""
        
        // Notificar cambios
        onOTPChange?(getOTP())
        
        // Moverse al siguiente campo si se ingresó un dígito
        if !text.isEmpty && index < numberOfDigits - 1 {
            textFields[index + 1].becomeFirstResponder()
        }
        
        // Si se completó el OTP, notificar
        if getOTP().count == numberOfDigits {
            onOTPComplete?(getOTP())
            textField.resignFirstResponder()
        }
    }
    
    @objc public func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBorderColor(textField, isActive: true)
    }
    
    // MARK: - Public Methods
    public func getOTP() -> String {
        return otpDigits.joined()
    }
    
    public func clearOTP() {
        otpDigits = Array(repeating: "", count: numberOfDigits)
        textFields.forEach { $0.text = "" }
        textFields.first?.becomeFirstResponder()
    }
    
    public func setOTP(_ otp: String) {
        clearOTP()
        let digits = Array(otp.prefix(numberOfDigits))
        for (index, digit) in digits.enumerated() {
            if digit.isNumber {
                textFields[index].text = String(digit)
                otpDigits[index] = String(digit)
            }
        }
    }
    
    public func focusFirstField() {
        textFields.first?.becomeFirstResponder()
    }
    
    // MARK: - Private Methods
    private func updateBorderColor(_ textField: UITextField, isActive: Bool) {
        let color = isActive ? UIColor.black : UIColor.lightGray
        textField.layer.borderColor = color.cgColor
    }
}

// MARK: - UITextFieldDelegate
extension OTPView: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // Solo permitir un dígito y validar que sea número
        if newText.count > 1 || (!newText.isEmpty && !newText.allSatisfy({ $0.isNumber })) {
            return false
        }
        
        return true
    }
    
    public func textFieldDidEndEditing(_ UITextField: UITextField) {
        updateBorderColor(UITextField, isActive: false)
    }
}

// MARK: - SwiftUI Preview
#if DEBUG
struct OTPViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> OTPView {
        let otpView = OTPView(numberOfDigits: 6)
        otpView.onOTPComplete = { otp in
            print("OTP completado: \(otp)")
        }
        otpView.onOTPChange = { otp in
            print("OTP actual: \(otp)")
        }
        return otpView
    }
    
    func updateUIView(_ uiView: OTPView, context: Context) {}
}

#Preview {
    VStack(spacing: 20) {
        OTPViewPreview()
            .frame(height: 80)
        Spacer()
    }
    .padding()
}
#endif
