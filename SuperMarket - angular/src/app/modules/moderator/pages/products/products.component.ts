import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/core/models/store/product';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { Order, OrderItem } from 'src/app/core/models/store/order';
import { ConvertToCSVService } from 'src/app/core/services/convert-to-csv.service';
import { DatePipe } from '@angular/common';
import { MDBModalService, MDBModalRef } from 'ng-uikit-pro-standard';
import { EditProductModalComponent } from '../../components/edit-product-modal/edit-product-modal.component';
import { HeadElements } from 'src/app/core/models/store/headElements';

@Component({
  selector: 'app-products',
  templateUrl: './products.component.html',
  styleUrls: ['./products.component.scss']
})
export class ProductsComponent implements OnInit {

  constructor(private api: StoreApiService, private csvService: ConvertToCSVService, private datePipe: DatePipe,
    private modalService: MDBModalService
  ) { }
  products: Product[];
  saleProducts: Product[];
  orders: Order[];
  orderItems: OrderItem[];
  modalRef: MDBModalRef;
  reqComplete: boolean = false;
  nullProduct: Product = {
    id: null,
    productName: null,
    price: null,
    brand: null,
    unit: null,
    inSale: null,
    weight: null,
    salePrice: null,
    saleDescription: null,
    hasNutritialMark: null,
    nutritialSodium: null,
    nutritialSugar: null,
    nutritialFat: null,
    category: null,
    subCategory: null,
    photoURL: null,
    dateAdded: null,
    addedByUID: null,
    dateEdited: null,
    editedByUID: null
  }
  viewType: string = 'table';
  headElements: HeadElements[] = [
    { value: 'id', display: 'ID' },
    { value: 'productName', display: 'שם המוצר' },
    { value: 'categoryName', display: 'קטגוריה' },
    { value: 'subcategoryName', display: 'תת-קטגוריה' },
    { value: 'price', display: 'מחיר' },
    { value: 'inSale', display: 'מבצע' },
    { value: 'dateAdded', display: 'תאריך הוספה' },
  ];


  openAddProductModal() {
    let modalOptions = {
      class: 'modal-dialog modal-dialog-scrollable modal-notify modal-info',
      data: {
        product: this.nullProduct,
        formType: 'addProduct'
      },
      ignoreBackdropClick: true
    }
    this.modalRef = this.modalService.show(EditProductModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: Product) => {
      this.products.push(result);
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
      this.products = this.products.filter(ele => ele.id != result.id)
      this.products.push(result)
      this.sort('id', 'plus');
    });
  }

  sort(category, direction) {
    let sortObject1;
    let sortObject2;

    let sortedArray: Product[] = this.products.sort((obj1, obj2) => {

      switch (category) {
        case 'id':
          sortObject1 = obj1.id;
          sortObject2 = obj2.id;
          break;
        case 'categoryName':
          sortObject1 = obj1.category;
          sortObject2 = obj2.category;
          break;
        case 'productName':
          sortObject1 = obj1.productName;
          sortObject2 = obj2.productName;
          break;
        case 'subcategoryName':
          sortObject1 = obj1.subCategory;
          sortObject2 = obj2.subCategory;
          break;
        case 'id':
          sortObject1 = obj1.id;
          sortObject2 = obj2.id;
          break;
        case 'inSale':
          sortObject1 = obj1.inSale;
          sortObject2 = obj2.inSale;
          break;
        case 'price':
          if (obj1.inSale == true) {
            sortObject1 = obj1.salePrice
          }
          else {
            sortObject1 = obj1.price
          }

          if (obj2.inSale == true) {
            sortObject2 = obj2.salePrice
          }
          else {
            sortObject2 = obj2.price
          }
          break;
        case 'dateAdded':
          sortObject1 = Number(new Date(obj1.dateAdded));
          sortObject2 = Number(new Date(obj2.dateAdded));
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
    this.products = sortedArray;
  }

  getAllProducts() {
    this.products = [];
    this.api.getAllProducts().subscribe((res: Product[]) => {
      this.products = res;
      this.reqComplete = true;
    })
  }

  changeView(view: string) {
    this.viewType = view;
  }

  deleteProduct(id) {
    this.products = this.products.filter(product => product.id != id);
  }

  downloadProductsData() {
    let date = this.datePipe.transform(new Date(), 'dd.MM.yy HH.mm');
    this.csvService.downloadFile(this.products, `Products- ${date}`, 'products');
  }


  ngOnInit(): void {
    this.getAllProducts();
  }

}
