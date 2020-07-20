import { Component, OnInit, AfterViewInit, ChangeDetectorRef, ElementRef, ViewChild, HostListener, Input } from '@angular/core';
import { MdbTableDirective, MdbTablePaginationComponent, MDBModalService , MDBModalRef} from 'ng-uikit-pro-standard';
import { Order, OrderItem } from 'src/app/core/models/store/order';
import { FullDetailsOrderModalComponent } from '../full-details-order-modal/full-details-order-modal.component';
import { EditOrderModalComponent } from '../edit-order-modal/edit-order-modal.component';
import { ConfirmDeleteModalComponent } from '../confirm-delete-modal/confirm-delete-modal.component';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { UserInfoModalComponent } from 'src/app/modules/admin/components/user-info-modal/user-info-modal.component';

@Component({
  selector: 'app-orders-table',
  templateUrl: './orders-table.component.html',
  styleUrls: ['./orders-table.component.scss']
})
export class OrdersTableComponent implements OnInit, AfterViewInit {

  constructor(
    private cdRef: ChangeDetectorRef,
    private modalService: MDBModalService,
    private api: StoreApiService
  ) { }

  @ViewChild(MdbTableDirective, { static: true }) mdbTable: MdbTableDirective;
  @ViewChild(MdbTablePaginationComponent, { static: true }) mdbTablePagination: MdbTablePaginationComponent;
  @ViewChild('row', { static: true }) row: ElementRef;

  headElements = ['id', 'name', 'uid', 'date', 'price', 'status', 'actions'];
  searchText: string = '';
  previous: string;
  modalRef: MDBModalRef;
  @Input() orders: Order[];
  orderItems: OrderItem[];
  @Input() searchUID: string;

  maxVisibleItems: number = 5;

  @HostListener('input') oninput() {
    this.mdbTablePagination.searchText = this.searchText;
  }


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
        case 'uid':
          sortObject1 = obj1.uid;
          sortObject2 = obj2.uid;
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


  openFullDetailsOrderModal(order: Order) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        order: order,
      },
    }
    this.modalRef = this.modalService.show(FullDetailsOrderModalComponent, modalOptions);
  }

  openEditOrderStatusModal(order: Order) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-warning',
      data: {
        order: order,
      },
      ignoreBackdropClick: true
    }
    this.modalRef = this.modalService.show(EditOrderModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: Order) => {
      this.orders = this.orders.filter(ele => ele.id != result.id)
      this.orders.push(result)
      this.sort('id', 'minus');
    });
  }

  openUserInfoModal(uid) {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        uid: uid
      }
    }
    this.modalRef = this.modalService.show(UserInfoModalComponent, modalOptions)
  }

  deleteOrder(id) {
    let modalOptions = {
      class: 'modal-dialog modal-sm modal-notify modal-danger',
    }
    this.modalRef = this.modalService.show(ConfirmDeleteModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: boolean) => {
      if (result) {
        this.api.deleteOrder(id).subscribe(res => {
          this.deleteOrderItems(res).then(data => {
            this.orders = this.orders.filter(order => order.id != id);
          })
        })
      }
    });
  }

  async deleteOrderItems(order: Order) {
    let res = [];
    let orderItems = this.orderItems.filter(ele => ele.order_id == order.id)
    for (let index = 0; index < orderItems.length; index++) {
      const element = orderItems[index];
      res[index] = await this.api.deleteOrderItem(element.id);
    }
    return 'finish';
  }


  getAllOrderItems() {
    this.api.getAllOrderItems().subscribe((res: OrderItem[]) => {
      this.orderItems = res;
    }, err => {
    }, () => {
      if (this.searchUID) {
        this.searchText = this.searchUID;
        this.searchItems();
      }
    })
  }



  emitDataSourceChange() {
    this.mdbTable.dataSourceChange().subscribe((data: any) => {
    });
  }

  searchItems() {
    const prev = this.mdbTable.getDataSource();

    if (!this.searchText) {
      this.mdbTable.setDataSource(this.previous);
      this.orders = this.mdbTable.getDataSource();
    }

    if (this.searchText) {
      this.orders = this.mdbTable.searchLocalDataBy(this.searchText);
      this.mdbTable.setDataSource(prev);
    }

    this.mdbTablePagination.calculateFirstItemIndex();
    this.mdbTablePagination.calculateLastItemIndex();

    this.mdbTable.searchDataObservable(this.searchText).subscribe(() => {
      this.mdbTablePagination.calculateFirstItemIndex();
      this.mdbTablePagination.calculateLastItemIndex();
    });
  }

  ngOnInit(): void {
    this.mdbTable.setDataSource(this.orders);
    this.orders = this.mdbTable.getDataSource();
    this.previous = this.mdbTable.getDataSource();
    this.getAllOrderItems();
  }

  ngAfterViewInit() {
    this.mdbTablePagination.setMaxVisibleItemsNumberTo(this.maxVisibleItems);
    this.mdbTablePagination.calculateFirstItemIndex();
    this.mdbTablePagination.calculateLastItemIndex();
    this.cdRef.detectChanges();
  }

}
