//
//  StepView.swift
//  Gentera-UI
//
//  Created by Miguel Mexicano Herrera on 05/12/25.
//

import UIKit
import SwiftUI

public class StepView: UIView {
    // Subviews
    public lazy var progress: CustomProgressView = {
        let p = CustomProgressView()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()

    private lazy var stepLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lbl.textColor = .darkGray
        lbl.textAlignment = .right
        return lbl
    }()

    private lazy var stack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.alignment = .fill
        s.spacing = 8
        return s
    }()

    // Config
    public var progressHeight: CGFloat = 8 {
        didSet { progress.heightAnchor.constraint(equalToConstant: progressHeight).isActive = true }
    }

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

        // Progress defaults
        progress.trackTintColor = UIColor(white: 0.93, alpha: 1)
        // progress.progressTintColor left as default or caller can set it
        progressHeight = 8

        // Stack: vertical (progress above, label below)
        addSubview(stack)
        stack.addArrangedSubview(progress)
        stack.addArrangedSubview(stepLabel)

        // Priorities: progress expands, label hugs
        progress.setContentHuggingPriority(.defaultLow, for: .horizontal)
        progress.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        stepLabel.setContentHuggingPriority(.required, for: .horizontal)
        stepLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Make sure progress has a height
            progress.heightAnchor.constraint(equalToConstant: progressHeight),
            heightAnchor.constraint(equalToConstant: 46)
        ])
    }

    // MARK: - API
    public func setStep(current: Int, total: Int) {
        stepLabel.text = "\(current) de \(total)"
    }

    public func setProgress(_ value: CGFloat, animated: Bool) {
        progress.setProgress(value, animated: animated)
    }

    // Expose convenience to configure colors
    public func configure(trackColor: UIColor? = nil, progressColor: UIColor? = nil) {
        if let t = trackColor { progress.trackTintColor = t }
        if let p = progressColor { progress.progressTintColor = p }
    }
}

// Preview
class StepViewPreviewController: UIViewController {
    // convert preview stepView to lazy var
    private lazy var stepView: StepView = {
        let v = StepView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setStep(current: 1, total: 3)
        v.setProgress(0.35, animated: false)
        v.configure(trackColor: UIColor(white: 0.95, alpha: 1), progressColor: .black)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(stepView)
        NSLayoutConstraint.activate([
            stepView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stepView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stepView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

struct StepViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> StepViewPreviewController { StepViewPreviewController() }
    func updateUIViewController(_ uiViewController: StepViewPreviewController, context: Context) {}
}

#Preview {
    StepViewRepresentable()
}
