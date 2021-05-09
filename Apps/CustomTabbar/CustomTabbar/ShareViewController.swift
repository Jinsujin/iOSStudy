//
//  ShareViewController.swift
//  CustomTabbar
//
//  Created by jsj on 2021/04/26.
//

import UIKit
import PDFKit

class ShareViewController: UIViewController, UIDocumentInteractionControllerDelegate {

    // share pdf data
    private let image = #imageLiteral(resourceName: "img_snack")
    private let textTitle = "Share PDF Data"
    private let textBody = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    private let textContact = "https://www.naver.com"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "previewSegue" {
        guard let vc = segue.destination as? PDFPreviewViewController else { return }
        
          let pdfCreator = PDFCreator(title: textTitle, body: textBody,
                                      image: image, contact: textContact)
          vc.documentData = pdfCreator.createFlyer()
      }
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
        // pdf 파일을 생성하고, UIActivityViewController로 파일 공유
        let pdfCreator = PDFCreator(
          title: textTitle,
          body: textBody,
          image: image,
          contact: textContact
        )
        let pdfData = pdfCreator.createFlyer()
        let vc = UIActivityViewController(
          activityItems: [pdfData],
          applicationActivities: []
        )
        present(vc, animated: true, completion: nil)

        
    }
    
    
    /* pdf file share */
//    @IBAction func touchedSharePDF(_ sender: Any) {
        /* pdf file share */
        //        guard let url = Bundle.main.url(forResource: "eggRecipe", withExtension: "pdf") else { return }
//        let controller = UIDocumentInteractionController(url: url)
//        controller.delegate = self
//        controller.presentPreview(animated: true)
//    }
    
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }

    
}
