
import UIKit


class CircleProgress: UIView {
    var color: UIColor = .gray {
            didSet { setNeedsDisplay() }
        }
    var progress: CGFloat = 0 {
        didSet {
            // 다음 드로잉 사이클(next drawing cycle)동안 View를 업데이트해야 함을 시스템에 알린다. => draw() 를 호출하도록 지시한다.
            setNeedsDisplay()
        }
    }
    
    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()
    
    
    init(color: UIColor?, frame: CGRect) {
        super.init(frame: frame)
        
        self.color = color ?? .white
        self.backgroundColor = .gray
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayers() {
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask
        
        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        progressLayer.strokeColor = color.cgColor
        layer.addSublayer(progressLayer)
        // 전체 레이어를 회전해서 시작 지점을 맞춤.
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }
    
    private let ringWidth: CGFloat = 20
    
    // view를 조작할떄마다 업데이트 하기위해 여기로 들어오게 됨.
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: 100 / 2, dy: 100 / 2))
        backgroundMask.path = circlePath.cgPath
        
        progressLayer.path = circlePath.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        print("draw")
    }
}

