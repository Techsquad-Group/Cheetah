import 'package:cheeta/view/home/seller_home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          toolbarHeight: 80,
          leading: BackButton(
            color: Colors.black,
          ),
        ),
        body: const ProductFormWidget(),
      ),
    );
  }
}

class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({Key? key}) : super(key: key);

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

enum _Category { Electronics, Men, Women, Kids, Mobiles }

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _Category? defaultChoice = _Category.Electronics;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Category'),
          RadioListTile<_Category>(
            title: const Text('Electonics'),
            value: _Category.Electronics,
            groupValue: defaultChoice,
            onChanged: (_Category? value) {
              setState(() {
                defaultChoice = value;
              });
            },
          ),
          RadioListTile<_Category>(
            title: const Text('Men'),
            value: _Category.Men,
            groupValue: defaultChoice,
            onChanged: (_Category? value) {
              setState(() {
                defaultChoice = value;
              });
            },
          ),
          RadioListTile<_Category>(
            title: const Text('Women'),
            value: _Category.Women,
            groupValue: defaultChoice,
            onChanged: (_Category? value) {
              setState(() {
                defaultChoice = value;
              });
            },
          ),
          RadioListTile<_Category>(
            title: const Text('Kids'),
            value: _Category.Kids,
            groupValue: defaultChoice,
            onChanged: (_Category? value) {
              setState(() {
                defaultChoice = value;
              });
            },
          ),
          RadioListTile<_Category>(
            title: const Text('Mobiles'),
            value: _Category.Mobiles,
            groupValue: defaultChoice,
            onChanged: (_Category? value) {
              setState(() {
                defaultChoice = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Subcategory',
              hintText: 'Enter your subcategory',
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (String? _subCategory) {
              if (_subCategory == null || _subCategory.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'City',
              hintText: 'Enter your city',
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (String? _city) {
              if (_city == null || _city.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Location',
              hintText: 'Enter your location',
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (String? _location) {
              if (_location == null || _location.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          //productpic
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Product Name',
              hintText: 'Enter your product name',
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (String? _itemName) {
              if (_itemName == null || _itemName.isEmpty) {
                return 'Please enter the text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Product Description',
              hintText: 'Enter your product description',
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (String? _description) {
              if (_description == null || _description.isEmpty) {
                return 'Please enter the text';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Product Price',
              hintText: 'Enter your product price',
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (String? _price) {
              if (_price == null || _price.isEmpty) {
                return 'Please enter the price';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Add Product'),
              //color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
