import { Component, OnInit } from '@angular/core';
import { MDBModalRef, ToastService } from 'ng-uikit-pro-standard';
import { FormControl, FormGroup, Validators } from "@angular/forms";
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { AngularFireAuth } from '@angular/fire/auth';
import { Subject } from 'rxjs';
import { Category } from 'src/app/core/models/store/category';


@Component({
  selector: 'app-edit-category-modal',
  templateUrl: './edit-category-modal.component.html',
  styleUrls: ['./edit-category-modal.component.scss']
})
export class EditCategoryModalComponent implements OnInit {

  constructor(
    private modalRef: MDBModalRef,
    private toast: ToastService,
    private api: StoreApiService,
    public afAuth: AngularFireAuth,
  ) { }


  reactiveForm: FormGroup;
  category: Category;
  newCategory: Category;
  validatingForm: FormGroup;
  formType: string;
  uid: string;
  action: Subject<Category> = new Subject();

  closeModal() {
    this.modalRef.hide();
  }


  get editCategoryName() {
    return this.validatingForm.get('editCategoryName');
  }

  save() {
    let dateAdded;
    let addedByUID;
    let dateEdited;
    let editedByUID;
    let id;


    if (this.formType == "editCategory") {
      dateAdded = this.category.dateAdded;
      addedByUID = this.category.addedByUID;
      dateEdited = String(new Date());
      editedByUID = this.uid;
      id = this.category.id;
    }
    else {
      dateAdded = String(new Date());
      addedByUID = this.uid;
      dateEdited = null;
      editedByUID = null;
      id = null;
    }
    this.newCategory = {
      name: this.validatingForm.value.editCategoryName,
      dateAdded: dateAdded,
      addedByUID: addedByUID,
      dateEdited: dateEdited,
      editedByUID: editedByUID
    }

    if (this.formType == "editCategory") {
      this.newCategory.id = this.category.id;
      this.editCategory(this.newCategory.id, this.newCategory);
    }
    else {
      this.addCategory(this.newCategory);
    }
  }

  editCategory(id, newCategory: Category) {
    this.api.editCategory(id, newCategory).subscribe(res => {
      this.toast.success(`Category ${newCategory.name}, saved!`)
      this.action.next(newCategory);
      this.modalRef.hide()
    }, err => {
      this.toast.error(err)
      this.action.next(null);
      this.modalRef.hide()
    })
  }

  addCategory(newCategory: Category) {
    this.api.addCategory(newCategory).subscribe(res => {
      this.toast.success(`Category ${newCategory.name}, added!`)
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

  ngOnInit(): void {
    this.getUser();

    this.validatingForm = new FormGroup({
      editCategoryName: new FormControl(this.category.name, Validators.required),
    });
  }

}