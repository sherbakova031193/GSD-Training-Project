//
//  SecondViewController.swift
//  GSD
//
//  Created by Елизавета Щербакова on 20.03.2020.
//  Copyright © 2020 Sсherbakova Elizaveta Nikolaevna. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicatorView.stopAnimating()
            activityIndicatorView.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        fetchImage()
        delay(3) {
            self.logInAlert()
        }
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func logInAlert() {
        let ac = UIAlertController(title: "Зарегистрированы?", message: "Введите ваш логин и пароль", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { (userNameTF) in
            userNameTF.placeholder = "Введите логин"
        }
        
        ac.addTextField { (passwordTF) in
            passwordTF.placeholder = "Введите пароль"
            passwordTF.isSecureTextEntry = true
            
        }
        
        self.present(ac, animated: true)
        
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://img1.akspic.ru/image/128733-trollstigen-pustynya-fjord-gornyj_hrebet-alpy-3840x2160.jpg")
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
