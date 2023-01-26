//
//  ViewController.swift
//  ConvertArrayToButton
//
// 
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var buttonViewHeight: NSLayoutConstraint!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewsButtons(viewArray: Constant.citysArray, viewButtons: buttonView, heightView: buttonViewHeight)
    }
}
//MARK: - Setup
extension ViewController{
    
    func setViewsButtons(viewArray: [String], viewButtons: UIView, heightView: NSLayoutConstraint){
        
        let array = viewArray
        let viewButtons = viewButtons
        var totalWidth = 24
        var oldButtonX = UIButton()
        var oldButtonY = UIButton()
        var height = 0
        var heightConst = heightView
        for i in 1...array.count {
            
            let button = UIButton()
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 6
            button.layer.borderColor = UIColor.systemBrown.cgColor
            button.backgroundColor = UIColor.white
            button.titleLabel?.textAlignment = .center
            
            let newWidth = (array[i-1].count )*10 + 2
            if totalWidth + newWidth < ((Int(view.frame.width)) - 16) {
                
                if i == 1 {
                    
                    button.frame = CGRect(x: 12, y: 12, width: newWidth, height: 36)
                    button.tag = i
                    button.addTarget(self, action: #selector(selectorButton(_:)), for: UIControl.Event.touchDown)
                    button.setTitle(array[button.tag - 1], for: .normal)
                    oldButtonY = button
                    oldButtonX = button
                    viewButtons.addSubview(button)
                    
                    totalWidth += newWidth
                    height += 12
                    
                }else {
                    button.frame = CGRect(x: Int(oldButtonX.frame.maxX) + 8, y: Int(oldButtonY.frame.minY), width: newWidth, height: 36)
                    button.tag = i
                    button.addTarget(self, action: #selector(selectorButton(_:)), for: UIControl.Event.touchDown)
                    button.setTitle(array[button.tag - 1], for: .normal)
                    oldButtonX = button
                    
                    viewButtons.addSubview(button)
                    totalWidth += (newWidth + 12)
                }
            }else {
                totalWidth = 0
                height += 48
                
                button.frame = CGRect(x:12 , y: Int(oldButtonY.frame.maxY) + 12, width: newWidth, height: 36)
                button.tag = i
                button.addTarget(self, action: #selector(selectorButton(_:)), for: UIControl.Event.touchDown)
                button.setTitle(array[button.tag - 1], for: .normal)
                oldButtonY = button
                oldButtonX = button
                
                viewButtons.addSubview(button)
                totalWidth += newWidth
                
            }
            
        }
        
        heightConst.constant = CGFloat(height + 48)
    }
    
}

//MARK: - Button Action
extension ViewController {
    @objc func selectorButton(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = sender.isSelected ? UIColor.systemBrown : UIColor.white
    }
}
