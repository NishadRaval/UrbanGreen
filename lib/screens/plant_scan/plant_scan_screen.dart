import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/plant_ai_service.dart';
import 'dart:io';

class PlantScanScreen extends ConsumerStatefulWidget {
  const PlantScanScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PlantScanScreen> createState() => _PlantScanScreenState();
}

class _PlantScanScreenState extends ConsumerState<PlantScanScreen> {
  File? _image;
  PlantAiResult? _result;
  bool _isScanning = false;

  void _scanMockImage() async {
    setState(() {
      _isScanning = true;
      _result = null;
    });

    final aiService = ref.read(plantAiServiceProvider);
    
    // Simulating capturing an image
    // You would use `image_picker` here to get a File
    
    final res = await aiService.identifyPlant(File('')); // Mock file
    
    if (mounted) {
      setState(() {
        _isScanning = false;
        _result = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Identify Plant')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: _isScanning 
                  ? const Center(child: CircularProgressIndicator())
                  : _result != null 
                    ? _buildResultView()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 80, color: Colors.green.shade200),
                          const SizedBox(height: 16),
                          Text('Take a photo to identify a plant', style: TextStyle(color: Colors.green.shade700)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isScanning ? null : _scanMockImage,
              icon: const Icon(Icons.camera),
              label: const Text('Scan Plant (Mock)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 32),
              const SizedBox(width: 12),
              Expanded(child: Text(_result!.label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 16),
          Text(_result!.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          _buildInfoRow(Icons.water_drop, 'Watering', _result!.wateringNeeds),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.wb_sunny, 'Sunlight', _result!.sunlightNeeds),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                // TODO: Add to Garden
              },
              child: const Text('Add to My Garden'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.green.shade700),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(value, style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),
        ),
      ],
    );
  }
}
