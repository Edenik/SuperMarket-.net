import { Component, OnInit } from '@angular/core';
import { MDBModalRef, ToastService } from 'ng-uikit-pro-standard';
import { FormControl, FormGroup, Validators } from "@angular/forms";
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { AngularFireAuth } from '@angular/fire/auth';
import { Subject } from 'rxjs';
import { Category, SubCategory } from 'src/app/core/models/store/category';

@Component({
  selector: 'app-edit-subcategory-modal',
  templateUrl: './edit-subcategory-modal.component.html',
  styleUrls: ['./edit-subcategory-modal.component.scss']
})
export class EditSubcategoryModalComponent implements OnInit {

  constructor(
    private modalRef: MDBModalRef,
    private toast: ToastService,
    private api: StoreApiService,
    public afAuth: AngularFireAuth,
  ) { }




  reactiveForm: FormGroup;
  subcategory: SubCategory;
  newSubcategory: SubCategory;
  validatingForm: FormGroup;
  formType: string;
  uid: string;
  action: Subject<SubCategory> = new Subject();
  categories: Category[];
  categoryID: number = 0;
  categoryName: string;

  closeModal() {
    this.modalRef.hide();
  }


  get editSubcategoryName() {
    return this.validatingForm.get('editSubcategoryName');
  }

  get editSelectCategory() {
    return this.validatingForm.get('editSelectCategory');
  }

  changeCategory(e) {
    let catName = e.target.value;
    this.validatingForm.value.editSelectCategory = catName;
    this.categoryName = catName;
    let category: Category[] = this.categories.filter(category => category.name == this.validatingForm.value.editSelectCategory)
    this.setCategory(category[0]);
  }

  setCategory(category: Category) {
    this.categoryID = category.id;
    this.categoryName = category.name;
  }

  save() {
    let dateAdded;
    let addedByUID;
    let dateEdited;
    let editedByUID;
    let id;

    if (this.formType == "editSubcategory") {
      dateAdded = this.subcategory.dateAdded;
      addedByUID = this.subcategory.addedByUID;
      dateEdited = String(new Date());
      editedByUID = this.uid;
      id = this.subcategory.id;
    }
    else {
      dateAdded = String(new Date());
      addedByUID = this.uid;
      dateEdited = null;
      editedByUID = null;
      id = null;
    }
    this.newSubcategory = {
      name: this.validatingForm.value.editSubcategoryName,
      dateAdded: dateAdded,
      addedByUID: addedByUID,
      dateEdited: dateEdited,
      editedByUID: editedByUID,
      categoryID: this.categoryID,
      categoryName: this.categoryName
    }
    if (this.formType == "editSubcategory") {
      this.newSubcategory.id = this.subcategory.id;
      this.editSubcategory(this.newSubcategory.id, this.newSubcategory);
    }
    else {
      this.addSubcategory(this.newSubcategory);
    }
  }

  editSubcategory(id, newSubcategory: SubCategory) {
    this.api.editSubCategory(id, newSubcategory).subscribe(res => {
      this.toast.success(`Category ${newSubcategory.name}, saved!`)
      this.action.next(newSubcategory);
      this.modalRef.hide()
    }, err => {
      this.toast.error(err)
      this.action.next(null);
      this.modalRef.hide()
    })
  }



  addSubcategory(newSubcategory: SubCategory) {
    this.api.addSubCategory(newSubcategory).subscribe(res => {
      this.toast.success(`Category ${newSubcategory.name}, added!`)
      this.action.next(newSubcategory);
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



  ngOnInit(): void {
    this.getUser();
    this.validatingForm = new FormGroup({
      editSubcategoryName: new FormControl(this.subcategory.name, Validators.required),
      editSelectCategory: new FormControl(this.subcategory.categoryName, Validators.required)
    });

    if (this.formType == "editSubcategory") {
      this.categoryName = this.subcategory.categoryName;
      this.validatingForm.value.editSubcategoryName = this.categoryName;
    }
    else {
      this.categoryName == null;
    }

  }

}