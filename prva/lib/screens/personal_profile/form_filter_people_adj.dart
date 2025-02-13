import 'package:flutter/material.dart';
import 'package:geocoding_resolver/geocoding_resolver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:prva/models/filters.dart';
import 'package:prva/models/user.dart';
import 'package:prva/screens/shared/constant.dart';
import 'package:prva/services/databaseForFilters.dart';

class FormFilterPeopleAdj extends StatefulWidget {
  const FormFilterPeopleAdj({super.key});

  @override
  State<FormFilterPeopleAdj> createState() => _FormFilterPeopleAdjState();
}

class _FormFilterPeopleAdjState extends State<FormFilterPeopleAdj> {
  final scaffoldKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  late LatLng selLocation;
  String? city;
  bool checkboxListTileValue1 = true;
  bool checkboxListTileValue2 = true;
  bool checkboxListTileValue3 = true;
  bool checkboxListTileValue4 = true;
  bool checkboxListTileValue5 = true;
  double sliderValue = 4000;
  final List<String> typeOfAppartament = [
    "Apartment",
    "Single room",
    "Double room",
    "Studio apartment",
    "Two-room apartment",
  ];

  bool flagCity = true;
  bool flagBudget = true;
  bool flagType0 = true;
  bool flagType1 = true;
  bool flagType2 = true;
  bool flagType3 = true;
  bool flagType4 = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utente>(context);
    return StreamBuilder<FiltersHouseAdj>(
        stream: DatabaseServiceFilters(user.uid).getFiltersAdj,
        builder: (context, snapshot) {
          FiltersHouseAdj? oldFilters = snapshot.data;
          city = initialCity(oldFilters);
          sliderValue = initialBudget(oldFilters);
          checkboxListTileValue1 = initialType0(oldFilters);
          checkboxListTileValue2 = initialType1(oldFilters);
          checkboxListTileValue3 = initialType2(oldFilters);
          checkboxListTileValue4 = initialType3(oldFilters);
          checkboxListTileValue5 = initialType4(oldFilters);

          return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: mainColor,
                  title: Text(
                    'Set your preferences',
                    style: GoogleFonts.plusJakartaSans(
                      color: backgroundColor,
                      fontSize: size24(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                backgroundColor: backgroundColor,
                body: SafeArea(
                  top: true,
                  child: SingleChildScrollView(
                    child: Form(
                      key: scaffoldKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              width: double.infinity,
                              constraints: const BoxConstraints(
                                maxWidth: 570,
                              ),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                boxShadow: const [
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
                                alignment: const AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 0, 16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Pick the city',
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color:
                                                      const Color(0xFF101213),
                                                  fontSize: size16(context),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child:
                                              GooglePlaceAutoCompleteTextField(
                                            textEditingController: controller,
                                            googleAPIKey:
                                                "AIzaSyD8yblyesPc-09bye4ZF9KlO95G6RhhlmA",
                                            inputDecoration: InputDecoration(
                                              labelText: city,
                                              labelStyle:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFF57636C),
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFE0E3E7),
                                                  width: 2,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: mainColor,
                                                  width: 2,
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: errorColor,
                                                  width: 2,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: errorColor,
                                                  width: 2,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: backgroundColor,
                                              contentPadding:
                                                  const EdgeInsets.all(24),
                                            ),
                                            debounceTime:
                                                800, // default 600 ms,
                                            countries: const [
                                              "it",
                                              "fr"
                                            ], // optional by default null is set
                                            isLatLngRequired:
                                                true, // if you required coordinates from place detail
                                            getPlaceDetailWithLatLng:
                                                (Prediction prediction) async {
                                              // this method will return latlng with place detail

                                              if (prediction.lng != null &&
                                                  prediction.lat != null) {
                                                selLocation = LatLng(
                                                    double.parse(prediction.lat
                                                        .toString()),
                                                    double.parse(prediction.lng
                                                        .toString()));
                                                var address = await GeoCoder()
                                                    .getAddressFromLatLng(
                                                        latitude: selLocation
                                                            .latitude,
                                                        longitude: selLocation
                                                            .longitude);
                                                //qui accedo ad address e prendo i dettagli che mi servono

                                                city =
                                                    address.addressDetails.city;
                                              }
                                            }, // this callback is called when isLatLngRequired is true

                                            itemClick: (Prediction prediction) {
                                              controller.text =
                                                  prediction.description!;
                                              controller.selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset: prediction
                                                              .description!
                                                              .length));
                                            },
                                            // if we want to make custom list item builder
                                            itemBuilder: (context, index,
                                                Prediction prediction) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.location_on),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    Expanded(
                                                        child: Text(prediction
                                                                .description ??
                                                            ""))
                                                  ],
                                                ),
                                              );
                                            },
                                            // if you want to add seperator between list items
                                            seperatedBuilder: const Divider(),
                                            // want to show close icon
                                            isCrossBtnShown: true,
                                            // optional container padding
                                            //containerHorizontalPadding: 10,
                                          )),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Choose the type',
                                              textAlign: TextAlign.center,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFF101213),
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      const CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  unselectedWidgetColor:
                                                      Colors.black,
                                                ),
                                                child: CheckboxListTile(
                                                  value: checkboxListTileValue1,
                                                  onChanged: (newValue) async {
                                                    setState(() =>
                                                        checkboxListTileValue1 =
                                                            newValue!);
                                                  },
                                                  title: Text(
                                                    typeOfAppartament[0],
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      color: const Color(
                                                          0xFF101213),
                                                      fontSize: size16(context),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  tileColor: backgroundColor,
                                                  activeColor:
                                                      const Color(0xFFE0E3E7),
                                                  checkColor: mainColor,
                                                  dense: false,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing,
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      const CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  unselectedWidgetColor:
                                                      Colors.black,
                                                ),
                                                child: CheckboxListTile(
                                                  value: checkboxListTileValue2,
                                                  onChanged: (newValue) async {
                                                    setState(() =>
                                                        checkboxListTileValue2 =
                                                            newValue!);
                                                  },
                                                  title: Text(
                                                    typeOfAppartament[1],
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      color: const Color(
                                                          0xFF101213),
                                                      fontSize: size16(context),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  tileColor: backgroundColor,
                                                  activeColor:
                                                      const Color(0xFFE0E3E7),
                                                  checkColor: mainColor,
                                                  dense: false,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing,
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      const CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  unselectedWidgetColor:
                                                      Colors.black,
                                                ),
                                                child: CheckboxListTile(
                                                  value: checkboxListTileValue3,
                                                  onChanged: (newValue) async {
                                                    setState(() =>
                                                        checkboxListTileValue3 =
                                                            newValue!);
                                                  },
                                                  title: Text(
                                                    typeOfAppartament[2],
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      color: const Color(
                                                          0xFF101213),
                                                      fontSize: size16(context),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  tileColor: backgroundColor,
                                                  activeColor:
                                                      const Color(0xFFE0E3E7),
                                                  checkColor: mainColor,
                                                  dense: false,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing,
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Theme(
                                                data: ThemeData(
                                                  checkboxTheme:
                                                      const CheckboxThemeData(
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                  ),
                                                  unselectedWidgetColor:
                                                      Colors.black,
                                                ),
                                                child: CheckboxListTile(
                                                  value: checkboxListTileValue4,
                                                  onChanged: (newValue) async {
                                                    setState(() =>
                                                        checkboxListTileValue4 =
                                                            newValue!);
                                                  },
                                                  title: Text(
                                                    typeOfAppartament[3],
                                                    style: GoogleFonts
                                                        .plusJakartaSans(
                                                      color: const Color(
                                                          0xFF101213),
                                                      fontSize: size16(context),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  tileColor: backgroundColor,
                                                  activeColor:
                                                      const Color(0xFFE0E3E7),
                                                  checkColor: mainColor,
                                                  dense: false,
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing,
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 16),
                                                child: Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        const CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                    ),
                                                    unselectedWidgetColor:
                                                        Colors.black,
                                                  ),
                                                  child: CheckboxListTile(
                                                    value:
                                                        checkboxListTileValue5,
                                                    onChanged:
                                                        (newValue) async {
                                                      setState(() =>
                                                          checkboxListTileValue5 =
                                                              newValue!);
                                                    },
                                                    title: Text(
                                                      typeOfAppartament[4],
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                        color: const Color(
                                                            0xFF101213),
                                                        fontSize:
                                                            size16(context),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    tileColor: backgroundColor,
                                                    activeColor:
                                                        const Color(0xFFE0E3E7),
                                                    checkColor: mainColor,
                                                    dense: false,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .trailing,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Your budget is',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: const Color(0xFF101213),
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ]),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 16),
                                              child: SliderTheme(
                                                data: const SliderThemeData(
                                                  showValueIndicator:
                                                      ShowValueIndicator.always,
                                                ),
                                                child: Slider(
                                                  activeColor: mainColor,
                                                  inactiveColor:
                                                      const Color.fromARGB(
                                                          255, 199, 197, 197),
                                                  divisions: 50,
                                                  min: 0,
                                                  max: 4000,
                                                  value: sliderValue,
                                                  label: sliderValue.toString(),
                                                  onChanged: (newValue) {
                                                    newValue = double.parse(
                                                        newValue
                                                            .toStringAsFixed(
                                                                4));
                                                    setState(() =>
                                                        sliderValue = newValue);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment:
                                                  const AlignmentDirectional(
                                                      1, 0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 16),
                                                child: Text(
                                                  sliderValue
                                                      .round()
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color:
                                                        const Color(0xFF57636C),
                                                    fontSize: size12(context),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 0, 0, 16),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (scaffoldKey.currentState!
                                                  .validate()) {
                                                if (checkboxListTileValue1 ||
                                                    checkboxListTileValue2 ||
                                                    checkboxListTileValue3 ||
                                                    checkboxListTileValue4 ||
                                                    checkboxListTileValue5) {
                                                  await DatabaseServiceFilters(
                                                          user.uid)
                                                      .updateFiltersAdj(
                                                          city ?? "",
                                                          checkboxListTileValue1,
                                                          checkboxListTileValue2,
                                                          checkboxListTileValue3,
                                                          checkboxListTileValue4,
                                                          checkboxListTileValue5,
                                                          sliderValue);
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'Please, enter at least one type!',
                                                      ),
                                                    ),
                                                  );
                                                  return;
                                                }
                                                if (mounted) {
                                                  Navigator.pop(context);
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(230, 52),
                                              backgroundColor: mainColor,
                                              elevation: 3.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              side: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              'Set your filters!',
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: backgroundColor,
                                                fontSize: size16(context),
                                                fontWeight: FontWeight.w500,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }

  initialCity(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagCity) {
      city = oldFilters.city;
      flagCity = false;
    }
    return city;
  }

  initialBudget(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagBudget) {
      sliderValue = oldFilters.budget!;
      flagBudget = false;
    }
    return sliderValue;
  }

  initialType0(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType0) {
      checkboxListTileValue1 = oldFilters.apartment!;
      flagType0 = false;
    }
    return checkboxListTileValue1;
  }

  initialType1(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType1) {
      checkboxListTileValue2 = oldFilters.singleRoom!;
      flagType1 = false;
    }
    return checkboxListTileValue2;
  }

  initialType2(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType2) {
      checkboxListTileValue3 = oldFilters.doubleRoom!;
      flagType2 = false;
    }
    return checkboxListTileValue3;
  }

  initialType3(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType3) {
      checkboxListTileValue4 = oldFilters.studioApartment!;
      flagType3 = false;
    }
    return checkboxListTileValue4;
  }

  initialType4(FiltersHouseAdj? oldFilters) {
    if (oldFilters != null && flagType4) {
      checkboxListTileValue5 = oldFilters.twoRoomsApartment!;
      flagType4 = false;
    }
    return checkboxListTileValue5;
  }
}
