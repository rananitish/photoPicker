//
//  ViewController.swift
//  imgPick
//
//  Created by Nitish Rana on 28/03/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var upldBtn: UIButton!
    @IBOutlet weak var imgArea: UIImageView!
    let pickerer = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        upldBtn.setRoundedButton()
        
       
        
    }

    @IBAction func upld(_ sender: Any) {
        
        let ActionSheet = UIAlertController(title: nil, message: "Select Photo", preferredStyle: .actionSheet)  //.alertSheet is a specific style of alert in response to action or control and presents sets of two or more choices

        let cameraPhoto = UIAlertAction(title: "Camera", style: .default, handler: { [self]
               (alert: UIAlertAction) -> Void in
               if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){

                   self.pickerer.mediaTypes = ["public.image"]
                   self.pickerer.sourceType = UIImagePickerController.SourceType.camera;
                   self.present(self.pickerer, animated: true, completion: nil)
               }
               else{
                   UIAlertController(title: "iOSDevCenter", message: "No Camera available.", preferredStyle: .alert).show(self, sender: nil);
               }

           })

           let PhotoLibrary = UIAlertAction(title: "Photo Library", style: .default, handler: {
               (alert: UIAlertAction) -> Void in 
               if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                   self.pickerer.mediaTypes = ["public.image"]
                   self.pickerer.sourceType = UIImagePickerController.SourceType.photoLibrary;
                   self.present(self.pickerer, animated: true, completion: nil)
               }

           })

           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
               (alert: UIAlertAction) -> Void in

           })

           ActionSheet.addAction(cameraPhoto)
           ActionSheet.addAction(PhotoLibrary)
           ActionSheet.addAction(cancelAction)


           if UIDevice.current.userInterfaceIdiom == .pad{
               let presentC : UIPopoverPresentationController  = ActionSheet.popoverPresentationController!
               presentC.sourceView = self.view
               presentC.sourceRect = self.view.bounds
               self.present(ActionSheet, animated: true, completion: nil)
           }
           else{
               self.present(ActionSheet, animated: true, completion: nil)
           }
         //create instance
        print("reached here")
        pickerer.allowsEditing = false
        pickerer.delegate = self
      //delegate to self
       
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("reached here 2")
        guard let image = info[.originalImage] as? UIImage else {return}
        print("3")
        imgArea.image = image
        print("4")
        dismiss(animated: true)
        
        imgArea.setRounded() //as we made an extension now we can use it in our viewController
        
        //we add this in here so after choosing it will appear round
//        { imgArea.layer.borderWidth = 1
//        imgArea.layer.masksToBounds = false
//        imgArea.layer.borderColor = UIColor.black.cgColor
//        imgArea.layer.cornerRadius = imgArea.frame.height/2
//            imgArea.clipsToBounds = true}
        
    }
    
    
}

extension UIImageView{
    func setRounded() {
        let radius = self.frame.width/2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
extension UIButton {
    func setRoundedButton() {
        let radius = self.frame.width/2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}

