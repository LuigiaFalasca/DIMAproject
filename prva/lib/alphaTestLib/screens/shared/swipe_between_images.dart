import 'package:flutter/material.dart';

class SwipeWidget extends StatelessWidget {
  final String image;
  final String firstName;
  final String lastName;
  late final double? price;
  late final int? age;

  SwipeWidget(
      {super.key,
      required this.image,
      required this.firstName,
      required this.lastName,
      this.price,
      this.age});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.15,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$firstName $lastName',
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      child: Text(
                        price?.toString() ?? age.toString(),
                        style: const TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ),
          ))
    ]);
  }
}
