import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adminpanel/model/product_model.dart';
import 'package:adminpanel/utils/mysnackmsg.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  String dbRef = 'product'; // Update the collection name to 'product'

  TextEditingController inputCategory = TextEditingController();
  TextEditingController inputPrice = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputStock = TextEditingController();
  TextEditingController inputImageUrl = TextEditingController();
  bool loading = false;
  bool isUpdate = false;
  String docID = '';
  List<ProductModel> productList = []; // Update the type to ProductModel

  File? _image;

  reset() {
    inputName.clear();
    inputCategory.clear();
    inputPrice.clear();
    inputStock.clear();
    _image = null;
    setState(() {});
  }

  setUpdateProduct(ProductModel product) {
    setState(() {
      isUpdate = true;
      inputName.text = product.name ?? '';
      inputCategory.text = product.category ?? '';
      inputPrice.text = product.price.toString();
      inputStock.text = product.stock.toString();
      // You might want to load the image as well
      // For simplicity, I'm not loading the image here
    });
  }

  Future<void> _uploadImage() async {
    // Pick an image from the gallery
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Convert the pickedFile to a File
      _image = File(pickedFile.path);

      // Upload the image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/${DateTime.now().toString()}');
      final uploadTask = storageRef.putFile(_image!);

      // Wait for the upload to complete
      await uploadTask.whenComplete(() async {
        // Get the download URL of the uploaded image
        final downloadURL = await storageRef.getDownloadURL();

        // Update the inputImageUrl controller with the download URL
        setState(() {
          inputImageUrl.text = downloadURL;
          loading = false;
        });
      });
    }
  }

  Future<String?> _uploadFile(String name) async {
    try {
      if (_image != null) {
        TaskSnapshot snapshot =
            await storage.ref('images/$name').putFile(_image!);
        return await snapshot.ref.getDownloadURL();
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  getAllProducts() async {
    if (productList.isNotEmpty) {
      productList = [];
    }
    await db.collection(dbRef).get().then((value) {
      for (var e in value.docs) {
        productList.add(ProductModel.fromFirestore(e));
      }
      setState(() {});
    });
  }

  updateProduct() async {
    if (inputName.text.trim().isEmpty) {
      showMsg(context, 'Enter name');
    } else if (inputCategory.text.trim().isEmpty) {
      showMsg(context, 'Enter category');
    } else if (inputPrice.text.trim().isEmpty) {
      showMsg(context, 'Enter price');
    } else if (_image == null) {
      showMsg(context, 'Upload an image');
    } else if (inputStock.text.trim().isEmpty) {
      showMsg(context, 'Enter stock');
    } else {
      setState(() {
        loading = true;
      });

      try {
        String? imageUrl = await _uploadFile(inputName.text.trim());

        if (imageUrl != null) {
          ProductModel product = ProductModel(
            name: inputName.text.trim(),
            category: inputCategory.text.trim(),
            price: int.parse(inputPrice.text.trim()),
            image: imageUrl,
            stock: int.parse(inputStock.text.trim()),
          );

          await db.collection(dbRef).doc(product.name).update({
            'price': product.price,
            'stock': product.stock,
            'image': product.image,
          });

          showMsg(context, 'Product Updated!', isError: false);
          await getAllProducts();
        } else {
          showMsg(context, 'Error uploading image');
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        showMsg(context, e.toString());
      }
    }
  }

  saveProduct() async {
    if (inputName.text.trim().isEmpty) {
      showMsg(context, 'Enter Name');
    } else if (inputCategory.text.trim().isEmpty) {
      showMsg(context, 'Enter category');
    } else if (inputPrice.text.trim().isEmpty) {
      showMsg(context, 'Enter price');
    } else if (_image == null) {
      showMsg(context, 'Upload an image');
    } else if (inputStock.text.trim().isEmpty) {
      showMsg(context, 'Enter stock');
    } else {
      setState(() {
        loading = true;
      });

      try {
        String? imageUrl = await _uploadFile(inputName.text.trim());

        if (imageUrl != null) {
          ProductModel product = ProductModel(
            name: inputName.text.trim(),
            category: inputCategory.text.trim(),
            price: int.parse(inputPrice.text.trim()),
            image: imageUrl,
            stock: int.parse(inputStock.text.trim()),
          );
          await db
              .collection(dbRef)
              .doc(product.name) // Using category as the document ID
              .set(product.toFirestore())
              .then((value) {
            setState(() {
              loading = false;
            });
            showMsg(context, 'Product Saved!', isError: false);
            getAllProducts();
            reset();
          });
        } else {
          showMsg(context, 'Error uploading image');
        }
      } catch (e) {
        setState(() {
          loading = false;
        });

        showMsg(context, e.toString());
      }
    }
  }

  onDelete(ProductModel product) async {
    db.collection(dbRef).doc(product.name).delete().then((value) {
      showMsg(context, 'Product Deleted', isError: false);
      setState(() {
        getAllProducts();
      });
    });
  }

  userInput(String title, String hint, TextInputType type,
      TextEditingController controller,
      {bool readOnly = false, Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: AbsorbPointer(
          absorbing: readOnly,
          child: title == 'Upload Image'
              ? ElevatedButton(
                  onPressed: onTap,
                  child: Text(title),
                )
              : TextField(
                  controller: controller,
                  keyboardType: type,
                  decoration: InputDecoration(hintText: hint, labelText: title),
                ),
        ),
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
        title: const Text(
          'SmartStock Pro',
          textScaleFactor: 1.5,
        ),
        backgroundColor: Colors.amber.shade800,
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
                      leading: product.image != null
                          ? Image.network(product.image!, height: 50, width: 50)
                          : Icon(Icons.image),
                      title: Text(product.name.toString()),
                      subtitle: Row(
                        children: [
                          Text(
                              'Category :${product.category.toString()} Stock :${product.stock.toString()}'),
                        ],
                      ),
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
          userInput('Name', 'Enter name', TextInputType.text, inputName,
              readOnly: isUpdate),
          userInput(
              'Category', 'Enter category.', TextInputType.text, inputCategory,
              readOnly: isUpdate),
          userInput('Price', 'Enter price', TextInputType.number, inputPrice),
          userInput('Stock', 'Enter category.', TextInputType.text, inputStock,
              readOnly: isUpdate),
          userInput('Upload Image', 'Upload Image', TextInputType.text,
              inputStock, // It's a dummy text field for the button
              onTap: _uploadImage),
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
