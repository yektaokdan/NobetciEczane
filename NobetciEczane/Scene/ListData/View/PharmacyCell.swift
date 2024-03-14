import UIKit

class PharmacyCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    let phoneButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none // Cell seçimi grilik oluşturmayacak
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        addressLabel.numberOfLines = 0
        
       
        phoneButton.setTitleColor(.systemBlue, for: .normal)
        phoneButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        phoneButton.contentHorizontalAlignment = .left
        phoneButton.addTarget(self, action: #selector(callPharmacy), for: .touchUpInside)
        
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(phoneButton)
        
        nameLabel.textColor = UIColor(named: "buttonColor")

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            phoneButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            phoneButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            phoneButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with pharmacy: Result) {
        nameLabel.text = pharmacy.name
        addressLabel.text = pharmacy.address
        phoneButton.setAttributedTitle(underlinePhoneNumber(phoneNumber: pharmacy.phone), for: .normal)
    }
    
    @objc func callPharmacy(sender: UIButton) {
        guard let phoneNumber = sender.attributedTitle(for: .normal)?.string.replacingOccurrences(of: " ", with: ""),
              let phoneURL = URL(string: "tel://\(phoneNumber)") else {
            return
        }
        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
    }

    private func underlinePhoneNumber(phoneNumber: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return NSAttributedString(string: phoneNumber, attributes: attributes)
    }
}
