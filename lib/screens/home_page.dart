import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/approval_status_widget.dart';
import 'package:flutter_assignment/components/bid_now_widget.dart';
import 'package:flutter_assignment/components/eligibility_widget.dart';
import 'package:flutter_assignment/components/move_button.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic> responseData;

  List<String> images = [
    'assets/benz1.jpg',
    'assets/benz2.jpg',
    'assets/benz3.jpg',
    'assets/benz4.jpg',
    'assets/benz5.jpg',
    'assets/benz6.jpg'
  ];
  Future<String> getToken() async {
    final response = await http.post(
      Uri.parse(
          'http://35.200.130.147/api/method/library_management.signin.login'),
      body: jsonEncode(
          <String, String>{"usr": "testuser5@gmail.com", "pwd": "Test@123"}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String apiKey = data['api_key'];
      String apiSecret = data['api_secret'];
      String token = 'token $apiKey:$apiSecret';

      return token;
    } else {
      throw Exception('Failed to get token');
    }
  }

  Future getData() async {
    String token = await getToken();

    // print('token is: $token');
    var response = await http.get(
      Uri.parse('http://35.200.130.147/api/resource/Item/Bharat-Benz-V9000'),
      headers: {
        // 'Authorization': 'token c7085e41d563ed2:e941085376602db',
        'Authorization': token,
      },
    );
    responseData = jsonDecode(response.body);
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  int imageIndex = 0;
  double scrollPosition = 500;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    getData();
    DateTime timestamp = DateTime.parse(
      responseData['data']['creation'],
    );
    int year = timestamp.year;
    String formattedYear = year.toString();
    String insuranceValidity =
        responseData['data']['custom_insurance_validity'];
    DateTime givenDate = DateTime.parse(insuranceValidity);
    int biddingCommitment =
        responseData['data']['custom_commitment_amount'].toInt();
    int gvw = responseData['data']['custom_gvw_in_tons'].toInt();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                responseData['data']['name'] ?? 'error',
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue.shade300,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    responseData['data']['custom_state'],
                    style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '₹32.6L - 40.2L',
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'In very good condition, Less kms travelled. This the description of the vehicle entered by the seller.',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    images[imageIndex],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: ListView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(images[index]),
                              )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      moveButton(
                        icon: Icons.chevron_left,
                        onTap: () {
                          setState(() {
                            if (imageIndex > 0) {
                              imageIndex--;
                              scrollPosition++;
                              scrollController.animateTo(scrollPosition,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            }
                          });
                        },
                      ),
                      moveButton(
                        icon: Icons.chevron_right,
                        onTap: () {
                          setState(() {
                            if (imageIndex < images.length - 1) {
                              imageIndex++;
                              scrollPosition--;
                              scrollController.animateTo(scrollPosition,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                              scrollController.jumpTo(4);
                            } else {
                              imageIndex = 0;
                              scrollPosition = -500;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Year',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          formattedYear,
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kms Driven',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          responseData['data']['custom_odometer_reading_in_km']
                              .toInt()
                              .toString(),
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GVW',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${gvw}kgs',
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ApprovalStatusWidget(
                title: 'Insurance: ',
                body: isToday(givenDate) ? 'Yes' : 'No',
              ),
              const SizedBox(
                height: 10,
              ),
              ApprovalStatusWidget(
                title: 'Permit: ',
                body: responseData['data']['custom_permit_type'],
              ),
              const SizedBox(
                height: 10,
              ),
              ApprovalStatusWidget(
                  title: 'Fitness: ',
                  body: responseData['data']['custom_fitness_certificate']),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.shade100,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 5.0,
                      offset:
                          const Offset(0.0, -5.0), // Offset the shadow upwards
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: const BidNowWidget(),
              ),
              const SizedBox(
                height: 10,
              ),
              EligibilityWidget(
                title: responseData['data']['custom_bidding_eligibility'],
                image: Image.asset(
                  'assets/verified.png',
                  height: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              EligibilityWidget(
                  title:
                      '$biddingCommitment Bidding commitement amount payable',
                  image: Container(
                    padding: const EdgeInsets.all(5),
                    height: 20,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: Image.asset(
                      'assets/rupee.png',
                      height: 15,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
