import { Component, OnInit, Input } from '@angular/core';
import { MDBModalRef, ToastService } from 'ng-uikit-pro-standard';
import { Subject } from 'rxjs';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { FullUser } from 'src/app/core/models/user';
import { CartItemFull } from 'src/app/core/models/store/cart-item';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { OrderItem, Order } from 'src/app/core/models/store/order';

@Component({
  selector: 'app-create-order-modal',
  templateUrl: './create-order-modal.component.html',
  styleUrls: ['./create-order-modal.component.scss']
})
export class CreateOrderModalComponent implements OnInit {

  constructor(
    private modalRef: MDBModalRef,
    private api:StoreApiService,
  ) { }
  action: Subject<string> = new Subject();
  @Input() user:FullUser;
  @Input() products:CartItemFull[];
  @Input() originalCartPrice:number;
  @Input() totalCartPrice:number;
  newOrder:Order;
  orderItem:OrderItem;

  validatingForm: FormGroup;

  closeModal(){
    this.modalRef.hide();
    this.action.next(null);
  }

  sendOrder(){
    this.newOrder = {
      fullName: this.user.displayName,
      phone:this.validatingForm.value.createOrderModalPhone,
      email:this.validatingForm.value.createOrderModalEmail,
      city:this.validatingForm.value.createOrderModalCity,
      adress:this.validatingForm.value.createOrderModalAdress,
      comments:this.validatingForm.value.createOrderModalComments,
      orderStatus:'ההזמנה התקבלה בחנות',
      uid:this.user.uid,
      orderDiscount:this.originalCartPrice-this.totalCartPrice,
      originalOrderPrice:this.originalCartPrice,
      orderDate:String(new Date()),
      statusUpdateDate:null,
      statusUpdateUID:null
    }


    this.api.addOrder(this.newOrder).subscribe((res:Order) =>{
      if(res){
        this.sendToServer(res).then((data) => {
          this.modalRef.hide();
          this.action.next('delete');
        })
      }
    })
  }


  async sendToServer(order) {
    let res = [];
    for (let index = 0; index < this.products.length; index++) {
      const element = this.products[index];
      this.orderItem = {
        order_id:order.id,
        product_id:element.item.id,
        quantity:element.quantity,
        order_item_price:element.item.price,
        order_item_discount:element.item.salePrice || 0
      }
      res[index] = await this.api.addOrderItem(this.orderItem);
    }
    return 'finish';
  }


  ngOnInit(): void {
    this.validatingForm = new FormGroup({
      createOrderModalPhone: new FormControl(this.user.phoneNumber || null, Validators.required),
      createOrderModalEmail: new FormControl(this.user.email || null, Validators.email,),
      createOrderModalCity: new FormControl('', Validators.required),
      createOrderModalAdress: new FormControl('', Validators.required),
      createOrderModalComments: new FormControl('')
    });
  }

  get createOrderModalPhone() {
    return this.validatingForm.get('createOrderModalPhone');
  }

  get createOrderModalEmail() {
    return this.validatingForm.get('createOrderModalEmail');
  }

  get createOrderModalCity() {
    return this.validatingForm.get('createOrderModalCity');
  }

  get createOrderModalAdress() {
    return this.validatingForm.get('createOrderModalAdress');
  }
  get createOrderModalComments() {
    return this.validatingForm.get('createOrderModalComments');
  }
}
