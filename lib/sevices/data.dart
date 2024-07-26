 import '../models/category_model.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName = "World";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Nation";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Business";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Health";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Sports";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Entertainment";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Technology";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName = "Science";
  category.add(categoryModel);
  categoryModel = new CategoryModel();


  return category;
 }