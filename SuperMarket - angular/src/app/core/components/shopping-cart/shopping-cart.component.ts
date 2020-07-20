import { Component, OnInit, OnDestroy } from '@angular/core';
import { StorageMap } from '@ngx-pwa/local-storage';
import { Subscription } from 'rxjs';
import { CartItem, CartItemFull } from '../../models/store/cart-item';
import { StoreApiService } from '../../services/store-api.service';
import { MDBModalService, MDBModalRef, ToastService } from 'ng-uikit-pro-standard';
import { AngularFireAuth } from '@angular/fire/auth';
import { AngularFirestore } from '@angular/fire/firestore';
import { FullUser } from '../../models/user';
import { CreateOrderModalComponent } from 'src/app/modules/home/components/create-order-modal/create-order-modal.component';
import { ViewOrdersModalComponent } from 'src/app/modules/home/components/view-orders-modal/view-orders-modal.component';

@Component({
  selector: 'app-shopping-cart',
  templateUrl: './shopping-cart.component.html',
  styleUrls: ['./shopping-cart.component.scss']
})
export class ShoppingCartComponent implements OnInit, OnDestroy {

  constructor(
    private storageMap: StorageMap,
    private storeApi: StoreApiService,
    private modalService: MDBModalService,
    private afAuth: AngularFireAuth,
    private afs: AngularFirestore,
    public toast: ToastService) { }

  dataSubscription: Subscription;
  data: CartItem[];
  products: CartItemFull[];
  productsToShow: CartItemFull[];
  totalCartPrice: number = 0;
  originalCartPrice: number = 0
  modalRef: MDBModalRef;
  userFromDatabase: FullUser;
  userLogged: boolean = false;
  uid: string;


  openCreateOrderModal() {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        user: this.userFromDatabase,
        products: this.productsToShow,
        originalCartPrice: this.originalCartPrice,
        totalCartPrice: this.totalCartPrice
      },
      ignoreBackdropClick: true,
      backdrop: true
    }
    this.modalRef = this.modalService.show(CreateOrderModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: string) => {
      if (result == 'delete') {
        this.deleteAll();
      }
    });
  }

  openViewOrdersModal() {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        uid: this.uid,
      },
    }
    this.modalRef = this.modalService.show(ViewOrdersModalComponent, modalOptions);
  }

  deleteAll() {
    this.storageMap.delete('cartItems').subscribe(() => { });
    this.totalCartPrice = 0;
    this.originalCartPrice = 0;
  }

  getTotalCartPrice() {
    this.totalCartPrice = 0;
    this.originalCartPrice = 0;
    this.products.forEach(element => {
      this.originalCartPrice += (element.item.price * element.quantity);

      if (element.item.inSale) {
        this.totalCartPrice += (element.item.salePrice * element.quantity);
      }
      else {
        this.totalCartPrice += (element.item.price * element.quantity);
      }
    });
  }

  sort() {
    let sortedArray: CartItemFull[] = this.products.sort((obj1, obj2) => {
      let sortObject1 = obj1.dateAdded;
      let sortObject2 = obj2.dateAdded;
      if (sortObject1 < sortObject2)
        return 1;
      if (sortObject1 > sortObject2)
        return -1;
      return 0;
    });
    this.products = sortedArray;
    this.productsToShow = sortedArray;
  }

  checkIfUserLogged() {
    this.afAuth.user.subscribe((res: any) => {
      if (res) {
        this.uid = res.uid;
        this.getUser(res.uid);
        this.userLogged = true;
      }
      else {
        this.userFromDatabase = null;
        this.userLogged = false;
      }
    })
  }

  getUser(uid) {
    this.afs.collection<any>('users').doc(uid).valueChanges().subscribe((res: FullUser) => {
      if (res != undefined) {
        this.userFromDatabase = res;
      }
    }, err => {
      this.userFromDatabase = null;
    })
  }

  getDataFromLocalStorage() {
    this.data = [];
    this.dataSubscription = this.storageMap.watch('cartItems')
      .subscribe((result: CartItem[]) => {
        this.totalCartPrice = 0;
        this.originalCartPrice = 0;
        this.products = [];
        if (result) {
          this.data = result;
          this.data.forEach(element => {
            this.storeApi.getProductById(element.productID).subscribe(res => {
              this.products.push({ quantity: element.quantity, item: res, dateAdded: element.dateAdded })
              this.sort();
              this.getTotalCartPrice();
            })
          });
        }
        else {
          this.productsToShow = null;
          this.products = [];
        }
      });
  }

  ngOnInit(): void {
    this.checkIfUserLogged();
    this.getDataFromLocalStorage();
  }
  ngOnDestroy() {
    this.dataSubscription.unsubscribe();
  }

}
