import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui/manage_address/view_model/manage_address_view_model.dart';
import 'package:provider/provider.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  late TextEditingController cepController;
  late TextEditingController streetController;
  late TextEditingController numberController;
  late TextEditingController complementController;
  late TextEditingController neighborhoodController;
  late TextEditingController cityController;
  late TextEditingController stateController;

  @override
  void initState() {
    super.initState();

    final vm = context.read<ManageAddressViewModel>();

    cepController = TextEditingController(text: vm.cep);
    streetController = TextEditingController(text: vm.street);
    numberController = TextEditingController(text: vm.number);
    complementController = TextEditingController(text: vm.complement);
    neighborhoodController = TextEditingController(text: vm.neighborhood);
    cityController = TextEditingController(text: vm.city);
    stateController = TextEditingController(text: vm.state);

    vm.loadAddressFromUser().then((_) {
      cepController.text = vm.cep ?? '';
      streetController.text = vm.street ?? '';
      numberController.text = vm.number ?? '';
      complementController.text = vm.complement ?? '';
      neighborhoodController.text = vm.neighborhood ?? '';
      cityController.text = vm.city ?? '';
      stateController.text = vm.state ?? '';
    });

    cepController.addListener(() {
      vm.cep = cepController.text;
    });
    numberController.addListener(() {
      vm.updateNumber(numberController.text);
    });
    complementController.addListener(() {
      vm.updateComplement(complementController.text);
    });
    streetController.addListener(() {
      vm.updateStreet(streetController.text);
    });
    neighborhoodController.addListener(() {
      vm.updateNeighborhood(neighborhoodController.text);
    });
    cityController.addListener(() {
      vm.updateCity(cityController.text);
    });
    stateController.addListener(() {
      vm.updateState(stateController.text);
    });
  }

  @override
  void dispose() {
    cepController.dispose();
    streetController.dispose();
    numberController.dispose();
    complementController.dispose();
    neighborhoodController.dispose();
    cityController.dispose();
    stateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ManageAddressViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Endereço'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: cepController,
                              decoration: const InputDecoration(
                                labelText: 'CEP',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              if (cepController.text.isNotEmpty) {
                                vm.fetchAddressByCep(cepController.text).then((
                                  _,
                                ) {
                                  setState(() {
                                    cepController.text =
                                        vm.cep ?? cepController.text;
                                    streetController.text = vm.street ?? '';
                                    numberController.text = vm.number ?? '';
                                    complementController.text =
                                        vm.complement ?? '';
                                    neighborhoodController.text =
                                        vm.neighborhood ?? '';
                                    cityController.text = vm.city ?? '';
                                    stateController.text = vm.state ?? '';
                                  });
                                });
                              }
                            },
                            icon: const Icon(Icons.search),
                            tooltip: 'Buscar CEP',
                          ),
                        ],
                      ),
                      if (vm.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            vm.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: streetController,
                        decoration: const InputDecoration(labelText: 'Rua'),
                      ),
                      TextFormField(
                        controller: numberController,
                        decoration: const InputDecoration(labelText: 'Número'),
                      ),
                      TextFormField(
                        controller: complementController,
                        decoration: const InputDecoration(
                          labelText: 'Complemento',
                        ),
                      ),
                      TextFormField(
                        controller: neighborhoodController,
                        decoration: const InputDecoration(labelText: 'Bairro'),
                      ),
                      TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(labelText: 'Cidade'),
                      ),
                      TextFormField(
                        controller: stateController,
                        decoration: const InputDecoration(labelText: 'Estado'),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          final success = await vm.saveAddress();
                          if (success) {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Endereço salvo!')),
                            );
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  vm.errorMessage ?? 'Erro desconhecido',
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Salvar Endereço'),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
