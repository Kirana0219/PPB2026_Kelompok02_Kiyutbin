import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  final List<Map<String, dynamic>> bankSampah = const [
    {
      "nama": "Bank Sampah Renon",
      "alamat": "Jl. Raya Puputan, Renon, Denpasar",
      "lokasi": LatLng(-8.6705, 115.2126),
    },
    {
      "nama": "Bank Sampah Sanur",
      "alamat": "Jl. Danau Tamblingan, Sanur",
      "lokasi": LatLng(-8.6905, 115.2636),
    },
    {
      "nama": "Bank Sampah Ubung",
      "alamat": "Jl. Cokroaminoto, Ubung, Denpasar",
      "lokasi": LatLng(-8.6355, 115.2085),
    },
    {
      "nama": "Bank Sampah Monang Maning",
      "alamat": "Jl. Gunung Salak, Denpasar",
      "lokasi": LatLng(-8.6588, 115.1938),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F8),

      appBar: AppBar(
        title: const Text("Lokasi Bank Sampah"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: Column(
        children: [

          /// Search Bar
            Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                    BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    ),
                ],
                ),

                child: TextField(
                decoration: InputDecoration(
                    hintText: "Cari lokasi bank sampah...",

                    hintStyle: const TextStyle(
                    color: Colors.grey,
                    ),

                    prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.green,
                    ),

                    border: InputBorder.none,

                    contentPadding:
                        const EdgeInsets.symmetric(
                        vertical: 16,
                        ),
                ),
                ),
            ),
            ),


          /// Map
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(-8.6705, 115.2126),
                    initialZoom: 13,
                  ),

                  children: [

                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName:
                          "com.example.kiyutbin",
                    ),


                    MarkerLayer(
                      markers: bankSampah.map((data) {

                        return Marker(
                          point: data["lokasi"],
                          width: 60,
                          height: 60,

                          child: GestureDetector(
                            onTap: () {

                              showDialog(
                                context: context,
                                builder: (context) {

                                  return AlertDialog(
                                    title: Text(
                                      data["nama"],
                                    ),

                                    content: Text(
                                      data["alamat"],
                                    ),

                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                            const Text("Tutup"),
                                      )
                                    ],
                                  );
                                },
                              );

                            },

                            child: const Icon(
                              Icons.location_on,
                              color: Colors.green,
                              size: 40,
                            ),
                          ),
                        );

                      }).toList(),
                    ),

                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}