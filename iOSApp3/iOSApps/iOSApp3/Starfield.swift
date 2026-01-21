import UIKit

final class Starfield: UIView {

    private var starLayers: [CAShapeLayer] = []

    override class var layerClass: AnyClass { CAGradientLayer.self }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
        isUserInteractionEnabled = false
    }

    private func setupGradient() {
        guard let g = layer as? CAGradientLayer else { return }
        g.colors = [
            UIColor(red: 0.02, green: 0.03, blue: 0.08, alpha: 1).cgColor,
            UIColor(red: 0.02, green: 0.01, blue: 0.06, alpha: 1).cgColor,
            UIColor.black.cgColor
        ]
        g.startPoint = CGPoint(x: 0.15, y: 0.0)
        g.endPoint = CGPoint(x: 0.85, y: 1.0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        rebuildStars()
    }

    private func rebuildStars() {
        starLayers.forEach { $0.removeFromSuperlayer() }
        starLayers.removeAll()

        let area = bounds.width * bounds.height
        let starCount = min(260, max(110, Int(area / 8000)))

        for i in 0..<starCount {
            let layer = CAShapeLayer()

            let alpha = CGFloat.random(in: 0.18...0.95)
            layer.fillColor = UIColor(white: 1.0, alpha: alpha).cgColor

            let isBright = (i % 9 == 0)
            let baseSize = CGFloat.random(in: 1.0...2.2)
            let size = baseSize * (isBright ? 1.7 : 1.0)

            let x = CGFloat.random(in: 0...bounds.width)
            let y = CGFloat.random(in: 0...bounds.height)

            layer.path = UIBezierPath(ovalIn: CGRect(x: x, y: y, width: size, height: size)).cgPath

            self.layer.addSublayer(layer)
            starLayers.append(layer)
        }
    }
}