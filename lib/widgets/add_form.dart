import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modals/products.dart';

class AddForm extends StatefulWidget {
  final Function addProduct;

  AddForm({
    @required this.addProduct
  });

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  var _hasExpireDate = false;
  var _editValues = Products(id: DateTime.now().toString(),name: '',quantity: 0,price: 0,imageUrl: '',supplierId: '',expireDate: null,description: '');
  DateTime _selectedDate;

  void _dateTimePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2024),
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _addToList(){
    var _isValid = _formKey.currentState.validate();
    if(!_isValid){
      return;
    }
    _formKey.currentState.save();

    /*widget.addProduct(_editValues);*/

    //print(_selectedDate);
    widget.addProduct(
        new Products(
            id: _editValues.id,
            name: _editValues.name,
            price: _editValues.price,
            expireDate: _selectedDate,
            imageUrl: _editValues.imageUrl,
            description: _editValues.description,
            supplierId: _editValues.supplierId,
            quantity: _editValues.quantity
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    //print(_selectedDate);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
      color: Colors.orangeAccent[100],
      height: 500,
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              validator: (value){
                if(value.isEmpty || value.length < 3){
                  return 'enter valid name';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'product name',
                  labelStyle: TextStyle(
                      fontFamily: 'Architect'
                  )
              ),
              onSaved: (value){
                _editValues = Products(
                  id: _editValues.id,
                  name: value,
                  description: _editValues.description,
                  expireDate: _editValues.expireDate,
                  supplierId: _editValues.supplierId,
                  imageUrl: _editValues.imageUrl,
                  price: _editValues.price,
                  quantity: _editValues.quantity,
                );
              },
            ),
            TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return 'enter valid price';
                }
                if(double.tryParse(value) == null){
                  return 'enter valid price';
                }
                if(double.tryParse(value) <= 0 ){
                  return 'enter valid price';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'price',
                  labelStyle: TextStyle(
                      fontFamily: 'Architect'
                  )
              ),
              onSaved: (value){
                _editValues = Products(
                  id: _editValues.id,
                  name: _editValues.name,
                  description: _editValues.description,
                  expireDate: _editValues.expireDate,
                  supplierId: _editValues.supplierId,
                  imageUrl: _editValues.imageUrl,
                  price: double.parse(value),
                  quantity: _editValues.quantity,
                );
              },
            ),
            TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return 'enter valid quantity';
                }
                if(double.tryParse(value) == null){
                  return 'enter valid quantity';
                }
                if(double.tryParse(value) <= 0){
                  return 'enter valid quantity';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'quantity',
                  labelStyle: TextStyle(
                      fontFamily: 'Architect'
                  )
              ),
              onSaved: (value){
                _editValues = Products(
                  id: _editValues.id,
                  name: _editValues.name,
                  description: _editValues.description,
                  expireDate: _editValues.expireDate,
                  supplierId: _editValues.supplierId,
                  imageUrl: _editValues.imageUrl,
                  price: _editValues.price,
                  quantity: double.parse(value),
                );
              },
            ),
            TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return 'enter valid description';
                }
                if(value.length < 5){
                  return 'enter valid descrpition';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
                  labelText: 'description',
                labelStyle: TextStyle(
                  fontFamily: 'Architect'
                )
              ),
              onSaved: (value){
                _editValues = Products(
                  id: _editValues.id,
                  name: _editValues.name,
                  description: value,
                  expireDate: _editValues.expireDate,
                  supplierId: _editValues.supplierId,
                  imageUrl: _editValues.imageUrl,
                  price: _editValues.price,
                  quantity: _editValues.quantity,
                );
              },
            ),
            TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return 'enter supplier id';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'supplier id',
                  labelStyle: TextStyle(
                      fontFamily: 'Architect'
                  )
              ),
              onSaved: (value){
                _editValues = Products(
                  id: _editValues.id,
                  name: _editValues.name,
                  description: _editValues.description,
                  expireDate: _editValues.expireDate,
                  supplierId: value,
                  imageUrl: _editValues.imageUrl,
                  price: _editValues.price,
                  quantity: _editValues.quantity,
                );
              },
            ),
            TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return 'enter url';
                }
                if(value.length < 8){
                  return 'enter url';
                }
                if(!value.startsWith('http') && !value.startsWith('https')){
                  return 'enter valid url';
                }
                return null;
              },
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                  labelText: 'image url',
                  labelStyle: TextStyle(
                      fontFamily: 'Architect'
                  )
              ),
              onSaved: (value){
                _editValues = Products(
                  id: _editValues.id,
                  name: _editValues.name,
                  description: _editValues.description,
                  expireDate: _editValues.expireDate,
                  supplierId: _editValues.supplierId,
                  imageUrl: value,
                  price: _editValues.price,
                  quantity: _editValues.quantity,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: _hasExpireDate ? MainAxisAlignment.center :MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Switch(
                      value: _hasExpireDate,
                      onChanged: (value){
                        setState(() {
                          _hasExpireDate = !_hasExpireDate;
                        });
                      },
                      activeColor: Colors.pink,
                    ),
                    Text(
                      'has expire date',
                      style: TextStyle(
                        fontFamily: 'Architect'
                      ),
                    )
                  ],
                ),
                _hasExpireDate ? FlatButton(
                  color: Colors.limeAccent,
                  child: Text(
                      'select date',
                    style: TextStyle(
                      fontFamily: 'Architect'
                    ),
                  ),
                  onPressed: _dateTimePicker,
                ): Container(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: _addToList,
              child: Text('Add to List'),
              color: Colors.red[400],
              splashColor: Colors.red[800],
            )
          ],
        ),
      ),
    );
  }
}
