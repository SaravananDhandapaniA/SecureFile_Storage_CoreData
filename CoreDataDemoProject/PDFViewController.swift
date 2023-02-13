//
//  PDFViewController.swift
//  CoreDataDemoProject
//
//  Created by Tringapps on 08/02/23.
//
import UIKit
import PDFKit

class PDFViewController: UIViewController {
  
  var pdfDocument: PDFDocument!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
      showPdf()
   
  }
    
    func showPdf() {
        let pdfView = PDFView(frame: view.frame)
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        view.addSubview(pdfView)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
    }
  
  @objc func backButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
}
