
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prva/schermiProva.dart';


class FormHouseAdj extends StatefulWidget {
  const FormHouseAdj({super.key});

  @override
  State<FormHouseAdj> createState() => _FormHouseAdjState();
}

class _FormHouseAdjState extends State<FormHouseAdj> {

  final scaffoldKey = GlobalKey<FormState>();

  DateTime? _startDate;
  DateTime? _endDate;
  List<String> imageURLs =  ['', '', '', ''];

   // controller for the textfield
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();


  void _selectDate(BuildContext context, DateTime? date, TextEditingController dateController) async {
    // get the initial date
    DateTime initialDate = date ?? DateTime.now();

    // show the date picker and wait for the result
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 10),
    );

    // if the user picked a date, update the state
    if (pickedDate != null && pickedDate != date) {
      setState(() {
        // set the selected date
        date = pickedDate;

        // format the date as dd/mm/yyyy
        String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

        // update the textfield controller
        dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: 570,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create your house profile',
                                textAlign: TextAlign.start,
                               style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF101213),
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                          ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 24),
                                child: Text(
                                  'Start with address and type!',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    autofocus: true,
                                    autofillHints: [AutofillHints.email],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Type',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    //validator: 
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    autofocus: true,
                                    autofillHints: [AutofillHints.addressCity],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Address',
                                      labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    /*validator: _model
                                        .addressController1Validator
                                        .asValidator(context),*/
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        maxWidth: 570,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFF1F4F8),
                          width: 2,
                        ),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 24),
                                child: Text(
                                  'Something about the house',
                                   textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                )
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                child: Container(
                                  width: double.infinity,
                                  child: TextFormField(
                                    autofocus: true,
                                    autofillHints: [AutofillHints.email],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                    labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                         color: Color(0xFFE0E3E7),
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                     focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    /*validator: _model
                                        .descriptionControllerValidator
                                        .asValidator(context),*/
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Max number of people that\ncan live in the house:',
                                    style: TextStyle(
                                           fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 16,
                                        ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 0, 16),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                 color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                           focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                          keyboardType: TextInputType.number,
                                         /* validator: _model
                                              .addressController2Validator
                                              .asValidator(context),*/
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Floor number of the house:',
                                    style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 16,
                                        ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 0, 16),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE0E3E7),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                          keyboardType: TextInputType.number,
                                          /*validator: _model
                                              .addressController3Validator
                                              .asValidator(context),*/
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Number of bathrooms:',
                                    style: TextStyle(
                                           fontFamily: 'Plus Jakarta Sans',
                                          fontSize: 16,
                                        ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          48, 0, 0, 16),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                          autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFE0E3E7),
                                               width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                           focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                          keyboardType: TextInputType.number,
                                         /* validator: _model
                                              .addressController4Validator
                                              .asValidator(context),*/
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                
                
                
                // Generated code for this Container Widget...
Padding(
  padding: EdgeInsets.all(12),
  child: Container(
    width: double.infinity,
    constraints: BoxConstraints(
      maxWidth: 570,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          blurRadius: 4,
          color: Color(0x33000000),
          offset: Offset(0, 2),
        )
      ],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color:Color(0xFFE0E3E7),
        width: 2,
      ),
    ),
    child: Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
              child: Text(
                'Something about the rent',
                textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                child:TextFormField(
                                      controller: _dateStartController,
                                      readOnly: true,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.birthday],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          onPressed: () {
                                            // call the function to show the date picker
                                            _selectDate(context, _startDate, _dateStartController);
                                          },
                                        ),
                                        labelText: 'Start date of rent',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Start date of rent',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      validator: (val) => val!.isEmpty
                                          ? 'Please enter a date'
                                          : null,
                                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                child: TextFormField(
                                      controller: _dateEndController,
                                      readOnly: true,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.birthday],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          onPressed: () {
                                            // call the function to show the date picker
                                            _selectDate(context, _endDate, _dateEndController);
                                          },
                                        ),
                                        labelText: 'End date of rent',
                                        labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'End date of rent',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      validator: (val) => val!.isEmpty
                                          ? 'Please enter a date'
                                          : null,
                                    ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
              child: Container(
                width: double.infinity,
                child: TextFormField(
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                    enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFE0E3E7),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF4B39EF),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFFF5963),
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.all(24),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Color(0xFF101213),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  //validator: _model.descriptionController3Validator
                   //   .asValidator(context),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),



 Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          maxWidth: 570,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFFF1F4F8),
                            width: 2,
                          ),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 24),
                                  child: Text(
                                    'Almost done!',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Plus Jakarta Sans',
                                      color: Color(0xFF57636C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pick some photos for your profile!',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (imageURLs[0].isEmpty) {
                                              imageURLs[0] =
                                                  await SchermiProva()
                                                      .uploadFile();
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: imageURLs
                                                    .elementAt(0)
                                                    .isEmpty
                                                ? Image.asset(
                                                    'assets/userPhoto.jpg',
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.20,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    imageURLs[0],
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.20,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: imageURLs.elementAt(0).isEmpty
                                              ? null
                                              : IconButton(
                                                  icon: const Icon(Icons.close),
                                                  color:
                                                      const Color(0xFFFF5963),
                                                  onPressed: () {},
                                                ),
                                        ),
                                      ]),
                                      SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.05),
                                      Column(children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (imageURLs[1].isEmpty) {
                                              imageURLs[1] =
                                                  await SchermiProva()
                                                      .uploadFile();
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            }
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: imageURLs
                                                    .elementAt(1)
                                                    .isEmpty
                                                ? Image.asset(
                                                    'assets/userPhoto.jpg',
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.20,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    imageURLs[1],
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.30,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.20,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: imageURLs.elementAt(1).isEmpty
                                              ? null
                                              : IconButton(
                                                  icon: Icon(Icons.close),
                                                  color: Color(0xFFFF5963),
                                                  onPressed: () {},
                                                ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (imageURLs[2].isEmpty) {
                                            imageURLs[2] = await SchermiProva()
                                                .uploadFile();

                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: imageURLs.elementAt(2).isEmpty
                                              ? Image.asset(
                                                  'assets/userPhoto.jpg',
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  imageURLs[2],
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: imageURLs.elementAt(2).isEmpty
                                            ? null
                                            : IconButton(
                                                icon: Icon(Icons.close),
                                                color: Color(0xFFFF5963),
                                                onPressed: () {},
                                              ),
                                      ),
                                    ]),
                                    SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.05),
                                    Column(children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (imageURLs[3].isEmpty) {
                                            imageURLs[3] = await SchermiProva()
                                                .uploadFile();
                                            print('formADJ680');
                                            print(imageURLs[0]);
                                            if (mounted) {
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: imageURLs.elementAt(3).isEmpty
                                              ? Image.asset(
                                                  'assets/userPhoto.jpg',
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  imageURLs[3],
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.30,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.20,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: imageURLs.elementAt(3).isEmpty
                                            ? null
                                            : IconButton(
                                                icon: Icon(Icons.close),
                                                color: Color(0xFFFF5963),
                                                onPressed: () {},
                                              ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                
                
                ],
              ),
            ),
          ),
        ),
    );
  }
}
