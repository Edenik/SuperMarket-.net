import { Component, OnInit } from '@angular/core';
import { MDBModalRef, MDBModalService } from 'ng-uikit-pro-standard';
import { Order, OrderItem, OrderItemFull } from 'src/app/core/models/store/order';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { Product } from 'src/app/core/models/store/product';
import { UserInfoModalComponent } from 'src/app/modules/admin/components/user-info-modal/user-info-modal.component';
import { FullProductModalComponent } from 'src/app/modules/home/components/full-product-modal/full-product-modal.component';

@Component({
  selector: 'app-full-details-order-modal',
  templateUrl: './full-details-order-modal.component.html',
  styleUrls: ['./full-details-order-modal.component.scss']
})
export class FullDetailsOrderModalComponent implements OnInit {

  constructor(
    private modalRef: MDBModalRef,
    private api: StoreApiService,
    private modalService: MDBModalService,
  ) { }

  order: Order;
  orderItems: OrderItem[];
  fullOrderItems: OrderItemFull[];
  product: Product;
  modalOpen: MDBModalRef;
  products: Product[];


  getAllOrderItemsById() {
    this.orderItems = [];
    this.api.getAllOrderItemsByOrderId(this.order.id).subscribe((res: OrderItem[]) => {
      this.orderItems = res;
    }, err => {
    }, () => {
      this.fullOrderItems = [];
      this.orderItems.forEach(element => {
        this.getAllProductById(element);
      });
    })
  }

  openFullDetailsProductModal(product: Product) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        product: product,
        moderator: true
      },
    }
    this.modalOpen = this.modalService.show(FullProductModalComponent, modalOptions);
  }


  openUserInfoModal(uid) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        uid: uid
      }
    }
    this.modalOpen = this.modalService.show(UserInfoModalComponent, modalOptions)
  }

  getAllProductById(element) {
    this.products = [];
    this.api.getProductById(element.product_id).subscribe((res: Product) => {
      this.product = res;
      this.products.push(res);
      this.fullOrderItems.push({
        id: element.id,
        order_id: element.order_id,
        product_id: element.product_id,
        quantity: element.quantity,
        order_item_price: element.order_item_price,
        order_item_discount: element.order_item_discount,
        photoURL: this.product.photoURL,
        product_name: this.product.productName
      })
    })
  }


  closeModal() {
    this.modalRef.hide();
  }

  ngOnInit(): void {
    this.getAllOrderItemsById();
  }

}
