//
//  ViewController.swift
//  Gentera-UI-App
//
//  Created by Miguel.mexicano on 16/12/25.
//

import UIKit
import Gentera_UI

class ViewController: UIViewController {
    
    enum ComponentType: String, CaseIterable {
        case customButton = "CustomButton - Botones Personalizados"
        case customLabel = "CustomLabel - Etiquetas"
        case customTextField = "CustomTextField - Campos de Entrada"
        case customProgress = "CustomProgress - Barra de Progreso"
        case otpView = "OTPView - Entrada de OTP"
        case stepView = "StepView - Pasos de Progreso"
        case termsView = "TermsView - Términos y Condiciones"
        case progressHUD = "ProgressHUDView - Indicador de Carga"
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.backgroundColor = .systemBackground
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Componentes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Preview Controllers
    
    private func showCustomButtonPreview() {
        let vc = PreviewViewController(title: "CustomButton")
        vc.setupButtonPreview = { container in
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 16
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            let primaryBtn = CustomButton(title: "Botón Primario", style: .primary)
            let secondaryBtn = CustomButton(title: "Botón Secundario", style: .secondary)
            let linkBtn = CustomButton(title: "Botón Link", style: .link)
            
            stack.addArrangedSubview(primaryBtn)
            stack.addArrangedSubview(secondaryBtn)
            stack.addArrangedSubview(linkBtn)
            container.backgroundColor = .lightGray
            container.addSubview(stack)
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
            ])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showCustomLabelPreview() {
        let vc = PreviewViewController(title: "CustomLabel")
        vc.setupButtonPreview = { container in
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 16
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            let label1 = CustomLabel(text: "Etiqueta Primaria", style: .title)
            let label2 = CustomLabel(text: "Etiqueta Secundaria", style: .subtitle)
            let label3 = CustomLabel(text: "Texto largo que se puede romper en múltiples líneas sin problemas", style: .subtitle)
            label3.numberOfLines = 0
            
            stack.addArrangedSubview(label1)
            stack.addArrangedSubview(label2)
            stack.addArrangedSubview(label3)
            
            container.backgroundColor = .white
            container.addSubview(stack)
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
            ])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showCustomTextFieldPreview() {
        let vc = PreviewViewController(title: "CustomTextField")
        vc.setupButtonPreview = { container in
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 16
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            let phone = CustomTextField(placeholder: "Ingresa tu teléfono", type: .phone, title: "Teléfono")
            let id = CustomTextField(placeholder: "Ingresa ID o escanea con la cámara", type: .idCard, title: "ID Cliente o Número de Tarjeta")
            let date = CustomTextField(placeholder: "DD/MM/AAAA", type: .date, title: "Fecha de Nacimiento")
            let normal = CustomTextField(placeholder: "Campo normal", type: .normal, title: "Normal")
            
            stack.addArrangedSubview(phone)
            stack.addArrangedSubview(id)
            stack.addArrangedSubview(date)
            stack.addArrangedSubview(normal)
            
            container.addSubview(stack)
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
            ])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showCustomProgressPreview() {
        let vc = PreviewViewController(title: "CustomProgress")
        vc.setupButtonPreview = { container in
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 20
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            let progress1 = CustomProgressView()
            progress1.progress = 0.25
            
            let progress2 = CustomProgressView()
            progress2.progress = 0.5
            
            let progress3 = CustomProgressView()
            progress3.progress = 0.75
            
            let progress4 = CustomProgressView()
            progress4.progress = 1.0
            
            stack.addArrangedSubview(progress1)
            stack.addArrangedSubview(progress2)
            stack.addArrangedSubview(progress3)
            stack.addArrangedSubview(progress4)
            
            container.addSubview(stack)
            NSLayoutConstraint.activate([
                stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20)
            ])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showOTPViewPreview() {
        let vc = PreviewViewController(title: "OTPView")
        vc.setupButtonPreview = { container in
            let otp = OTPView(numberOfDigits: 6)
            otp.translatesAutoresizingMaskIntoConstraints = false
            
            otp.onOTPComplete = { code in
                print("OTP completado: \(code)")
            }
            
            container.addSubview(otp)
            NSLayoutConstraint.activate([
                otp.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                otp.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                otp.heightAnchor.constraint(equalToConstant: 60)
            ])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showStepViewPreview() {
        let vc = PreviewViewController(title: "StepView")
        vc.setupButtonPreview = { container in
            let stepView = StepView()
            stepView.translatesAutoresizingMaskIntoConstraints = false
            
            container.addSubview(stepView)
            NSLayoutConstraint.activate([
                stepView.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                stepView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                stepView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
                stepView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showTermsViewPreview() {
        let vc = PreviewViewController(title: "TermsView")
        vc.setupButtonPreview = { container in
            let termsView = TermsView()
            termsView.translatesAutoresizingMaskIntoConstraints = false
            
            container.addSubview(termsView)
            NSLayoutConstraint.activate([
                termsView.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
                termsView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
                termsView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
                termsView.heightAnchor.constraint(equalToConstant: 80)
            ])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showProgressHUDPreview() {
        let vc = PreviewViewController(title: "ProgressHUDView")
        vc.setupButtonPreview = { container in
            let hud = ProgressHUDView(animationName: "Loader")
            hud.translatesAutoresizingMaskIntoConstraints = false
            
            container.addSubview(hud)
            NSLayoutConstraint.activate([
                hud.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                hud.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                hud.widthAnchor.constraint(equalToConstant: 100),
                hud.heightAnchor.constraint(equalToConstant: 100)
            ])
            
            hud.present(on: container, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                hud.dismiss()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ComponentType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let component = ComponentType.allCases[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = component.rawValue
        config.secondaryText = "Toca para ver preview"
        config.secondaryTextProperties.color = .systemGray
        
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let component = ComponentType.allCases[indexPath.row]
        
        switch component {
        case .customButton:
            showCustomButtonPreview()
        case .customLabel:
            showCustomLabelPreview()
        case .customTextField:
            showCustomTextFieldPreview()
        case .customProgress:
            showCustomProgressPreview()
        case .otpView:
            showOTPViewPreview()
        case .stepView:
            showStepViewPreview()
        case .termsView:
            showTermsViewPreview()
        case .progressHUD:
            showProgressHUDPreview()
        }
    }
}

// MARK: - Preview Controller

class PreviewViewController: UIViewController {
    var setupButtonPreview: ((UIView) -> Void)?
    private let componentTitle: String
    
    init(title: String) {
        self.componentTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = componentTitle
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        setupButtonPreview?(containerView)
    }
}
