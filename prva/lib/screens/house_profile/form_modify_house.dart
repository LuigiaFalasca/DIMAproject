import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prva/models/houseProfile.dart';
import 'package:prva/services/databaseForHouseProfile.dart';
import 'package:prva/shared/constants.dart';

class ModifyHouseForm extends StatefulWidget {
  final HouseProfileAdj house;
  const ModifyHouseForm({required this.house});

  @override
  State<ModifyHouseForm> createState() => _ModifyHouseFormState(house: house);
}

class _ModifyHouseFormState extends State<ModifyHouseForm> {
  final HouseProfileAdj house;
  _ModifyHouseFormState({required this.house});

  final _formKey = GlobalKey<FormState>();
  final List<String> typeOfAppartament = [
    "Intero appartamento",
    "Stanza Singola",
    "Stanza Doppia",
    "Monolocale",
    "Bilocale",
    "Trilocale"
  ];

  String? _currentType;
  String? _currentAddress;
  String? _currentCity;
  int? _currentPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Modify House Profile'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                //SizedBox(height: 20.0),
                const Text('Scegli la tipologia:',
                    style: TextStyle(fontSize: 18.0)),
                //SizedBox(height: 20.0),
                DropdownButtonFormField(
                    value: _currentType ?? house.type,
                    items: typeOfAppartament.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text('${type} '),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentType = val)),

                TextFormField(
                  initialValue: house.city,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Insert a city'),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a city' : null,
                  onChanged: (val) => setState(() => _currentCity = val),
                ),
                TextFormField(
                  initialValue: house.address,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Insert an address'),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter an address' : null,
                  onChanged: (val) => setState(() => _currentAddress = val),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  initialValue: house.price.toString(),
                  decoration: const InputDecoration(
                      labelText: "price",
                      hintText: "insert price",
                      icon: Icon(Icons.phone_iphone)),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a price' : null,
                  onChanged: (val) =>
                      setState(() => _currentPrice = (int.parse(val))),
                ),

                //SizedBox(height: 20.0),

                //SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //print('valid');
                        /*
                        try {
                          
                          await DatabaseServiceHouseProfile(house.owner)
                              .updateUserDataHouseProfile(
                                  _currentType ?? house.type,
                                  _currentAddress ?? house.address,
                                  _currentCity ?? house.city,
                                  _currentPrice ?? house.price,
                                  house.idHouse);
                          Navigator.pop(context);
                        } catch (e) {
                          print(e.toString());
                          return null;
                        }*/
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.pink),
                    ),
                    child: const Text(
                      'Finished',
                      style: TextStyle(color: Colors.white),
                    )),
              ]),
            )));
  }
}
