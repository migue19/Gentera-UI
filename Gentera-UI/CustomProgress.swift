//
//  CustomProgress.swift
//  Gentera-UI
//
//  Created by Miguel Mexicano Herrera on 05/12/25.
//

import UIKit
import SwiftUI

public class CustomProgressView: UIView {
    // Public configuration
    public var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1) { didSet { trackView.backgroundColor = trackTintColor }}
    public var progressTintColor: UIColor = UIColor.black { didSet { progressView.backgroundColor = progressTintColor }}
    public var cornerRadius: CGFloat = 8 { didSet { setNeedsLayout() }}
    public var showsPercentage: Bool = false { didSet { percentageLabel.isHidden = !showsPercentage; setNeedsLayout() }}

    // Internal views
    private lazy var trackView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = trackTintColor
        v.layer.masksToBounds = true
        return v
    }()

    private lazy var progressView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = progressTintColor
        v.layer.masksToBounds = true
        v.layer.zPosition = 1
        return v
    }()

    private lazy var percentageLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.isHidden = !showsPercentage
        return lbl
    }()

    // Progress value (0.0 - 1.0)
    private var internalProgress: CGFloat = 0.0
    public var progress: CGFloat {
        get { internalProgress }
        set { setProgress(newValue, animated: false) }
    }

    // Animation
    public var animationDuration: TimeInterval = 0.25

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

        // Track
        // Add configured trackView
        addSubview(trackView)
        // Ensure colors are correctly applied in case properties were set before lazy initialization
        trackView.backgroundColor = trackTintColor
        progressView.backgroundColor = progressTintColor
        // Allow trackView to expand while stepLabel hugs its intrinsic width
        trackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        trackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        // Progress
        // Add configured progressView inside track
        trackView.addSubview(progressView)

        // Percentage label
        addSubview(percentageLabel)

        setupConstraints()
        isAccessibilityElement = true
        accessibilityTraits = .updatesFrequently
        updateAccessibility()
    }

    private var progressWidthConstraint: NSLayoutConstraint?
    private var trackViewMinHeightConstraint: NSLayoutConstraint?

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Track on the left, step label on the right in the same row
            trackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackView.topAnchor.constraint(equalTo: topAnchor),
            trackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            // Percentage label centered inside the track (overlay)
            percentageLabel.centerXAnchor.constraint(equalTo: trackView.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: trackView.centerYAnchor),
        ])

        // progressView width will be managed by a proportional constraint to trackView's width
        progressWidthConstraint = progressView.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: max(0.0, min(1.0, internalProgress)))
        progressWidthConstraint?.isActive = true
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            progressView.topAnchor.constraint(equalTo: trackView.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: trackView.bottomAnchor),
        ])

        // Ensure trackView has a minimum height so progress is visible even when container is small
        trackViewMinHeightConstraint = trackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 6)
        trackViewMinHeightConstraint?.isActive = true
    }
    // MARK: - Step Label removed: use StepView instead

    public override func layoutSubviews() {
        super.layoutSubviews()
        // Corner radius
        // Make the bar pill-shaped by capping cornerRadius to half the track height
        let height = trackView.bounds.height
        let radius = min(cornerRadius, height / 2)
        trackView.layer.cornerRadius = radius
        progressView.layer.cornerRadius = radius
        trackView.layer.masksToBounds = true
        progressView.layer.masksToBounds = true

        // Bring percentage label to front so it renders above the track/progress
        if showsPercentage { bringSubviewToFront(percentageLabel) }

        updateAccessibility()
    }

    // MARK: - Public API
    public func setProgress(_ newProgress: CGFloat, animated: Bool) {
        let clamped = min(1.0, max(0.0, newProgress))
        internalProgress = clamped
        percentageLabel.text = String(format: "%d%%", Int(clamped * 100))

        // Replace proportional constraint with new multiplier
        if let existing = progressWidthConstraint { existing.isActive = false }
        progressWidthConstraint = progressView.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: clamped)
        progressWidthConstraint?.isActive = true

        if animated {
            UIView.animate(withDuration: animationDuration) {
                self.superview?.layoutIfNeeded()
            }
        } else {
            self.superview?.layoutIfNeeded()
        }
        updateAccessibility()
    }

    // Convenience: set progress with optional animation and completion
    public func setProgress(_ newProgress: CGFloat, animated: Bool, completion: ((Bool) -> Void)?) {
        let clamped = min(1.0, max(0.0, newProgress))
        internalProgress = clamped
        percentageLabel.text = String(format: "%d%%", Int(clamped * 100))

        if let existing = progressWidthConstraint { existing.isActive = false }
        progressWidthConstraint = progressView.widthAnchor.constraint(equalTo: trackView.widthAnchor, multiplier: clamped)
        progressWidthConstraint?.isActive = true

        if animated {
            UIView.animate(withDuration: animationDuration, animations: {
                self.superview?.layoutIfNeeded()
            }, completion: completion)
        } else {
            self.superview?.layoutIfNeeded()
            completion?(true)
        }
        updateAccessibility()
    }

    private func updateAccessibility() {
        accessibilityLabel = "Progreso"
        accessibilityValue = String(format: "%d%%", Int(internalProgress * 100))
    }

    // Intrinsic content size: provide a default height
    public override var intrinsicContentSize: CGSize {
        // If percentage is shown, provide larger height to accommodate label
        let height: CGFloat = showsPercentage ? 28 : 8
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}

// MARK: - Preview
class CustomProgressPreviewViewController: UIViewController {
    private lazy var stack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 16
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var p1: CustomProgressView = {
        let p = CustomProgressView()
        p.trackTintColor = UIColor(white: 0.93, alpha: 1)
        p.progressTintColor = UIColor.black
        p.cornerRadius = 6
        p.showsPercentage = false
        p.translatesAutoresizingMaskIntoConstraints = false
        p.heightAnchor.constraint(equalToConstant: 16).isActive = true
        p.setProgress(0.3, animated: false)
        return p
    }()

    private lazy var p2: CustomProgressView = {
        let p = CustomProgressView()
        p.trackTintColor = UIColor(white: 0.95, alpha: 1)
        p.progressTintColor = UIColor.systemGreen
        p.showsPercentage = true
        p.translatesAutoresizingMaskIntoConstraints = false
        p.heightAnchor.constraint(equalToConstant: 24).isActive = true
        p.setProgress(0.45, animated: false)
        return p
    }()

    private lazy var progress: CustomProgressView = {
        let p = CustomProgressView()
        p.trackTintColor = UIColor(white: 0.93, alpha: 1)
        p.progressTintColor = UIColor.systemIndigo
        p.showsPercentage = true
        p.translatesAutoresizingMaskIntoConstraints = false
        p.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return p
    }()

    private var timer: Timer?
    private var value: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(stack)

        // Add examples
        stack.addArrangedSubview(p1)
        stack.addArrangedSubview(p2)

        // Animated progress demo for the top-level 'progress' property
        stack.addArrangedSubview(progress)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        progress.setProgress(0.0, animated: false)
        startDemoTimer()
    }

    private func startDemoTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.value += 0.08
            if self.value > 1.0 { self.value = 0 }
            self.progress.setProgress(self.value, animated: true)
        }
    }

    deinit {
        timer?.invalidate()
    }
}

struct CustomProgressRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CustomProgressPreviewViewController { CustomProgressPreviewViewController() }
    func updateUIViewController(_ uiViewController: CustomProgressPreviewViewController, context: Context) {}
}

#Preview {
    CustomProgressRepresentable()
}
