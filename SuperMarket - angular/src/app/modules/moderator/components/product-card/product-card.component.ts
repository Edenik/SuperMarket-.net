import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { Product } from 'src/app/core/models/store/product';
import { MDBModalService, MDBModalRef } from 'ng-uikit-pro-standard';
import { ConfirmDeleteModalComponent } from '../confirm-delete-modal/confirm-delete-modal.component';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { EditProductModalComponent } from '../edit-product-modal/edit-product-modal.component';
import { FullProductModalComponent } from 'src/app/modules/home/components/full-product-modal/full-product-modal.component';

@Component({
  selector: 'app-product-card',
  templateUrl: './product-card.component.html',
  styleUrls: ['./product-card.component.scss']
})
export class ProductCardComponent implements OnInit {

  constructor(
    private modalService: MDBModalService,
    private api: StoreApiService,
  ) { }
  @Input() product: Product;
  modalRef: MDBModalRef;
  @Output() delete = new EventEmitter<number>();


  deleteProduct(id) {

    let modalOptions = {
      class: 'modal-dialog modal-sm modal-notify modal-danger',
    }
    this.modalRef = this.modalService.show(ConfirmDeleteModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: boolean) => {
      if (result) {
        this.api.deleteProduct(id).subscribe(res => {
          this.delete.emit(this.product.id)
        })
      }
    });
  }

  openEditProductModal(product: Product) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-warning',
      data: {
        product: product,
        formType: 'editProduct'
      },
      ignoreBackdropClick: true
    }
    this.modalRef = this.modalService.show(EditProductModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: Product) => {
      this.product = result;
    });
  }



  openFullDetailsProductModal(product: Product) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        product: product,
        moderator: true
      },
    }
    this.modalRef = this.modalService.show(FullProductModalComponent, modalOptions);
  }

  ngOnInit(): void {
  }

}