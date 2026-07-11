import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/layout/widgets/app_header.dart';
import '../../../core/routes/app_router.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> bankSampah = const [
    {
      'nama': 'Bank Sampah Renon',
      'alamat': 'Jl. Raya Puputan, Renon, Denpasar',
      'lokasi': LatLng(-8.6705, 115.2126),
    },
    {
      'nama': 'Bank Sampah Sanur',
      'alamat': 'Jl. Danau Tamblingan, Sanur',
      'lokasi': LatLng(-8.6905, 115.2636),
    },
    {
      'nama': 'Bank Sampah Ubung',
      'alamat': 'Jl. Cokroaminoto, Ubung, Denpasar',
      'lokasi': LatLng(-8.6355, 115.2085),
    },
    {
      'nama': 'Bank Sampah Monang Maning',
      'alamat': 'Jl. Gunung Salak, Denpasar',
      'lokasi': LatLng(-8.6588, 115.1938),
    },
  ];

  String _keyword = '';

  List<Map<String, dynamic>> get _searchResults {
    final keyword = _keyword.trim().toLowerCase();
    if (keyword.isEmpty) return const [];

    return bankSampah.where((location) {
      final name = location['nama'] as String;
      final address = location['alamat'] as String;
      return name.toLowerCase().contains(keyword) ||
          address.toLowerCase().contains(keyword);
    }).toList();
  }

  void _focusLocation(Map<String, dynamic> location) {
    final point = location['lokasi'] as LatLng;
    _mapController.move(point, 16);
    FocusScope.of(context).unfocus();

    setState(() {
      _searchController.text = location['nama'] as String;
      _keyword = _searchController.text;
    });
  }

  void _search() {
    if (_searchResults.isNotEmpty) {
      _focusLocation(_searchResults.first);
    }
  }

  void _showLocationDetail(Map<String, dynamic> location) {
    final name = location['nama'] as String;
    final address = location['alamat'] as String;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(name),
        content: Text(address),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = _searchResults;

    return Scaffold(
      appBar: AppHeader(
        showBackButton: true,
        onNotification: () {
          Navigator.pushNamed(context, AppRouter.notification);
        },
        onProfile: () {
          Navigator.pushNamed(context, AppRouter.profile);
        },
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(-8.6705, 115.2126),
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.kiyutbin',
              ),
              MarkerLayer(
                markers: bankSampah.map((location) {
                  return Marker(
                    point: location['lokasi'] as LatLng,
                    width: 60,
                    height: 60,
                    child: GestureDetector(
                      onTap: () => _showLocationDetail(location),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 44,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  elevation: 3,
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) => setState(() {
                      _keyword = value;
                    }),
                    onSubmitted: (_) => _search(),
                    decoration: InputDecoration(
                      hintText: 'Cari bank sampah...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      prefixIcon: const Icon(Icons.search, color: Colors.green),
                      suffixIcon: IconButton(
                        onPressed: _search,
                        icon: const Icon(Icons.arrow_forward),
                        tooltip: 'Cari lokasi',
                      ),
                    ),
                  ),
                ),
                if (_keyword.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    elevation: 3,
                    child: searchResults.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Lokasi tidak ditemukan.'),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: searchResults.length,
                            separatorBuilder: (_, _) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final location = searchResults[index];
                              return ListTile(
                                leading: const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                title: Text(location['nama'] as String),
                                subtitle: Text(location['alamat'] as String),
                                onTap: () => _focusLocation(location),
                              );
                            },
                          ),
                  ),
                ],
                const Spacer(),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  elevation: 3,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Pilih marker untuk melihat detail'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
