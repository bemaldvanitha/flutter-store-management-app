import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/supplier.dart';
import '../providers/supplier_provider.dart';

class AddSupplierScreen extends StatefulWidget {
  @override
  _AddSupplierScreenState createState() => _AddSupplierScreenState();
}

class _AddSupplierScreenState extends State<AddSupplierScreen> {
  final _key = GlobalKey<FormState>();
  var _editSupplier = Supplier(id: DateTime.now().toString(),name: '',email: '',number: '');

  @override
  Widget build(BuildContext context) {
    final _supplierProv = Provider.of<SupplierProvider>(context,listen: false);

    void saveSupplier(){
      var _isValid = _key.currentState.validate();
      if(!_isValid){
        return;
      }
      _key.currentState.save();
      _supplierProv.addSupplier(
        new Supplier(id: DateTime.now().toString(), name: _editSupplier.name, number: _editSupplier.number, email: _editSupplier.email)
      );
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Supplier'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveSupplier,
          )
        ],
      ),
      body: Container(
        height: 360,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 7,
              spreadRadius: 2
            )
          ],
          color: Colors.yellow[100]
        ),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value){
                  if(value.isEmpty || value.length < 5){
                    return 'enter valid name';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.text_fields),
                  labelText: 'enter name',
                    labelStyle: TextStyle(
                        fontFamily: 'Architect'
                    )
                ),
                onSaved: (value){
                  _editSupplier = Supplier(
                     id: _editSupplier.id,
                    name: value,
                    number: _editSupplier.number,
                    email: _editSupplier.email
                  );
                },
              ),
              TextFormField(
                validator: (value){
                  if(value.isEmpty || value.length <= 9){
                    return 'enter valid number';
                  }
                  if(double.tryParse(value) == null){
                    return 'enter valid number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                    labelText: 'enter number',
                    labelStyle: TextStyle(
                        fontFamily: 'Architect'
                    )
                ),
                onSaved: (value){
                  _editSupplier = Supplier(
                      id: _editSupplier.id,
                      name: _editSupplier.name,
                      number: value,
                      email: _editSupplier.email
                  );
                },
              ),
              TextFormField(
                validator: (value){
                  if(value.isEmpty || value.length < 8){
                    return 'enter valid email';
                  }
                  if(!value.endsWith('.com')){
                    return 'enter valid email';
                  }
                  return null;
                },
                maxLines: 2,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                    labelText: 'enter email',
                    labelStyle: TextStyle(
                        fontFamily: 'Architect'
                    )
                ),
                onSaved: (value){
                  _editSupplier = Supplier(
                      id: _editSupplier.id,
                      name: _editSupplier.name,
                      number: _editSupplier.number,
                      email: value
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
