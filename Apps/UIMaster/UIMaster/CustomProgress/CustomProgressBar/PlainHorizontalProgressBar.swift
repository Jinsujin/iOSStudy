
import UIKit


class PlainHorizontalProgressBar: UIView {
    var color: UIColor = .gray {
            didSet { setNeedsDisplay() }
        }
    var progress: CGFloat = 0 {
        didSet {
            // 다음 드로잉 사이클(next drawing cycle)동안 View를 업데이트해야 함을 시스템에 알린다. => draw() 를 호출하도록 지시한다.
            setNeedsDisplay()
        }
    }
    
    private let progressLayer = CALayer()
    
    
    init(color: UIColor?, frame: CGRect) {
        super.init(frame: frame)
        
        self.color = color ?? .white
        self.backgroundColor = .gray
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // view를 조작할떄마다 업데이트 하기위해 여기로 들어오게 됨.
    override func draw(_ rect: CGRect) {
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
//        let progressLayer = CALayer()
// - draw 할떄마다 인스턴스를 생성하는것은 적절하지 못하므로, 전역으로 관리하도록 함.
        progressLayer.frame = progressRect
        
//        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color.cgColor
        
        print("draw")
    }
}

