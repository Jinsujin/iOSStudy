//
//  PDFPreviewViewController.swift
//  CustomTabbar
//
//  Created by jsj on 2021/05/09.
//

import UIKit
import PDFKit


class PDFPreviewViewController: UIViewController {

    public var documentData: Data?
    @IBOutlet weak var pdfView: PDFView!
      
    override func viewDidLoad() {
      super.viewDidLoad()
      
      if let data = documentData {
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
      }
    }
}
