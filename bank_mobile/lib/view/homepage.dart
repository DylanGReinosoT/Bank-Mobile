import 'package:bank_mobile/controller/usercontroller.dart';
import 'package:bank_mobile/model/transaccion.dart';
import 'package:bank_mobile/model/users.dart';
import 'package:bank_mobile/view/cardspage.dart';
import 'package:bank_mobile/view/pagopage.dart';
import 'package:bank_mobile/view/tranferenciapages.dart';
import 'package:bank_mobile/widgets/transaccion_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;
  final UserApiService api = UserApiService();
  AppUser? currentUser;
  int _selectedIndex = 0;
  List<Widget> _pages = [];


  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      AppUser? apiUser = await api.getUserByUi(user!.uid);
      if (apiUser != null) {
        setState(() {
          currentUser = apiUser;
           _pages = [
            HomeContent(),
            PagosPage(),
            TransferenciasPage(),
            Cardspage(id: currentUser?.id),
          ];
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  sigout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF041A3A),
      appBar: AppBar(
        title: const Text('Banex Digital'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: sigout,
          ),
        ],
      ),
      body: _pages[_selectedIndex],

      /// **Nuevo Menú Inferior Curvo**
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xFF041A3A),
        color: Colors.amber,
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.money, size: 30, color: Colors.black),
          Icon(Icons.sync_alt, size: 30, color: Colors.black),
          Icon(Icons.credit_card, size: 30, color: Colors.black),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final user = FirebaseAuth.instance.currentUser;
  final UserApiService api = UserApiService();
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      AppUser? apiUser = await api.getUserByUi(user!.uid);
      if (apiUser != null) {
        setState(() {
          currentUser = apiUser;
        });
      }
    }
  }

  final List<TransactionItemModel> transactions = [
    TransactionItemModel(
        id: '1',
        title: "Pago de servicios",
        amount: "-\$50.00",
        date: "05 Feb 2025",
        description: "Pago de luz",
        estado: "Pendiente"),
    TransactionItemModel(
        id: '2',
        title: "Depósito recibido",
        amount: "+\$1,200.00",
        date: "04 Feb 2025",
        description: "Depósito de nómina",
        estado: "Completado"),
    TransactionItemModel(
        id: '3',
        title: "Compra en tienda",
        amount: "-\$75.90",
        date: "03 Feb 2025",
        description: "Compra de víveres",
        estado: "Cancelado"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola, ${currentUser?.firstName ?? "Usuario"} 👋',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            color: Colors.amber,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Saldo disponible:',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '\$ ${"0.00"}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Últimas transacciones:',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItemWidget(transaction: transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
