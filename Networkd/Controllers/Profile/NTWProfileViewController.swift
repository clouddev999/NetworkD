//
//  NTWProfileViewController.swift
//  Networkd
//
//  Created by CloudStream on 5/4/17.
//  Copyright © 2017 CloudStream LLC. All rights reserved.
//

import UIKit
import ImagePicker
import RSKImageCropper

class NTWProfileViewController: UIViewController {

    
    // MARK: - Properties
    
    var user = NTWUser()
    let imagePickerController = ImagePickerController()

    
    // MARK: - IBOutlets

    @IBOutlet weak var profileTableView: UITableView!
    
    
    // MARK: - UIViewController Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileTableView.rowHeight = UITableViewAutomaticDimension
        self.profileTableView.estimatedRowHeight = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSearchView" {
            let navigationController = segue.destination as! UINavigationController
            let searchViewController = navigationController.topViewController as! NTWSearchViewController
            let indexPath = self.profileTableView.indexPath(for: sender as! UITableViewCell)!
            if indexPath.section == 3 {
                searchViewController.searchType = .interests
            } else {
                searchViewController.searchType = .skills
            }
        }
    }
}


extension NTWProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 9
        case 1:
            return 2
        case 2:
            return 2
        case 3:
            return 2
        case 4:
            return 2
        case 5:
            return 1
        case 6:
            return 1
        default:
            return 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "profilePictureCell", for: indexPath) as! NTWProfilePictureTableViewCell
                cell.profilePictureImageView.image = self.user.profilePicture
                cell.delegate = self
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! NTWTitleTableViewCell
                cell.titleLabel.text = "Basic Info"
                cell.subtitleLabel.text = "We use this information to show you better matches"
                cell.addButton.isHidden = true
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
                cell.inputTextField.placeHolderText = "First Name"
                cell.inputTextField.type = .standard
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
                cell.inputTextField.placeHolderText = "Last Name"
                cell.inputTextField.type = .standard
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
                cell.inputTextField.placeHolderText = ""
                cell.inputTextField.type = .standard
                cell.characterLimit = 80
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! NTWTitleTableViewCell
                cell.titleLabel.text = nil
                cell.subtitleLabel.text = "This will help us connect you people with similar interests"
                cell.addButton.isHidden = true
                return cell
            case 6:
                let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! NTWSwitchTableViewCell
                cell.titleLabel.text = "For Hire"
                return cell
            case 7:
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
                cell.inputTextField.placeHolderText = "Industry"
                cell.inputTextField.type = .standard
                return cell
            case 8:
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputCell", for: indexPath) as! NTWInputTableViewCell
                cell.inputTextField.placeHolderText = "Location"
                cell.inputTextField.type = .standard
                return cell
            default:
                let cell = UITableViewCell()
                return cell
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! NTWTitleTableViewCell
                cell.titleLabel.text = "Experience"
                cell.subtitleLabel.text = "1 position on your profile"
                cell.addButton.isHidden = false
                cell.delegate = self
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! NTWExperienceTableViewCell
                cell.companyLogo.image = UIImage(named: "dell.jpg")
                cell.positionLabel.text = "Leader Team"
                cell.companyLabel.text = "Dell"
                cell.dateLabel.text = "Apr 2017 - Present ~ 1 mo"
                return cell
            default:
                let cell = UITableViewCell()
                return cell
            }
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! NTWTitleTableViewCell
                cell.titleLabel.text = "Education"
                cell.subtitleLabel.text = "1 school on your profile"
                cell.addButton.isHidden = false
                cell.delegate = self
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "experienceCell", for: indexPath) as! NTWExperienceTableViewCell
                cell.companyLogo.image = UIImage(named: "uninorte.png")
                cell.positionLabel.text = "Uninorte"
                cell.companyLabel.text = "Electronic Engineer"
                cell.dateLabel.text = "May 2010 - May 2016"
                return cell
            default:
                let cell = UITableViewCell()
                return cell
            }
        case 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! NTWTitleTableViewCell
                cell.titleLabel.text = "Your Interests"
                cell.subtitleLabel.text = "7 interests on your profile"
                cell.addButton.isHidden = false
                cell.delegate = self
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell", for: indexPath) as! NTWTagsTableViewCell
                cell.showTags(["Friendship", "Bussiness", "Sports", "Software Development", "iOS", "Electronic Engineer"])
                cell.layoutIfNeeded()
                return cell
            default:
                let cell = UITableViewCell()
                return cell
            }
        case 4:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! NTWTitleTableViewCell
                cell.titleLabel.text = "Your Skills"
                cell.subtitleLabel.text = "3 interests on your profile"
                cell.addButton.isHidden = false
                cell.delegate = self
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell", for: indexPath) as! NTWTagsTableViewCell
                cell.showTags(["Hardworking", "Motivated", "Entrepeneurship"])
                cell.layoutIfNeeded()
                return cell
            default:
                let cell = UITableViewCell()
                return cell
            }
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! NTWButtonTableViewCell
            cell.delegate = self
            cell.button.backgroundColor = .NTWBlue
            cell.button.setTitle("Sign Out", for: .normal)
            cell.button.setTitleColor(.white, for: .normal)
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 5 {
            return 0.01
        }
        return 15
    }
}


