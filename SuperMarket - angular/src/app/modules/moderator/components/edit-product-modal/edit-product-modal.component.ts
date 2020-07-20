import { Component, OnInit } from '@angular/core';
import { MDBModalRef, MDBModalService, ToastService } from 'ng-uikit-pro-standard';
import { Product } from 'src/app/core/models/store/product';
import { FormControl, FormGroup, Validators } from "@angular/forms";
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { AngularFireAuth } from '@angular/fire/auth';
import { Subject } from 'rxjs';
import { Category, SubCategory } from 'src/app/core/models/store/category';

@Component({
  selector: 'app-edit-product-modal',
  templateUrl: './edit-product-modal.component.html',
  styleUrls: ['./edit-product-modal.component.scss']
})
export class EditProductModalComponent implements OnInit {

  constructor(
    private modalRef: MDBModalRef,
    private toast: ToastService,
    private api: StoreApiService,
    public afAuth: AngularFireAuth,
  ) { }


  reactiveForm: FormGroup;
  product: Product;
  newProduct: Product;
  validatingForm: FormGroup;
  photoLoaded: boolean = false;
  inSale: boolean;
  hasNutritialMark: boolean;
  formType: string;
  uid: string;
  action: Subject<Product> = new Subject();
  categories: Category[] = [];
  subcategories: SubCategory[] = [];
  AllSubcategories: SubCategory[] = [];

  closeModal() {
    this.modalRef.hide();
  }


  onChange(fieldName) {
    let value = this.validatingForm.controls[fieldName].value;

    if (fieldName == 'editInSale') {
      if (value) {
        this.inSale = true;
        this.validatingForm = new FormGroup({
          editProductPhotoURL: new FormControl(this.validatingForm.value.editProductPhotoURL, Validators.required),
          editProductName: new FormControl(this.validatingForm.value.editProductName, Validators.required),
          editProductBrand: new FormControl(this.validatingForm.value.editProductBrand, Validators.required),
          editInSale: new FormControl(true, Validators.required),
          editHasNutritialMark: new FormControl(this.validatingForm.value.editHasNutritialMark),
          editNutritialFat: new FormControl(this.validatingForm.value.editNutritialFat),
          editNutritialSodium: new FormControl(this.validatingForm.value.editNutritialSodium),
          editNutritialSugar: new FormControl(this.validatingForm.value.editNutritialSugar),
          editCategory: new FormControl(this.validatingForm.value.editCategory, Validators.required),
          editSubCategory: new FormControl(this.validatingForm.value.editSubCategory, Validators.required),
          editPrice: new FormControl(this.validatingForm.value.editPrice, Validators.required),
          editSaleDescription: new FormControl(this.validatingForm.value.editSaleDescription, Validators.required),
          editSalePrice: new FormControl(this.validatingForm.value.editSalePrice, Validators.required),
          editUnit: new FormControl(this.validatingForm.value.editUnit, Validators.required),
          editWeight: new FormControl(this.validatingForm.value.editWeight, Validators.required),
        });
      }
      else {
        this.inSale = false;
        this.validatingForm = new FormGroup({
          editProductPhotoURL: new FormControl(this.validatingForm.value.editProductPhotoURL, Validators.required),
          editProductName: new FormControl(this.validatingForm.value.editProductName, Validators.required),
          editProductBrand: new FormControl(this.validatingForm.value.editProductBrand, Validators.required),
          editInSale: new FormControl(false, Validators.required),
          editHasNutritialMark: new FormControl(this.validatingForm.value.editHasNutritialMark),
          editNutritialFat: new FormControl(this.validatingForm.value.editNutritialFat),
          editNutritialSodium: new FormControl(this.validatingForm.value.editNutritialSodium),
          editNutritialSugar: new FormControl(this.validatingForm.value.editNutritialSugar),
          editCategory: new FormControl(this.validatingForm.value.editCategory, Validators.required),
          editSubCategory: new FormControl(this.validatingForm.value.editSubCategory, Validators.required),
          editPrice: new FormControl(this.validatingForm.value.editPrice, Validators.required),
          editSaleDescription: new FormControl(this.validatingForm.value.editSaleDescription),
          editSalePrice: new FormControl(this.validatingForm.value.editSalePrice),
          editUnit: new FormControl(this.validatingForm.value.editUnit, Validators.required),
          editWeight: new FormControl(this.validatingForm.value.editWeight, Validators.required),
        });
      }
    }

    if (fieldName == 'editHasNutritialMark') {
      if (value) {
        this.hasNutritialMark = true;
      }
      else {
        this.hasNutritialMark = false;
        this.validatingForm.value.editNutritialFat = false;
        this.validatingForm.value.editNutritialSodium = false;
        this.validatingForm.value.editNutritialSugar = false;
      }
    }
  }
  get subscriptionFormModalName() {
    return this.validatingForm.get('subscriptionFormModalName');
  }

  get editCategory() {
    return this.validatingForm.get('editCategory')
  }

  get editSubCategory() {
    return this.validatingForm.get('editSubCategory')
  }

  get editPrice() {
    return this.validatingForm.get('editPrice')
  }

  get editWeight() {
    return this.validatingForm.get('editWeight')
  }

  get editSaleDescription() {
    return this.validatingForm.get('editSaleDescription')
  }

  get editSalePrice() {
    return this.validatingForm.get('editSalePrice')
  }

  get editSaleQuantity() {
    return this.validatingForm.get('editSaleQuantity')
  }

  get editUnit() {
    return this.validatingForm.get('editUnit')
  }


  get editInSale() {
    return this.validatingForm.get('editInSale')
  }


  get editProductPhotoURL() {
    return this.validatingForm.get('editProductPhotoURL');
  }

