import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final valorController = TextEditingController();
  final jurosController = TextEditingController();
  final parcelasController = TextEditingController();
  final taxasController = TextEditingController();

  double total = 0;
  double parcela = 0;

  InputDecoration campo(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void calcular() {
    double valor = double.tryParse(valorController.text) ?? 0;
    double juros = (double.tryParse(jurosController.text) ?? 0) / 100;
    int parcelas = int.tryParse(parcelasController.text) ?? 1;
    double taxas = double.tryParse(taxasController.text) ?? 0;

    double montante = valor * (1 + juros * parcelas) + taxas;

    setState(() {
      total = montante;
      parcela = montante / parcelas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Financiamento"),
          backgroundColor: Colors.brown,
        ),
        body: Container(
          color: Colors.brown.shade50,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Color.fromARGB(31, 0, 0, 0), blurRadius: 8),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: valorController,
                    decoration: campo("Valor"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: jurosController,
                    decoration: campo("Juros (%)"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: parcelasController,
                    decoration: campo("Parcelas"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: taxasController,
                    decoration: campo("Taxas"),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: calcular,
                    child: const Text("Calcular"),
                  ),

                  const SizedBox(height: 20),

                  Text("Total: R\$ ${total.toStringAsFixed(2)}"),
                  Text("Parcela: R\$ ${parcela.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
