import { Component, OnInit } from '@angular/core';
import { MDBModalService, MDBModalRef } from 'ng-uikit-pro-standard';
import { Category, } from 'src/app/core/models/store/category';
import { EditCategoryModalComponent } from '../../components/edit-category-modal/edit-category-modal.component';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { Product } from 'src/app/core/models/store/product';
import { HeadElements } from 'src/app/core/models/store/headElements';

@Component({
  selector: 'app-categories',
  templateUrl: './categories.component.html',
  styleUrls: ['./categories.component.scss']
})
export class CategoriesComponent implements OnInit {

  constructor(private modalService: MDBModalService, private api: StoreApiService) { }

  modalRef: MDBModalRef;
  categories: Category[];
  nullCategory: Category = {
    id: null,
    name: null,
    dateAdded: null,
    addedByUID: null,
    dateEdited: null,
    editedByUID: null
  }
  reqComplete: boolean;
  products: Product[];
  viewType: string = 'table';
  headElements: HeadElements[] = [
    { value: 'id', display: 'ID' },
    { value: 'categoryName', display: 'שם קטגוריה' },
    { value: 'quantity', display: 'מוצרים' },
    { value: 'dateAdded', display: 'תאריך הוספה' },
  ];

  openAddCategoryModal() {
    let modalOptions = {
      class: 'modal-dialog modal-notify modal-info',
      data: {
        category: this.nullCategory,
        formType: 'addCategory'
      },
      ignoreBackdropClick: true
    }
    this.modalRef = this.modalService.show(EditCategoryModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: Category) => {
      this.categories.push(result);
    });
  }



  getAllCategories() {
    this.reqComplete = false;
    this.categories = [];
    this.api.getAllCategories().subscribe((res: Category[]) => {
      this.categories = res;
      this.getAllProducts();
    })
  }


  deleteCategory(id) {
    this.categories = this.categories.filter(category => category.id != id);
  }

  getAllProducts() {
    this.products = [];
    let filteredProducts: Product[];
    this.api.getAllProducts().subscribe((res: Product[]) => {
      this.products = res;
      this.categories.forEach(element => {
        filteredProducts = this.products.filter(product => product.category == element.name)
        element.quantity = filteredProducts.length;
      });
      this.reqComplete = true;
    })
  }

  changeView(view: string) {
    this.viewType = view;
  }

  sort(category, direction) {
    let sortObject1;
    let sortObject2;

    let sortedArray: Category[] = this.categories.sort((obj1, obj2) => {

      switch (category) {
        case 'id':
          sortObject1 = obj1.id;
          sortObject2 = obj2.id;
          break;
        case 'categoryName':
          sortObject1 = obj1.name;
          sortObject2 = obj2.name;
          break;
        case 'dateAdded':
          sortObject1 = Number(new Date(obj1.dateAdded));
          sortObject2 = Number(new Date(obj2.dateAdded));
          break;
        case 'quantity':
          sortObject1 = obj1.quantity;
          sortObject2 = obj2.quantity;
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
    this.categories = sortedArray;
  }

  ngOnInit(): void {
    this.getAllCategories();
  }

}
