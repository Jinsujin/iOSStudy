import UIKit
import RxSwift
import RxCocoa

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoDetailViewModel!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        // 네비게이션 타이틀 바인딩
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        // 테이블뷰 바인딩
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
        }
        .disposed(by: rx.disposeBag)
        
        // 편집버튼 event - Action 활용
        self.editButton.rx.action = viewModel.makeEditAction()
        
        // 공유버튼 event - tap 속성 활용
        // 더블탭을 막기위함. 0.5초마다 한번씩만 탭이벤트 전달
        shareButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  _ in
                guard let memo = self?.viewModel.memo.content else { return }
                
                let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
                self?.present(vc, animated: true, completion: nil)
            })
            .disposed(by: rx.disposeBag)
        
        // 삭제버튼 event -  Action
        deleteButton.rx.action = viewModel.makeDeleteAction()
        
//        
//        // barbuttonitem 생성
//        var backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
//        viewModel.title
//            .drive(backButton.rx.title)
//            .disposed(by: rx.disposeBag)
//        
//        // popaction 바인딩
//        backButton.rx.action = viewModel.popAction
//        
//        navigationItem.hidesBackButton = true
//        
//        // default back 버튼. 대체
//        navigationItem.leftBarButtonItem = backButton
    }
    
    

}
