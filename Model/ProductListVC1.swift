//
//  ProductListVC1.swift
//  Theme3Template
//
//  Created by vibha on 13/06/18.
//  Copyright © 2018 vibha. All rights reserved.
//

import UIKit

class ProductListVC1: UIViewController {
    
    @IBOutlet var lblNoData: UILabel!
    @IBOutlet weak var tblProductList: UITableView!
    @IBOutlet weak var collectionProductList: UICollectionView!
    
    var paramDic = Dictionary<String, AnyObject>()
    
    var arrdicProduct : [[String:AnyObject]] = []
    var arrdataProduct = [DataProductListModel]()
    var flagWishlist = Bool()
    var strCategoryID = Int()
    var strCategoryName = String()
    // MARK: - Default Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigation()
        wsProductList()
    }
    
    //MARK: - Initialization
    
    func initialization(){
        collectionProductList?.register(UINib(nibName: "ProductListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        
        tblProductList.tableFooterView = UIView()
        tblProductList.rowHeight = UITableViewAutomaticDimension
        tblProductList.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    //MARK: - Navigation Method
    
    func setNavigation() {
        
        if isSideMenu {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            navigationController?.isNavigationBarHidden = false
            title = Constants.navigationBarTitle.kProductList
            
            if isFirstEnter == true{
                navButtonWithImg(#imageLiteral(resourceName: "menu"), selector: #selector(btnMenu), isLeft: true)
            }else{
                navButtonWithImg(#imageLiteral(resourceName: "Back"), selector: #selector(btnBack), isLeft: true)
            }
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.defaultTheme()
            
            sideMenuController?.isLeftViewEnabled = true
            
            setUpCartGrid()
        } else {
            setTabBarControllerNavigationBar(strTitleName: Constants.navigationBarTitle.kProductList)
            btnTabBarNavigationBackAction()
            let btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(btnSearchAction))
            let btnBarCart =  setUpCart()
            let btnGrid = UIBarButtonItem(image: #imageLiteral(resourceName: "box"), style: .plain, target: self, action: #selector(self.btnGridAct))
            self.tabBarController?.navigationItem.rightBarButtonItems = [btnGrid, btnBarCart, btnSearch]
        }
    }
    
    func setUpCartGrid() {
        
        let btnCart = UIButton.init(type: .custom)
        btnCart.setImage(#imageLiteral(resourceName: "shop"), for: .normal)
        let lblCartCount = UILabel(frame: CGRect(x: btnCart.frame.origin.x + 17, y: btnCart.frame.origin.y - 4, width: 16, height: 16))
        lblCartCount.text = String(cartItemCount)
        lblCartCount.textColor = UIColor.white
        lblCartCount.backgroundColor = UIColor.defaultTheme()
        lblCartCount.font = UIFont (name: "Lato-Regular", size: 8)
        lblCartCount.cornerRadius = 8
        lblCartCount.clipsToBounds = true
        lblCartCount.textAlignment = .center
        btnCart.addSubview(lblCartCount)
        if cartItemCount == 0{
            lblCartCount.isHidden = true
        }
        else{
            lblCartCount.isHidden = false
        }
        btnCart.addTarget(self, action: #selector(openCart), for: .touchUpInside)
        let btnBarCart = UIBarButtonItem.init(customView: btnCart)
        let btnSearch = UIBarButtonItem(image: #imageLiteral(resourceName: "search"), style: .plain, target: self, action: #selector(btnSearchAction))
        let btnGrid = UIBarButtonItem(image: #imageLiteral(resourceName: "box"), style: .plain, target: self, action: #selector(self.btnGridAct))
        
        self.navigationItem.rightBarButtonItems = [btnGrid,btnBarCart,btnSearch]
        
    }
    
    // MARK: - UIButton Actions
    @objc func btnMenu(){
        
        switch intSetMenu {
            
        case 1:
            //            sideMenuController?.isLeftViewEnabled = true
            //            sideMenuController?.showLeftView(animated:true, completionHandler: {
            //
            //            })
            openDefaultMenu()
            break
            
        case 2, 3, 4, 5, 6, 7:
            openMenu()
            break
            
        default:
            break
            
        }
        
    }
    
    @objc func btnBack(){
        if isSideMenu {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        } else {
            self.tabBarController?.navigationController?.popViewController()
        }
    }
    
    @objc func btnCartAction() {
        let controller = Constants.GlobalConstants.AddToCartStoryboard.instantiateViewController(withIdentifier: Constants.StoryBoardID.kAddToCartVC1ID)
        pushVC(controller)
        
    }
    
    @objc func btnSearchAction(){
        
        let controller = Constants.GlobalConstants.SearchStoryboard.instantiateViewController(withIdentifier:  Constants.StoryBoardID.kSearchVC1ID)
//        if isSideMenu {
//            self.navigationController?.pushViewController(controller, animated: true)
//        } else {
//            self.tabBarController?.navigationController?.pushViewController(controller, animated: true)
//        }
self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func btnGridAct(_ sender : UIBarButtonItem){
        if arrdataProduct.count != 0{
        
        if !collectionProductList.isHidden{
            collectionProductList.isHidden = true
            tblProductList.isHidden = false
        }else{
            collectionProductList.isHidden = false
            tblProductList.isHidden = true
        }
        }else{
            lblNoData.isHidden = false
            collectionProductList.isHidden = true
        }
        
    }
    
    @objc func btnLikeClickedList(sender:UIButton) {
        
        if isKeyPresentInUserDefaults(key: Constants.UserDefault.kUserID) {
            let isSelected = arrdataProduct[sender.tag].wishlist
            if (isSelected!)
            {
                wsWishListAddRemove(flag:"remove", pID: arrdataProduct[sender.tag].prod_id!)
            }
            else
            {
                wsWishListAddRemove(flag:"add", pID: arrdataProduct[sender.tag].prod_id!)
            }
        } else {
            let controller = Constants.GlobalConstants.LoginStoryboard.instantiateViewController(withIdentifier: Constants.StoryBoardID.kLoginVC1ID)
            let navController = UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle = .overFullScreen
            if isSideMenu {
                self.navigationController?.present(navController, animated: false, completion: nil)
            } else {
                self.tabBarController?.navigationController?.present(navController, animated: false, completion: nil)
            }
        }
    }
    
    //MARK: - Webservice Category
    
    func wsWishListAddRemove(flag:String,pID : Int){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(Constants.AlertMessage.NetworkConnection as String)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        
        if isKeyPresentInUserDefaults(key: Constants.UserDefault.kUserID){
            paramDic [Constants.WebServiceParameter.pUserID] = getUserDefault(Constants.UserDefault.kUserID)
        }
        paramDic [Constants.WebServiceParameter.pAPIKEY] = Constants.WebServiceURL.API_KEY as AnyObject
        paramDic [Constants.WebServiceParameter.pProdID] = pID as AnyObject
        paramDic [Constants.WebServiceParameter.pFlag] = flag as AnyObject
        paramDic [Constants.WebServiceParameter.pQty] = "1" as AnyObject
        ApiCall().post(apiUrl: Constants.WebServiceURL.AddRemoveWishlistURL, requestPARAMS: paramDic, model: WishListAddRemoveModel.self) { (success, responseData) in
            if let responseData = responseData as? WishListAddRemoveModel {
                print(responseData)
                self.wsProductList()
                
                
            }
        }
        
    }
    
    func wsProductList(){
        guard case ConnectionCheck.isConnectedToNetwork() = true else {
            self.view.makeToast(Constants.AlertMessage.NetworkConnection as String)
            return
        }
        var paramDic = Dictionary<String, AnyObject>()
        if isKeyPresentInUserDefaults(key: Constants.UserDefault.kUserID){
            paramDic [Constants.WebServiceParameter.pUserID] = getUserDefault(Constants.UserDefault.kUserID)
        }
        paramDic [Constants.WebServiceParameter.pAPIKEY] = Constants.WebServiceURL.API_KEY as AnyObject
        paramDic [Constants.WebServiceParameter.pCatId] = strCategoryID as AnyObject
        ApiCall().post(apiUrl: Constants.WebServiceURL.ProductListURL, requestPARAMS: paramDic, model: ProductListModelClass.self, isLoader: true, isErrorToast: true, completion: { (success, responseData) in
            
            if success , let responseData = responseData as? ProductListModelClass {
                print(responseData)
                print(responseData.message as Any)
                
                self.arrdataProduct = responseData.data!
                if self.arrdataProduct.count != 0{
                    //self.tblProductList.delegate = self
                    //self.tblProductList.dataSource = self
                    self.tblProductList.reloadData()
                    //self.collectionProductList.delegate = self
                   // self.collectionProductList.dataSource = self
                    self.collectionProductList.reloadData()
                }else{
                    
                    self.lblNoData.isHidden = false
                    self.tblProductList.isHidden = true
                    self.collectionProductList.isHidden = true
                }
                
            }else{
               // mainThread {
                self.lblNoData.isHidden = false
                self.tblProductList.isHidden = true
                self.collectionProductList.isHidden = true
               // }
            }
        })
        
    }
}

extension ProductListVC1 : UITableViewDelegate,UITableViewDataSource
{
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrdataProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell :ProductListTblCell = tableView.dequeueReusableCell(withIdentifier:"cell") as! ProductListTblCell
        cell.lblCategory.text = strCategoryName
        cell.lblProductName.text = arrdataProduct[indexPath.row].name
        cell.lblPrice.text = "$\(Double(arrdataProduct[indexPath.row].price!))"
        cell.imgProduct.kf.setImage(with: URL(string: arrdataProduct[indexPath.row].image_url ?? ""))
        
        switch arrdataProduct[indexPath.row].wishlist {
        case true?:
            cell.btnLikeOut.setImage(#imageLiteral(resourceName: "fav-selected"), for: .selected)
            cell.btnLikeOut.isSelected = true
        default:
            cell.btnLikeOut.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
            cell.btnLikeOut.isSelected = false
        }
        
        cell.btnLikeOut.tag = indexPath.row
        cell.btnLikeOut.addTarget(self, action: #selector(btnLikeClickedList), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = Constants.GlobalConstants.ProductDetailStoryboard.instantiateViewController(withIdentifier: Constants.StoryBoardID.kProductDetailVC1ID) as? ProductDetailVC1
        controller?.intProductID = arrdataProduct[indexPath.row].prod_id!
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ProductListVC1 : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrdataProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath) as! ProductListCollectionCell
        
        cell.lblProductName.text = arrdataProduct[indexPath.row].name
        cell.lblProductPrice.text = "\("$")" + "\(String(describing: arrdataProduct[indexPath.row].price!))"
        // cell.lblCategory.text = productListModel.strCategory
        let url = URL(string: arrdataProduct[indexPath.row].image_url!)
        cell.imgProduct.kf.setImage(with: url!)
        flagWishlist = arrdataProduct[indexPath.row].wishlist!
        if(flagWishlist == true) {
            cell.btnLike.setImage(#imageLiteral(resourceName: "fav-selected"), for: .normal)
        } else {
            cell.btnLike.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
        }
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(self.btnLikeClickedList), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = Constants.GlobalConstants.ProductDetailStoryboard.instantiateViewController(withIdentifier: Constants.StoryBoardID.kProductDetailVC1ID) as? ProductDetailVC1
        controller?.intProductID = arrdataProduct[indexPath.row].prod_id!
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return CGSize(width: CGFloat(collectionProductList.frame.size.width/2), height:CGFloat(collectionProductList.frame.size.width/2))
    //    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            
            let size = CGSize(width: (self.view.frame.size.width/2) - 3 , height: 600)
            return size
        }
        else{
            let size = CGSize(width: (self.view.frame.size.width/2) - 3 , height: 300)
            return size
        }
    }
}


