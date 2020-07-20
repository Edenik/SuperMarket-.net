import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/core/services/auth.service';
import { AngularFireAuth } from '@angular/fire/auth';
import { UserService } from 'src/app/core/services/user.service';
import { FullUser } from 'src/app/core/models/user';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { Product } from 'src/app/core/models/store/product';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  constructor(
    private api: StoreApiService) { }
  serverError:boolean = false;
  currentUser: FullUser;
  products: Product[];
  inSaleProducts: Product[];
  hasNutritialMark: Product[];
  loading:boolean = true;


  getInSaleProducts() {
    this.inSaleProducts = [];
    this.api.getProductsByQuery('inSale=true').subscribe((res: Product[]) => {
      this.inSaleProducts = res;
      this.serverError = false;
      this.getNutritialMarkProducts();
    }, err => {
      this.serverError = true;
      this.loading = false;
    });
  }

  getNutritialMarkProducts(){
    this.hasNutritialMark = [];
    this.api.getProductsByQuery('hasNutritialMark=true').subscribe((res: Product[]) => {
      this.hasNutritialMark = res;
      this.getAllProducts();
    })
  }

  getAllProducts() {
    this.products = [];
    this.api.getAllProducts().subscribe((res: Product[]) => {
      this.products = res;
      this.loading = false;
    })
  }

  ngOnInit(): void {
    this.getInSaleProducts();
  }
}
