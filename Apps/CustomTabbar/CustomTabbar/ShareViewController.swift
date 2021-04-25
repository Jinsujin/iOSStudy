//
//  ShareViewController.swift
//  CustomTabbar
//
//  Created by jsj on 2021/04/26.
//

import UIKit

class ShareViewController: UIViewController, UIDocumentInteractionControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func touchedShareString(_ sender: Any) {
        let stringWithLink = "https://google.com"
        
        let activityController = UIActivityViewController(activityItems: [stringWithLink], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed!")
            } else {
                print("cancled")
            }
        }
        
        present(activityController, animated: true) {
            print("presented")
        }
    }
    
    
    
    @IBAction func touchedShareImage(_ sender: Any) {
        let image = #imageLiteral(resourceName: "img_snack")
        
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { (nil, completed, _, error) in
            if completed {
                print("completed!")
            } else {
                print("cancled")
            }
        }
        
        present(activityController, animated: true) {
            print("presented")
        }
    }
    
    
    @IBAction func touchedSharePDF(_ sender: Any) {
        
        guard let url = Bundle.main.url(forResource: "eggRecipe", withExtension: "pdf") else { return }
        let controller = UIDocumentInteractionController(url: url)
        controller.delegate = self
        controller.presentPreview(animated: true)
        
    }
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
