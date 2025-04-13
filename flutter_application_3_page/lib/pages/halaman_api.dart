import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class University {
  final String name;
  final String country;
  final String? website;

  University({required this.name, required this.country, this.website});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      country: json['country'],
      website:
          json['web_pages'] != null && json['web_pages'].isNotEmpty
              ? json['web_pages'][0]
              : null,
    );
  }
}

class HalamanAPI extends StatefulWidget {
  const HalamanAPI({super.key});

  @override
  State<HalamanAPI> createState() => _HalamanAPIState();
}

class _HalamanAPIState extends State<HalamanAPI> {
  List<University> universities = [];
  List<University> filteredUniversities = [];
  bool isLoading = true;
  String searchQuery = '';
  String selectedCountry = 'Indonesia';

  final List<String> countries = ['Indonesia', 'Malaysia', 'India'];

  @override
  void initState() {
    super.initState();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse(
        'http://universities.hipolabs.com/search?country=$selectedCountry',
      ),
    );

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      List<University> data =
          jsonData.map((u) => University.fromJson(u)).toList();

      setState(() {
        universities = data;
        filteredUniversities = data;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredUniversities =
          universities
              .where((u) => u.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  Widget buildUniversityCard(University uni) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              uni.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(uni.country),
            const SizedBox(height: 8),
            if (uni.website != null)
              InkWell(
                onTap: () async {
                  final url = Uri.parse(uni.website!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                },
                child: const Text(
                  'Kunjungi Website',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmer() {
    return GridView.builder(
      itemCount: 6,
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(8),
            child: Container(height: 100),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Universitas'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Cari universitas',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: filterSearch,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: selectedCountry,
              decoration: const InputDecoration(
                labelText: 'Pilih Negara',
                border: OutlineInputBorder(),
              ),
              items:
                  countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
              onChanged: (String? newCountry) {
                if (newCountry != null) {
                  setState(() {
                    selectedCountry = newCountry;
                  });
                  fetchUniversities();
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child:
                isLoading
                    ? buildShimmer()
                    : GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: filteredUniversities.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                      itemBuilder: (context, index) {
                        return buildUniversityCard(filteredUniversities[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
