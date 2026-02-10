import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();
  final TextEditingController _stepController = TextEditingController(text: "1");

  Color _getLogColor(String log) {
    if (log.contains("Tambah")) return Colors.green;
    if (log.contains("Kurang")) return Colors.red;
    return Colors.orange;
  }

  void _showResetConfirm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Konfirmasi Reset"),
        content: const Text("Apakah Anda yakin ingin menghapus seluruh hitungan?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              setState(() => _controller.reset());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Riwayat telah di-reset")),
              );
            },
            child: const Text("Ya, Reset", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("LogBook: HomeWork"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Panel Utama Counter
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple[400]!, Colors.deepPurple[700]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "TOTAL HITUNGAN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_controller.value}',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // Input Step
            TextField(
              controller: _stepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nilai Langkah (Step)",
                prefixIcon: const Icon(Icons.bolt, color: Colors.deepPurple),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                int inputStep = int.tryParse(value) ?? 1;
                _controller.setStep(inputStep);
              },
            ),
            const SizedBox(height: 30),

            // Section Riwayat
            Row(
              children: const [
                Icon(Icons.history, color: Colors.deepPurple),
                SizedBox(width: 10),
                Text(
                  "5 AKTIVITAS TERAKHIR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(),
            
            // List Riwayat dengan Empty State
            _controller.history.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Icon(Icons.inbox_outlined, size: 60, color: Colors.grey[300]),
                        const SizedBox(height: 10),
                        Text(
                          "Belum ada aktivitas",
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: _controller.history
                        .map((log) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: Icon(Icons.info_outline, color: _getLogColor(log)),
                                title: Text(
                                  log,
                                  style: TextStyle(
                                    color: _getLogColor(log),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                dense: true,
                              ),
                            ))
                        .toList(),
                  ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: _showResetConfirm,
            backgroundColor: Colors.orange,
            heroTag: "btnReset",
            tooltip: "Reset Hitungan",
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () => setState(() => _controller.decrement()),
            backgroundColor: Colors.redAccent,
            heroTag: "btnSub",
            tooltip: "Kurangi",
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 12),
          FloatingActionButton(
            onPressed: () => setState(() => _controller.increment()),
            backgroundColor: Colors.green,
            heroTag: "btnAdd",
            tooltip: "Tambah",
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}