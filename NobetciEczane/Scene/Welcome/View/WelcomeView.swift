//
//  ViewController.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import UIKit

class WelcomeView: UIViewController {

    @IBOutlet weak var aramaButtonUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        aramaButtonUI.layer.cornerRadius = 10
        let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 18),
                .foregroundColor: UIColor.white
            ]
            
            let attributedTitle = NSAttributedString(string: "Arama Yap", attributes: attributes)
            aramaButtonUI.setAttributedTitle(attributedTitle, for: .normal)
    }
    func navigateToUserInputView(with turkeyData: TurkeyData) {
        DispatchQueue.main.async {
               if let userInputController = self.storyboard?.instantiateViewController(withIdentifier: "UserInputView") as? UserInputView {
                   userInputController.modalPresentationStyle = .fullScreen
                  
                   userInputController.turkeyData = turkeyData
                   self.present(userInputController, animated: true, completion: nil)
               }
           }
        }

    @IBAction func aramaButtonTapped(_ sender: Any) {
        let dataService = TurkeyDataService()
            dataService.fetchTurkeyData { turkeyData in
                if let data = turkeyData {
                    self.navigateToUserInputView(with: data)
                } else {
                    print("Veri çekme işlemi başarısız.")
                }
            }
    }
    
}

