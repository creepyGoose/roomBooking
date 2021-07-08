import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/datas/product_data.dart';

class CartProduct {
  String cid;
  String cat;
  String pid;
  int qtd;
  String size;
  ProductData productData;
  CartProduct();
  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.documentID;
    cat = document.data["category"];
    pid = document.data["pid"];
    qtd = document.data["quantity"];
    size = document.data["size"];
  }
  Map<String, dynamic> toMap() {
    return {
      "category": cat,
      "pid": pid,
      "quantity": qtd,
      "product": productData.toResumeMap()
    };
  }
}
