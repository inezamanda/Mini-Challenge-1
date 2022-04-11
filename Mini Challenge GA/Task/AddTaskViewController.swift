//
//  AddTaskViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 10/04/22.
//

import UIKit

protocol AddTaskControllerDelegate {
    func onSave()
}

class AddTaskViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var viewDelegate: AddTaskControllerDelegate?
    
    let category = ["Book", "Implementation"]
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var selectCategoryTextField: UITextField!
    @IBOutlet weak var doneUIBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var cancelUIBarButtonItem: UIBarButtonItem!
    
    @IBAction func onSave(_ sender: Any) {
        //print("save")
        
        listTask.append(Task(name: newTaskTextField.text!, status: "not started", category: selectCategoryTextField.text!))
        viewDelegate?.onSave()
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        
        newTaskTextField.returnKeyType = .done
        newTaskTextField.becomeFirstResponder()
        newTaskTextField.delegate = self
        
        selectCategoryTextField.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onSave(self)
        
        return true
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
        selectCategoryTextField.text = category[row]
        selectCategoryTextField.resignFirstResponder()
    }
}

