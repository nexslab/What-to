//
//  AddLocationViewController.swift
//  WhatTo
//
//  Created by macmini on 09/06/17.
//  Copyright © 2017 qw. All rights reserved.
//

import UIKit
import CZPicker


class AddLocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, CZPickerViewDelegate, CZPickerViewDataSource {

    //MARK:-  Class Reference
    var czPickerView: CZPickerView?

    //MARK:-  IBOutlets
    @IBOutlet weak var tbl: UITableView!

    @IBOutlet weak var subviewHeader: UIView!
    @IBOutlet weak var subview_currentLocation: UIView!
    @IBOutlet weak var lblcircleDot: UILabel!
    @IBOutlet weak var txtCurrentLocation: UITextField!
    @IBOutlet weak var subview_WhereTo: UIView!
    @IBOutlet weak var txtWhereTo: UITextField!
    @IBOutlet weak var txtFromTo: UITextField!
    
    
    var arrLocation: NSMutableArray!
    var arrFromvalues: NSMutableArray!

    //MARK:- viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setInitParam();
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tbl.reloadData()
        super.viewWillAppear(animated) // No need for semicolon
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setInitParam() {

        Constants.shaodow(on: subviewHeader)
        Constants.setBorderTo(subview_currentLocation, withBorderWidth: 0, radiousView: 2, color: UIColor.clear)
        Constants.setBorderTo(subview_WhereTo, withBorderWidth: 0, radiousView: 2, color: UIColor.clear)
        
        Constants.setBorderTo(lblcircleDot, withBorderWidth: 0, radiousView: Float(lblcircleDot.frame.size.height/2), color: UIColor.clear)
        
        
        let dictHome:[String:String] = ["title":"Add Home", "icon":"home.png"]
        let dictWork:[String:String] = ["title":"Add Work", "icon":"briefcase.png"]
        let dictPinLocation:[String:String] = ["title":"Set pin location", "icon":"pinLocation.png"]
        let dictSkipDestination:[String:String] = ["title":"Skip destination", "icon":"forword.png"]

        arrLocation = [dictHome,dictWork, dictPinLocation, dictSkipDestination]
        tbl.reloadData()
        tbl.tableFooterView = UIView()

        arrFromvalues = ["Meet the girlfriend","Hangout with friends","Traveling","Restaurant","Shopping"]

        txtWhereTo.becomeFirstResponder()
    }
    
    //MARK:-  IBActions
    @IBAction func back(_ sender: Any) {
        self.navigationController?.pop(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - From Details


    @IBAction func fromTapped(_ sender: Any) {
        
        txtWhereTo.resignFirstResponder()
        self.OpenPickerViewForFromDetails()
    }
    func OpenPickerViewForFromDetails()  {
        czPickerView = CZPickerView(headerTitle: "What To", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        czPickerView?.delegate = self
        czPickerView?.dataSource = self
        czPickerView?.headerBackgroundColor = UIColor(colorLiteralRed: 89/255.0, green: 157/255.0, blue: 194/255.0, alpha: 1)
        czPickerView?.needFooterView = false
        czPickerView?.tag = 101
        czPickerView?.show()
        
    }
    
    //Delegate Methods
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        
        if pickerView.tag == 101 {
            return arrFromvalues.count
        }else{
            return 0;
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        
        if pickerView.tag == 101 {
            return arrFromvalues[row] as! String
        }else{
            return "";
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        if pickerView.tag == 101 {
            
            txtFromTo.text = arrFromvalues[row] as? String
            
        }else{
            
        }
    }

    // MARK: - Tableview Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLocation.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdentifier: String = "cell \(Int(indexPath.row))"
        var cell: Cell_setLocation? = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as? Cell_setLocation)
        
        if cell == nil {
            let topLevelObjects: [Any] = Bundle.main.loadNibNamed("Cell_setLocation", owner: nil, options: nil)!
            cell = (topLevelObjects[0] as? Cell_setLocation)
            cell?.backgroundColor = UIColor.clear
            cell?.selectionStyle = .none
        }
        
        let dictCell = arrLocation.object(at: indexPath.row) as! NSDictionary

        if indexPath.row == 0
        {
            if Constants.app_delegate.HomeDict == nil
            {
                cell?.lblTitle.text = dictCell.value(forKey: "title") as? String
                
                cell?.subview_Double.isHidden = true
                cell?.subview_single.isHidden = false
            }
            else
            {
                cell?.subview_Double.isHidden = false
                cell?.subview_single.isHidden = true
                
                cell?.lblPlaceTitle.text = "Home"
                //cell?.lblPlaceTitle.text = Constants.app_delegate.HomeDict.value(forKey: "place_name") as? String
                cell?.lblPlaceAddress.text = Constants.app_delegate.HomeDict.value(forKey: "place_address") as? String
            }
            cell?.imgIcon.image = UIImage(named: dictCell.value(forKey: "icon") as! String)
        }
        else if indexPath.row == 1
        {
            if Constants.app_delegate.WorkDict == nil
            {
                cell?.lblTitle.text = dictCell.value(forKey: "title") as? String
                
                cell?.subview_Double.isHidden = true
                cell?.subview_single.isHidden = false
            }
            else
            {
                cell?.subview_Double.isHidden = false
                cell?.subview_single.isHidden = true
                
                cell?.lblPlaceTitle.text = "Work"
                //cell?.lblPlaceTitle.text = Constants.app_delegate.WorkDict.value(forKey: "place_name") as? String
                cell?.lblPlaceAddress.text = Constants.app_delegate.WorkDict.value(forKey: "place_address") as? String
            }
            cell?.imgIcon.image = UIImage(named: dictCell.value(forKey: "icon") as! String)
        }
        else
        {
            cell?.imgIcon.image = UIImage(named: dictCell.value(forKey: "icon") as! String)
            cell?.lblTitle.text = dictCell.value(forKey: "title") as? String
        }
        
        /*
        cell?.imgIcon.image = UIImage(named: dictCell.value(forKey: "icon") as! String)
        cell?.lblTitle.text = dictCell.value(forKey: "title") as? String
         */
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //let dictCell = arrLocation.object(at: indexPath.row) as! NSDictionary

        if indexPath.row == 0
        {
            let move: SearchAddressViewController = storyboard?.instantiateViewController(withIdentifier: "SearchAddressViewController") as! SearchAddressViewController
            move.isFromHome = true
            navigationController?.pushViewController(move, animated: true)
        }
        else if indexPath.row == 1
        {
            let move: SearchAddressViewController = storyboard?.instantiateViewController(withIdentifier: "SearchAddressViewController") as! SearchAddressViewController
            move.isFromHome = false
            navigationController?.pushViewController(move, animated: true)
        }
        else if indexPath.row == 2
        {
            let move: PinLocationViewController = storyboard?.instantiateViewController(withIdentifier: "PinLocationViewController") as! PinLocationViewController
            move.FromVC_NAME = "AddLocation"
            navigationController?.pushViewController(move, animated: true)
        }
    }

    
}