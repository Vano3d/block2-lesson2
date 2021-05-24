//
//  ViewController.swift
//  Lesson2
//
//  Created by Chupinsky Ivan on 21.05.2021.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

class ViewController: UIViewController {

    
    @IBOutlet weak var viewColor: UIView!
    
    @IBOutlet weak var sliderRed: UISlider!
    @IBOutlet weak var sliderGreen: UISlider!
    @IBOutlet weak var sliderBlue: UISlider!
    @IBOutlet weak var sliderOpacity: UISlider!
    
    @IBOutlet weak var valueRed: UILabel!
    @IBOutlet weak var valueGreen: UILabel!
    @IBOutlet weak var valueBlue: UILabel!
    
    @IBOutlet weak var hexColor: UILabel!
    
    @IBOutlet weak var copyButton: UIButton!
    
    func myMessage(messTitle: String, messMessage: String, messBtnTitle: String) {
        let alert = UIAlertController(title: messTitle, message: messMessage, preferredStyle: .alert)
         
        alert.addAction(UIAlertAction(title: messBtnTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewColor.layer.cornerRadius = 20
        viewColor.layer.masksToBounds = true
        
        viewColor.backgroundColor = UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: CGFloat(sliderOpacity.value))
        
        copyButton.layer.borderWidth = 1
        copyButton.layer.borderColor = UIColor.white.cgColor
        copyButton.layer.cornerRadius = 10
        copyButton.isHidden = true
    }

    @IBAction func movingSliderRed() {
        valueRed.text = String(format: "%.1f", sliderRed.value)
        valueGreen.text = String(format: "%.1f", sliderGreen.value)
        valueBlue.text = String(format: "%.1f", sliderBlue.value)
        
        let bgColor = UIColor(red: CGFloat(sliderRed.value), green: CGFloat(sliderGreen.value), blue: CGFloat(sliderBlue.value), alpha: CGFloat(sliderOpacity.value))
        
        viewColor.backgroundColor = bgColor
        
        hexColor.text = bgColor.toHexString()
        
        copyButton.isHidden = false
        
    }
    
    @IBAction func tappedCopyButton(_ sender: Any) {
        UIPasteboard.general.string = hexColor.text
        myMessage(messTitle: "Hex code copied", messMessage: "without opacity value", messBtnTitle: "OK")
    }
    
}
