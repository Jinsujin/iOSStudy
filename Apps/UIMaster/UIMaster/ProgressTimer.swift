import UIKit


class ProgressTimerViewController: UIViewController {
    
    var timer = Timer()
    
    var totalTime = 50
    var secondsPassed = 0
    
    lazy var progressBar: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.center = self.view.center
        pv.setProgress(0.5, animated: true)
        pv.trackTintColor = UIColor.lightGray
        pv.tintColor = UIColor.blue
        return pv
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(40)
        label.textColor = .lightGray
        return label
    }()
    
    
    lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("시작", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(start), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func start() {
        setupProgressBar()
    }
    
    
    private func setupTextTimer() {
        view.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
            self.totalTime -= 1
            self.numberLabel.alpha = 1
            UIView.setAnimationCurve(.easeInOut)
            
            UIView.animate(withDuration: 1, animations: {
                self.numberLabel.text = String(self.totalTime)
                self.numberLabel.alpha = 0
            }, completion: { (true) in
                
            })
        }
    }
    
    private func setupProgressBar() {
        view.addSubview(progressBar)

        progressBar.progress = 0.0
        secondsPassed = 0
        
        // 방법1. timer 로
//        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        // 방법2. animate 로
        UIView.animate(withDuration: 10) {
            self.progressBar.setProgress(1.0, animated: true)
        }
    }
    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percent = Float(secondsPassed) / Float(totalTime)
            progressBar.setProgress(percent, animated: true)
//            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(progressBar.progress)
        } else {
            timer.invalidate()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
  
    }
}
