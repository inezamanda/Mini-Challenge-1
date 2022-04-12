//
//  AddTaskViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 10/04/22.
//

import UIKit

class EditTaskViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let category = ["Book", "Implementation"]
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var taskName: String?
    var taskCategory: String?
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
    
        taskTextField.returnKeyType = .done
        taskTextField.becomeFirstResponder()
        taskTextField.text = taskName
        taskTextField.delegate = self
        
        categoryTextField.inputView = pickerView
        categoryTextField.text = taskCategory
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @IBAction func onSave(_ sender: Any) {
        print("save")
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        taskCategory = category[row]
        categoryTextField.text = taskCategory
        categoryTextField.resignFirstResponder()
    }
}
