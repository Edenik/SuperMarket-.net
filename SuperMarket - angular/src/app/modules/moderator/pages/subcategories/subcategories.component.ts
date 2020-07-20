import { Component, OnInit } from '@angular/core';
import { MDBModalService, MDBModalRef } from 'ng-uikit-pro-standard';
import { Category, SubCategory } from 'src/app/core/models/store/category';
import { EditCategoryModalComponent } from '../../components/edit-category-modal/edit-category-modal.component';
import { StoreApiService } from 'src/app/core/services/store-api.service';
import { EditSubcategoryModalComponent } from '../../components/edit-subcategory-modal/edit-subcategory-modal.component';
import { Product } from 'src/app/core/models/store/product';
import { HeadElements } from 'src/app/core/models/store/headElements';

@Component({
  selector: 'app-subcategories',
  templateUrl: './subcategories.component.html',
  styleUrls: ['./subcategories.component.scss']
})
export class SubcategoriesComponent implements OnInit {

  constructor(private modalService: MDBModalService, private api:StoreApiService) { }

  modalRef: MDBModalRef;
  categories:Category[]=[];
  subcategories:SubCategory[]=[];
  nullSubcategory: SubCategory ={
    id: null,
    name: null,
    dateAdded: null,
    addedByUID: null,
    dateEdited: null,
    editedByUID: null,
    categoryName: null,
    categoryID: null
  }
  reqComplete:boolean= false;
  products:Product[];
  viewType:string = 'table';
  headElements: HeadElements[] = [
    { value: 'id', display: 'ID' },
    { value: 'subcategoryName', display: 'שם תת-קטגוריה' },
    { value: 'quantity', display: 'מוצרים' },
    { value: 'categoryName', display: 'שם קטגוריית אב' },
    { value: 'dateAdded', display: 'תאריך הוספה' },
  ];

  openAddSubcategoryModal() {
    let modalOptions = {
      class: 'modal-dialog modal-notify modal-info',
      data: {
        subcategory: this.nullSubcategory,
        formType: 'addSubcategory',
        categories:this.categories
      },
      ignoreBackdropClick: true
    }
    this.modalRef = this.modalService.show(EditSubcategoryModalComponent, modalOptions);
    this.modalRef.content.action.subscribe((result: SubCategory) => {
      this.subcategories.push(result);
    });
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
      this.getAllProducts();
    })
  }


  getAllProducts() {
    this.products = [];
    let filteredProducts:Product[];
    this.api.getAllProducts().subscribe((res: Product[]) => {
      this.products = res;
      this.subcategories.forEach(element => {
        filteredProducts =  this.products.filter(product => product.subCategory == element.name)
        element.quantity = filteredProducts.length;
      });
      this.reqComplete= true;
    })
  }

  deleteSubcategory(id){
    this.subcategories = this.subcategories.filter(subcategory => subcategory.id != id);
  }

  changeView(view:string){
    this.viewType = view;
  }

  sort(category, direction) {
    let sortObject1;
    let sortObject2;

    let sortedArray: SubCategory[] = this.subcategories.sort((obj1, obj2) => {

      switch (category) {
        case 'id':
          sortObject1 = obj1.id;
          sortObject2 = obj2.id;
          break;
        case 'subcategoryName':
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
        case 'categoryName':
          sortObject1 = obj1.categoryName;
          sortObject2 = obj2.categoryName;
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
    this.subcategories = sortedArray;
  }
  ngOnInit(): void {
    this.getAllCategories();
    this.getAllSubcategories();
  }

}
