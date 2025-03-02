import 'package:flutter/material.dart';
import 'database.dart';
// import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _filmes = [];

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  Future<void> _carregarFilmes() async {
    final data = await DatabaseHelper().getFilmes();
    setState(() {
      _filmes = data;
    });
  }

  // void _navegarParaCadastro() async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => CadastroScreen()),
  //   );
  //   _carregarFilmes();
  // }

  // void _editarFilme(int id) async {
  //   final filme = _filmes.firstWhere((filme) => filme['id'] == id);
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => CadastroScreen(filme: filme),
  //     ),
  //   );
  //   _carregarFilmes();
  // }

  void _removerFilme(int id) async {
    await DatabaseHelper().deleteFilme(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Filme removido com sucesso!')),
    );
    _carregarFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Filmes'),
      ),
      body: ListView.builder(
        itemCount: _filmes.length,
        itemBuilder: (context, index) {
          final filme = _filmes[index];
          return ListTile(
            title: Text(filme['titulo']),
            subtitle: Text('${filme['ano']} - ${filme['direcao']}'),
            // onTap: () => _editarFilme(filme['id']),
            onLongPress: () => _removerFilme(filme['id']),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _navegarParaCadastro,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}