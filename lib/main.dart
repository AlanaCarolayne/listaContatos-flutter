import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Contatos> contatos = [
    Contatos('Eva', 'eva@email.com'),
    Contatos('Ana', 'ana@email.com'),
  ];

  @override
  Widget build(BuildContext context) {
    const title = 'Contatos';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contatos[index].nome),
            subtitle: Text(contatos[index].email),
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, color: Colors.white),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novoContato = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ContatoForm()),
          );
          if (novoContato != null && novoContato is Contatos) {
            setState(() {
              contatos.add(novoContato);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class Contatos {
  String nome;
  String email;

  Contatos(this.nome, this.email);
}

class ContatoForm extends StatefulWidget {
  const ContatoForm({super.key});

  @override
  _AddContato createState() => _AddContato();
}

class _AddContato extends State<ContatoForm> {
  String nome = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adicionar Contato',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome'),
              onChanged: (value) {
                nome = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                email = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nome.isNotEmpty && email.isNotEmpty) {
                  final novoContato = Contatos(nome, email);
                  Navigator.pop(context, novoContato);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
              child: const Text('Salvar', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
