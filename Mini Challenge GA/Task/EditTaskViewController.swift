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
    
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
    
        let cancelUIBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancelBtn))
        self.navigationItem.leftBarButtonItem  = cancelUIBarButtonItem
        
        let doneUIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneBtn))
        self.navigationItem.rightBarButtonItem  = doneUIBarButtonItem
        
        taskTextField.returnKeyType = .done
        taskTextField.becomeFirstResponder()
        taskTextField.delegate = self
        
        categoryTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc private func didTapCancelBtn(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDoneBtn(){
        // Add user input to tableview
        print("save")
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
        categoryTextField.text = category[row]
        categoryTextField.resignFirstResponder()
    }
}
