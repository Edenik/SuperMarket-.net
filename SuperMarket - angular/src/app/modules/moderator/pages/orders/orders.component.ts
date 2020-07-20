import { Component, OnInit, HostListener, ViewChild, AfterViewInit, ChangeDetectorRef, ElementRef } from '@angular/core';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { Order, OrderItem } from 'src/app/core/models/store/order';
import { ConvertToCSVService } from 'src/app/core/services/convert-to-csv.service';
import { DatePipe } from '@angular/common';
import { MDBModalService, MDBModalRef, MdbTableDirective, MdbTablePaginationComponent } from 'ng-uikit-pro-standard';
import { FullDetailsOrderModalComponent } from '../../components/full-details-order-modal/full-details-order-modal.component';
import { ConfirmDeleteModalComponent } from '../../components/confirm-delete-modal/confirm-delete-modal.component';
import { EditOrderModalComponent } from '../../components/edit-order-modal/edit-order-modal.component';
import { UserInfoModalComponent } from 'src/app/modules/admin/components/user-info-modal/user-info-modal.component';
import { Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-orders',
  templateUrl: './orders.component.html',
  styleUrls: ['./orders.component.scss']
})
export class OrdersComponent implements OnInit {

  constructor(private api: StoreApiService, private csvService: ConvertToCSVService, private datePipe: DatePipe,
    private modalService: MDBModalService, private activeRoute: ActivatedRoute
  ) { }
  modalRef: MDBModalRef;


  searchUID: string;
  orders: Order[] = null;
  orderItems: OrderItem[];
  reqComplete: boolean = false;

  sort(category, direction) {
    let sortObject1;
    let sortObject2;

    let sortedArray: Order[] = this.orders.sort((obj1, obj2) => {

      switch (category) {
        case 'id':
          sortObject1 = obj1.id;
          sortObject2 = obj2.id;
          break;
        case 'name':
          sortObject1 = obj1.fullName;
          sortObject2 = obj2.fullName;
          break;
        case 'date':
          sortObject1 = Number(new Date(obj1.orderDate));
          sortObject2 = Number(new Date(obj2.orderDate));
          break;
        case 'name':
          sortObject1 = obj1.fullName;
          sortObject2 = obj2.fullName;
          break;
        case 'price':
          sortObject1 = obj1.originalOrderPrice - obj1.orderDiscount;
          sortObject2 = obj2.originalOrderPrice - obj2.orderDiscount;
          break;
        default:
          break;
      }
      if (direction == 'minus') {
        if (sortObject1 < sortObject2)
          return 1;
        if (sortObject1 > sortObject2)
          return -1;
        return 0;
      }
      else {
        if (sortObject1 > sortObject2)
          return 1;
        if (sortObject1 < sortObject2)
          return -1;
        return 0;
      }

    });
    this.orders = sortedArray;
  }

  getAllOrders() {
    this.orders = [];
    this.api.getAllOrders().subscribe((res: Order[]) => {
      this.orders = res;
      this.sort('id', 'minus');
      this.reqComplete = true;
    })
  }

  downloadOrdersData() {
    let date = this.datePipe.transform(new Date(), 'dd.MM.yy HH.mm');
    this.csvService.downloadFile(this.orders, `Orders- ${date}`, 'orders');
  }


  ngOnInit() {
    this.activeRoute.params.subscribe(params => {
      this.searchUID = params.uid
    })
    this.getAllOrders();
  }

}