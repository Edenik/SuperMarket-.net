import { Component, OnInit } from '@angular/core';
import { Product } from 'src/app/core/models/store/product';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { Order } from 'src/app/core/models/store/order';
import { Router } from '@angular/router';
import { Category, SubCategory } from 'src/app/core/models/store/category';

@Component({
  selector: 'app-control-panel',
  templateUrl: './control-panel.component.html',
  styleUrls: ['./control-panel.component.scss']
})
export class ControlPanelComponent implements OnInit {

  constructor(private api: StoreApiService, private router: Router) { }
  products: Product[];
  saleProducts: Product[];
  orders: Order[];
  categories: Category[] = [];
  subcategories: SubCategory[] = [];

  navigate(url) {
    this.router.navigate([url])
  }

  getAllProducts() {
    this.products = [];
    this.api.getAllProducts().subscribe((res: Product[]) => {
      this.products = res;
    })
  }

  getAllProductsInSale() {
    this.saleProducts = [];
    this.api.getProductsByQuery('inSale=true').subscribe((res: Product[]) => {
      this.saleProducts = res;
    })
  }


  getAllOrders() {
    this.orders = [];
    this.api.getAllOrders().subscribe((res: Order[]) => {
      this.orders = res;
    })
  }

  getAllCategories() {
    this.categories = [];
    this.api.getAllCategories().subscribe((res: Category[]) => {
      this.categories = res;
    })
  }

  getAllSubcategories() {
    this.categories = [];
    this.api.getAllSubCategories().subscribe((res: SubCategory[]) => {
      this.subcategories = res;
    })
  }



  ngOnInit(): void {
    this.getAllCategories();
    this.getAllSubcategories();
    this.getAllProductsInSale();
    this.getAllProducts();
    this.getAllOrders();
  }

}
