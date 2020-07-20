import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Category, SubCategory } from 'src/app/core/models/store/category';
import { MDBModalRef, MDBModalService } from 'ng-uikit-pro-standard';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { ConfirmDeleteModalComponent } from '../confirm-delete-modal/confirm-delete-modal.component';
import { EditCategoryModalComponent } from '../edit-category-modal/edit-category-modal.component';
import { FullDetailsCategoryModalComponent } from '../full-details-category-modal/full-details-category-modal.component';

@Component({
  selector: 'app-category-card',
  templateUrl: './category-card.component.html',
  styleUrls: ['./category-card.component.scss']
})
export class CategoryCardComponent implements OnInit {

  constructor(
    private modalService: MDBModalService,
    private api: StoreApiService,
  ) { }

  @Input() category: Category;
  @Output() delete = new EventEmitter<number>();
  modalRef: MDBModalRef;
  subcategories: SubCategory[] = [];
  categories: Category[] = [];
  
  deleteCategory(id) {
    let modalOptions = {
      class: 'modal-dialog modal-sm modal-notify modal-danger',
    }
    this.modalRef = this.modalService.show(ConfirmDeleteModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: boolean) => {
      if (result) {
        this.api.deleteCategory(id).subscribe(res => {
          this.delete.emit(this.category.id)
        })
      }
    });
  }

  openEditCategoryModal(category: Category) {
    let modalOptions = {
      class: 'modal-dialog modal-notify modal-warning',
      data: {
        category: category,
        formType: 'editCategory'
      },
      ignoreBackdropClick: true
    }
    this.modalRef = this.modalService.show(EditCategoryModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: Category) => {
      this.category = result;
    });
  }

  openFullDetailsCategoryModal(category: Category) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        category: category,
      },
    }
    this.modalRef = this.modalService.show(FullDetailsCategoryModalComponent, modalOptions);
  }

  ngOnInit(): void {
  }

}
