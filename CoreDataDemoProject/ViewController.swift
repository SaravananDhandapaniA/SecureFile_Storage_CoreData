//
//  ViewController.swift
//  CoreDataDemoProject
//
//  Created by Tringapps on 08/02/23.
//

import UIKit
import CoreData
import UniformTypeIdentifiers
import PDFKit

class ViewController: UIViewController, UIDocumentPickerDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var pdfs: [PDFData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchPDF()
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFile = urls.first else {return}
        let pdfName = selectedFile.lastPathComponent
        let pdfData = try! Data(contentsOf: selectedFile)
        self.savePDF(name: pdfName, data: pdfData)
    }
    
    func fetchPDF() {
        let fetchRequest = NSFetchRequest<PDFData>(entityName: "PDFData")
        do {
            pdfs = try managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch {
            print("Error while fetching PDF data")
        }
    }
    
    func savePDF(name: String, data: Data) {
        let pdf = PDFData(context: managedContext)
        pdf.pdfName = name
        pdf.pdfFile = data
        do {
            try managedContext.save()
        } catch {
            print("Error while saving PDF data")
        }
        fetchPDF()
    }
}


extension ViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pdfs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListDataTableCell else {return UITableViewCell()}
        cell.fileNameLabel.text = pdfs[indexPath.row].pdfName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let pdfViewController = PDFViewController()
        pdfViewController.pdfDocument = PDFDocument(data: pdfs[indexPath.row].pdfFile!)
        navigationController?.pushViewController(pdfViewController, animated: true)
    }

}
