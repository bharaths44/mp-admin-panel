import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test3/model/product_model.dart';
import 'package:test3/utils/mysnackmsg.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String dbRef = 'product'; // Update the collection name to 'product'

  TextEditingController inputCategory = TextEditingController();
  TextEditingController inputPrice = TextEditingController();
  TextEditingController inputImageUrl = TextEditingController();
  TextEditingController inputStock = TextEditingController();
  bool loading = false;
  bool isUpdate = false;
  String docID = '';
  List<ProductModel> productList = []; // Update the type to ProductModel

  reset() {
    inputCategory.clear();
    inputPrice.clear();
    inputImageUrl.clear();
    inputStock.clear();
    setState(() {});
  }

  setUpdateProduct(ProductModel product) {
    setState(() {
      isUpdate = true;
      inputCategory.text = product.category ?? '';
      inputPrice.text = product.price.toString();
      inputImageUrl.text = product.image ?? '';
      inputStock.text = product.stock.toString();
    });
  }

  getAllProducts() async {
    if (productList.isNotEmpty) {
      productList = [];
    }
    await db.collection(dbRef).get().then((value) {
      for (var e in value.docs) {
        print(e);
        productList.add(ProductModel.fromFirestore(e));
      }
      setState(() {});
    });
  }

  updateProduct() async {
    if (inputCategory.text.trim().isEmpty) {
      showMsg(context, 'Enter category');
    } else if (inputPrice.text.trim().isEmpty) {
      showMsg(context, 'Enter price');
    } else if (inputImageUrl.text.trim().isEmpty) {
      showMsg(context, 'Enter image URL');
    } else if (inputStock.text.trim().isEmpty) {
      showMsg(context, 'Enter stock');
    } else {
      setState(() {
        loading = true;
      });

      try {
        ProductModel product = ProductModel(
          category: inputCategory.text.trim(),
          price: int.parse(inputPrice.text.trim()),
          image: inputImageUrl.text.trim(),
          stock: int.parse(inputStock.text.trim()),
        );
        await db
            .collection(dbRef)
            .doc(product.docID) // Using category as the document ID
            .set(product.toFirestore())
            .then((value) {
          setState(() {
            loading = false;
          });
          showMsg(context, 'Product Updated!', isError: false);
          getAllProducts();
          isUpdate = false;
          reset();
        });
      } catch (e) {
        setState(() {
          loading = false;
        });

        showMsg(context, e.toString());
      }
    }
  }

  saveProduct() async {
    if (inputCategory.text.trim().isEmpty) {
      showMsg(context, 'Enter category');
    } else if (inputPrice.text.trim().isEmpty) {
      showMsg(context, 'Enter price');
    } else if (inputImageUrl.text.trim().isEmpty) {
      showMsg(context, 'Enter image URL');
    } else if (inputStock.text.trim().isEmpty) {
      showMsg(context, 'Enter stock');
    } else {
      setState(() {
        loading = true;
      });

      try {
        ProductModel product = ProductModel(
          category: inputCategory.text.trim(),
          price: int.parse(inputPrice.text.trim()),
          image: inputImageUrl.text.trim(),
          stock: int.parse(inputStock.text.trim()),
        );
        await db
            .collection(dbRef)
            .doc(product.docID) // Using category as the document ID
            .set(product.toFirestore())
            .then((value) {
          setState(() {
            loading = false;
          });
          showMsg(context, 'Product Saved!', isError: false);
          getAllProducts();
          reset();
        });
      } catch (e) {
        setState(() {
          loading = false;
        });

        showMsg(context, e.toString());
      }
    }
  }

  onDelete(ProductModel product) async {
    db.collection(dbRef).doc(product.category).delete().then((value) {
      showMsg(context, 'Product Deleted', isError: false);
      setState(() {
        getAllProducts();
      });
    });
  }

  userInput(String title, String hint, TextInputType type,
      TextEditingController controller,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(hintText: hint, labelText: title),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                ProductModel product = productList[index];
                return InkWell(
                  onTap: () {
                    setUpdateProduct(product);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Text(product.category.toString()),
                      title: Text(product.price.toString()),
                      subtitle: Text(product.image.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          onDelete(product);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          userInput(
              'category', 'Enter category.', TextInputType.text, inputCategory,
              readOnly: isUpdate),
          userInput('price', 'Enter price', TextInputType.number, inputPrice),
          userInput('image URL', 'Enter image URL', TextInputType.text,
              inputImageUrl),
          userInput('stock', 'Enter stock', TextInputType.number, inputStock),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loading
                  ? const SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        isUpdate ? updateProduct() : saveProduct();
                      },
                      child: isUpdate
                          ? const Text('Update data')
                          : const Text('Save')),
              isUpdate
                  ? IconButton(
                      onPressed: () {
                        isUpdate = false;
                        reset();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ))
                  : const SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
