//
//  ViewController.swift
//  ALcamera
//
//  Created by Krishna Kushwaha on 16/12/20.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imgBtn: UIButton!
    
    fileprivate lazy var docInteractionController: UIDocumentInteractionController = {
        return UIDocumentInteractionController()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func uploadImg(_ sender: Any) {
        uploadPhoto()
//        uploadPDF()
    }
    @IBAction func tncBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TncViewController") as? TncViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)


    }
    func uploadPDF() {
        let docPicker =  UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData), String(kUTTypePNG),String(kUTTypeJPEG)], in: .open)
         
        docPicker.delegate = self
        self.present(docPicker, animated: true, completion: nil)
    }

    

    func uploadPhoto() {
        
        let prompt = UIAlertController(title: "Choose a Photo",
                                       message: "Please choose a photo.",
                                       preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        
        
        imagePicker.delegate = self
        
        
        func presentCamera(_ _: UIAlertAction) {
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default,
                                         handler: presentCamera)
        
        func presentLibrary(_ _: UIAlertAction) {
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        
        let libraryAction = UIAlertAction(title: "Photo Library",
                                          style: .default,
                                          handler: presentLibrary)
        
        func presentAlbums(_ _: UIAlertAction) {
            uploadPDF()
//            imagePicker.sourceType = .savedPhotosAlbum
//
//            self.present(imagePicker, animated: true)
        }
        
        let albumsAction = UIAlertAction(title: "Pdf Files",
                                         style: .default,
                                         handler: presentAlbums)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        prompt.addAction(cameraAction)
        prompt.addAction(libraryAction)
        prompt.addAction(albumsAction)
        prompt.addAction(cancelAction)
        
        self.present(prompt, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
          
          func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
              // Dismiss picker, returning to original root viewController.
              dismiss(animated: true, completion: nil)
          }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
           {
        
            // Extract chosen image.
            if let ProcessImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                       

                imgBtn.setBackgroundImage(ProcessImg, for: .normal)
                
                self.dismiss(animated: true, completion: nil)

            }
    }
     
}

extension ViewController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print(urls)

        imgBtn.setBackgroundImage(drawPDFfromURL(url: urls.first!), for: .normal)
        }
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }
        guard let page = document.page(at: 1) else { return nil }

        let pageRect = page.getBoxRect(.mediaBox)
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
        let img = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(page)
        }

        return img
    }
}