  get editProductBrand() {
    return this.validatingForm.get('editProductBrand');
  }

  get editProductName() {
    return this.validatingForm.get('editProductName');
  }

  get subscriptionFormModalEmail() {
    return this.validatingForm.get('subscriptionFormModalEmail');
  }

  photoError() {
    this.photoLoaded = false;
    this.editProductPhotoURL.setErrors({ 'incorrect': true })
  }

  photoLoad() {
    this.photoLoaded = true;
    this.toast.success("Photo loaded successfully!")
    this.editProductPhotoURL.setErrors(null)
  }

  save() {
    let dateAdded;
    let addedByUID;
    let dateEdited;
    let editedByUID;
    let id;

    if (this.hasNutritialMark && !this.validatingForm.value.editNutritialFat && !this.validatingForm.value.editNutritialSugar && !this.validatingForm.value.editNutritialSodium) {
      this.toast.error("You can't save this product without nutritial sign!");
      return
    }
    else {
      if (this.formType == "editProduct") {
        dateAdded = this.product.dateAdded;
        addedByUID = this.product.addedByUID;
        dateEdited = String(new Date());
        editedByUID = this.uid;
        id = this.product.id;
      }
      else {
        dateAdded = String(new Date());
        addedByUID = this.uid;
        dateEdited = null;
        editedByUID = null;
        id = null;
      }
      this.newProduct = {
        productName: this.validatingForm.value.editProductName,
        price: this.validatingForm.value.editPrice,
        brand: this.validatingForm.value.editProductBrand,
        unit: this.validatingForm.value.editUnit,
        weight: this.validatingForm.value.editWeight,
        inSale: this.validatingForm.value.editInSale,
        salePrice: this.validatingForm.value.editSalePrice,
        saleDescription: this.validatingForm.value.editSaleDescription,
        hasNutritialMark: this.hasNutritialMark,
        nutritialSodium: this.validatingForm.value.editNutritialSodium,
        nutritialSugar: this.validatingForm.value.editNutritialSugar,
        nutritialFat: this.validatingForm.value.editNutritialFat,
        category: this.validatingForm.value.editCategory,
        subCategory: this.validatingForm.value.editSubCategory,
        photoURL: this.validatingForm.value.editProductPhotoURL,
        dateAdded: dateAdded,
        addedByUID: addedByUID,
        dateEdited: dateEdited,
        editedByUID: editedByUID
      }

      if (this.formType == "editProduct") {
        this.newProduct.id = this.product.id;
        this.editProduct(this.newProduct.id, this.newProduct);
      }
      else {
        this.addProduct(this.newProduct);
      }
    }
  }

  editProduct(id, newProduct) {
    this.api.editProduct(id, newProduct).subscribe(res => {
      this.toast.success(`Product ${newProduct.productName}, saved!`)
      this.action.next(newProduct);
      this.modalRef.hide()
    }, err => {
      this.toast.error(err)
      this.action.next(null);
      this.modalRef.hide()
    })
  }

  addProduct(newProduct) {
    this.api.addProduct(newProduct).subscribe(res => {
      this.toast.success(`Product ${newProduct.productName}, added!`)
      this.action.next(res);
      this.modalRef.hide()
    }, err => {
      this.toast.error(err)
      this.action.next(null);
      this.modalRef.hide()
    })
  }

  getUser() {
    this.afAuth.user.subscribe((res: any) => {
      this.uid = res.uid;
    })
  }

  getAllCategories() {
    this.categories = [];
    this.api.getAllCategories().subscribe((res: Category[]) => {
      this.categories = res;
    })
  }

  getAllSubcategories() {
    this.categories = [];
    this.api.getAllSubCategories().subscribe((res: SubCategory[]) => {
      this.subcategories = res;
      this.AllSubcategories = res;
      if (this.formType == "editProduct") {
        this.subcategories = this.AllSubcategories.filter(element => element.categoryName == this.product.category);
      }
    })
  }

  changeUnit(e) {
    let unit = e.target.value;
    this.validatingForm.value.editUnit = unit;
  }

  changeCategory(e) {
    let catName = e.target.value;
    this.subcategories = this.AllSubcategories.filter(element => element.categoryName == catName);
    this.validatingForm.value.editCategory = catName;

  }

  changeSubcategory(e) {
    let subcatName = e.target.value;
    this.validatingForm.value.editSubCategory = subcatName;
  }


  ngOnInit(): void {
    this.inSale = this.product.inSale || false;
    this.hasNutritialMark = this.product.hasNutritialMark || false;
    this.getUser();
    this.getAllCategories();
    this.getAllSubcategories();

    this.validatingForm = new FormGroup({
      editProductPhotoURL: new FormControl(this.product.photoURL, Validators.required),
      editProductName: new FormControl(this.product.productName, Validators.required),
      editProductBrand: new FormControl(this.product.brand, Validators.required),
      editUnit: new FormControl(this.product.unit, Validators.required),
      editWeight: new FormControl(this.product.weight),
      editInSale: new FormControl(this.inSale),
      editHasNutritialMark: new FormControl(this.product.hasNutritialMark),
      editNutritialFat: new FormControl(this.product.nutritialFat),
      editNutritialSodium: new FormControl(this.product.nutritialSodium),
      editNutritialSugar: new FormControl(this.product.nutritialSugar),
      editCategory: new FormControl(this.product.category, Validators.required),
      editSubCategory: new FormControl(this.product.subCategory, Validators.required),
      editPrice: new FormControl(this.product.price, Validators.required),
      editSaleDescription: new FormControl(this.product.saleDescription),
      editSalePrice: new FormControl(this.product.salePrice),
    });
  }

}