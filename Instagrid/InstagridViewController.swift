//
//  ViewController.swift
//  Instagrid
//
//  Created by Diewo Wandianga on 11/06/2020.
//  Copyright © 2020 Diewo Wandianga. All rights reserved.
//

import UIKit

class InstagridViewController: UIViewController {
    
    private var buttonImageTaped: UIButton?
    private var imagePicker: UIImagePickerController? // Ma class hérite de UIImagePickerControllerDelegate et UINavigationControllerDelegate parceque UIImagePickerControllerDelegate  nécessite UINavigationControllerDelegate
    
    
    @IBOutlet weak var centralView: UIView!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var layoutMiddle: UIImageView!
    @IBOutlet weak var layoutRight: UIImageView!
    @IBOutlet weak var layoutLeft: UIImageView!
    
    @IBOutlet weak var buttonImageTopLeft: UIButton!
    
    @IBOutlet weak var buttonImageTopRight: UIButton!
   
    @IBOutlet weak var buttonImageBottomLeft: UIButton!
    
    @IBOutlet weak var buttonImageBottomRight: UIButton!
    
    
    //private var activityController: UIActivityViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setSwipeUpLabel(UIApplication.shared.statusBarOrientation.isPortrait)
        //setSwipeUpLabel(UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? true)
        // Do any additional setup after loading the view.
        layoutRight.isHidden = false
        layoutLeft.isHidden = true
        layoutMiddle.isHidden = true
        
        print("BOOL", UIDevice.current.orientation.isPortrait)
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(SwipeToShare))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(SwipeToShare))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            self.setSwipeUpLabel(UIDevice.current.orientation.isPortrait)
        })
    }
    
    private func setSwipeUpLabel(_ bool: Bool) {
        swipeLabel.text = (bool) ? "^\nSwipe up to share" : "<\nSwipe left to share"
        
//        if bool == true {
//            swipeLabel.text =  "^\nSwipe up to share"
//        } else {
//            swipeLabel.text =  "<\nSwipe left to share"
//        }
        
        
    }
    
    @IBAction func buttonLeftAction(_ sender: Any) {
        
        print("<-----------BUTTON LEFT----------->")
        layoutMiddle.isHidden = true
        layoutRight.isHidden = true
        layoutLeft.isHidden = false
        
        buttonImageTopRight.isHidden = true
        buttonImageBottomRight.isHidden = false
        buttonImageTopLeft.isHidden = false
        
    }
    
    @IBAction func buttonMiddleAction(_ sender: Any) {
        print("<-----------BUTTON MIDDLE----------->")
        layoutRight.isHidden = true
        layoutLeft.isHidden = true
        layoutMiddle.isHidden = false
        
        buttonImageBottomRight.isHidden = true
        buttonImageTopRight.isHidden = false
    }
    
    @IBAction func buttonRightAction(_ sender: Any) {
        print("<-----------BUTTON RIGHT----------->")
        layoutRight.isHidden = false
        layoutLeft.isHidden = true
        layoutMiddle.isHidden = true
        buttonImageBottomRight.isHidden = false
        buttonImageTopRight.isHidden = false
        buttonImageTopLeft.isHidden = false
        buttonImageBottomLeft.isHidden = false
        
    }
    @objc func SwipeToShare (_ gesture: UISwipeGestureRecognizer) {
        guard let imageToShare = centralView.convertedImage() else {return}
        
        print("swipe")
        let items = [imageToShare as UIImage]
        let shareController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(shareController, animated: true)
    }
    
    @IBAction func addImageTaped(_ sender: UIButton){
    print("Ajouter une photo")
        
        guard UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) else {return} // vérification pour savoir si on peut aller dans les photos - savedPhotosAlbum : c’est là que sont stockées les photos

        
        buttonImageTaped = sender // le sender permet de récupérer le button sur lequel on a appuyé, celui d'où vient l'informa°
        
        imagePicker = UIImagePickerController()
        
        imagePicker?.delegate = self // le delegate est fourni par Apple, c'est qque chose dont ma class va hériter. Le delegate permet d’accéder à des fonctions qui ont déjà été faite par le système, récupérer des actions du système.
        // Self = la class. Je me réfère au delegate de la class pour imagePicker.
        
        // Ligne 112 et 118 : configuration du present sinon ne fonctionne pas

        
        imagePicker?.sourceType = .savedPhotosAlbum
        
        guard let secureImagePicker = imagePicker else {return}
        
        present(secureImagePicker, animated: true, completion: nil) // permet d'afficher le ViewController
        
        
    }
    
}

extension InstagridViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //permet de savoir si on a fini de cliquer sur la photo et pouvoir récupérer la photo
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.buttonImageTaped?.setImage(nil, for: .normal)
            
            self.buttonImageTaped?.setBackgroundImage(pickedImage, for: .normal)
            
            self.dismiss(animated: true) {
                self.buttonImageTaped = nil
                self.imagePicker = nil
            }
        }
    }
}
