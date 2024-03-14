//
//  UserInputView.swift
//  NobetciEczane
//
//  Created by yekta on 13.03.2024.
//

import UIKit

class UserInputView: UIViewController {
    var turkeyData: TurkeyData?
    var viewModel: UserInputViewModel?

    let provincePickerView = UIPickerView()
    let districtPickerView = UIPickerView()

    let provinceTextField = UITextField()
    let districtTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = turkeyData {
            viewModel = UserInputViewModel(turkeyData: data)
            print("Alınan veri: \(data)")
        }

        setupProvincePickerView()
        setupDistrictPickerView()
        setupProvinceTextField()
        setupDistrictTextField()
        setupSearchButton()
    }

    func setupSearchButton() {
        let searchButton = UIButton(type: .system)
        searchButton.setTitle("Ara", for: .normal)
        searchButton.backgroundColor = .button
        searchButton.layer.cornerRadius = 10
        searchButton.tintColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: districtTextField.bottomAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func searchButtonTapped() {
        let selectedProvince = provinceTextField.text ?? "İl seçilmedi"
           let selectedDistrict = districtTextField.text ?? "İlçe seçilmedi"
           
           if provinceTextField.text != "" && districtTextField.text != "" {
               if let listView = storyboard?.instantiateViewController(withIdentifier: "ListView") as? ListView {
                   listView.selectedProvince = selectedProvince
                   listView.selectedDistrict = selectedDistrict
                   let navigationController = UINavigationController(rootViewController: listView)
                   navigationController.modalPresentationStyle = .fullScreen
                   present(navigationController, animated: true, completion: nil)
               }
           } else {
               print("Lütfen bir il ve ilçe seçiniz.")
           }
    }


    
    func createToolbar(for pickerType: PickerType) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem

        switch pickerType {
        case .province:
            doneButton = UIBarButtonItem(title: "Seç", style: .plain, target: self, action: #selector(dismissProvincePicker))
        case .district:
            doneButton = UIBarButtonItem(title: "Seç", style: .plain, target: self, action: #selector(dismissDistrictPicker))
        }
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }

    enum PickerType {
        case province
        case district
    }


    @objc func dismissProvincePicker() {
        view.endEditing(true)
        districtTextField.becomeFirstResponder()
    }

    @objc func dismissDistrictPicker() {
        view.endEditing(true)
    }


    func setupProvinceTextField() {
        provinceTextField.placeholder = "İl Seçiniz"
        view.addSubview(provinceTextField)
        provinceTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            provinceTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            provinceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            provinceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            provinceTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        provinceTextField.inputView = provincePickerView
        provinceTextField.inputAccessoryView = createToolbar(for: .province)
    }

    func setupDistrictTextField() {
        districtTextField.placeholder = "İlçe Seçiniz"
        view.addSubview(districtTextField)
        districtTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            districtTextField.topAnchor.constraint(equalTo: provinceTextField.bottomAnchor, constant: 20),
            districtTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            districtTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            districtTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        districtTextField.inputView = districtPickerView
        districtTextField.inputAccessoryView = createToolbar(for: .district)
    }

    func setupProvincePickerView() {
        provincePickerView.delegate = self
        provincePickerView.dataSource = self
    }

    func setupDistrictPickerView() {
        districtPickerView.delegate = self
        districtPickerView.dataSource = self
    }
}

extension UserInputView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == provincePickerView {
            return viewModel?.provinces().count ?? 0
        } else {
            return viewModel?.districtsForSelectedProvince().count ?? 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == provincePickerView {
            return viewModel?.provinces()[row]
        } else {
            return viewModel?.districtsForSelectedProvince()[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == provincePickerView {
            let selectedProvince = viewModel?.provinces()[row]
            provinceTextField.text = selectedProvince
            viewModel?.selectProvince(at: row)

            districtTextField.text = ""
            districtPickerView.reloadAllComponents()

            districtTextField.isUserInteractionEnabled = true
        } else {
            districtTextField.text = viewModel?.districtsForSelectedProvince()[row]
        }
    }
}