extension NTWProfileViewController: NTWProfilePictureCellDelegate {
    
    func cell(_ cell: UITableViewCell, editProfilePicture existImage: Bool) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeAction = UIAlertAction(title: "Remove Image", style: .destructive) { UIAlertAction in
            self.removePhoto()
        }
        
        let galleryAction = UIAlertAction(title: existImage ? "Update Image" : "Add Image", style: .default) { UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in }
        
        alert.addAction(galleryAction)
        if existImage  {
            alert.addAction(removeAction)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func removePhoto() {
        self.user.profilePicture = nil
        self.profileTableView.reloadData()
    }
    
    func openGallery() {
        self.imagePickerController.delegate = self
        self.imagePickerController.imageLimit = 1
        self.present(imagePickerController, animated: true, completion: nil)
    }
}

extension NTWProfileViewController: ImagePickerDelegate {
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {}
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.imagePickerController.delegate = nil
        self.imagePickerController.dismiss(animated: true) { 
            self.cropImage(images.first!)
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        self.imagePickerController.delegate = nil
    }
}

extension NTWProfileViewController: RSKImageCropViewControllerDelegate {
    
    func cropImage(_ image: UIImage) {
        let imageCropper = RSKImageCropViewController(image: image)
        imageCropper.delegate = self
        self.present(imageCropper, animated: true, completion: nil)
    }
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        let scaledImage = croppedImage.scaleTo(width: 255)
        self.user.profilePicture = scaledImage
        self.profileTableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
}


extension NTWProfileViewController: NTWButtonCellDelegate {
    
    func didTapButton(atCell cell: UITableViewCell) {
        let alert = UIAlertController(title: "Do you really want to sign out?", message: nil, preferredStyle: .actionSheet)
        
        let signOutAction = UIAlertAction(title: "Yes", style: .destructive) { UIAlertAction in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "signInViewController")
            (self.tabBarController?.parent as! UINavigationController).setViewControllers([controller], animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { UIAlertAction in }
        
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}


extension NTWProfileViewController: NTWTitleCellDelegate {
    
    func didTapAddButton(atCell cell: UITableViewCell) {
        let indexPath = self.profileTableView.indexPath(for: cell)!
        
        switch indexPath.section {
        case 1:
            self.performSegue(withIdentifier: "toAddWorkExperienceView", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "toAddEducationView", sender: nil)
        case 3, 4:
            self.performSegue(withIdentifier: "toSearchView", sender: cell)
        default:
            break
        }
    }
}

extension NTWProfileViewController: NTWInputCellDelegate {
    
    func input(atCell cell: UITableViewCell, didChangeWithText text: String) {
        
        if let indexPath = self.profileTableView.indexPath(for: cell) {
            switch indexPath.section {
            case 0:
                break
            case 1:
                break
            case 2:
                break
            case 3:
                break
            default:
                break
            }
        }
    }
}

