import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:projeto_tcc/controller/auth_service.dart';
import 'package:projeto_tcc/models/article.dart';
import 'package:projeto_tcc/pages/home_page/components/card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  String filter = 'title';
  FirebaseAuth firebase = FirebaseAuth.instance;
  String search = '';
  bool descending = true;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    return WillPopScope(
      onWillPop: () {
        return auth.usuario == null ? Future.value(true) : Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/logo1.png'),
            )
          ],
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:
              const Text('Repositório de TCCs do Curso ADS - Campus Ariquemes'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              openFilter(
                context,
              );
            },
            icon: const Icon(Icons.filter_list),
          ),
          actions: [
            if (search.isEmpty) ...[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  openSearch(context);
                },
              ),
            ] else ...[
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () async {
                  setState(() {
                    search = '';
                  });
                },
              ),
            ],
            if (auth.usuario != null) ...[
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/add');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    setState(() {
                      auth.logout();
                    });
                  },
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                ),
              )
            ],
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('articles')
              .orderBy(
                filter,
                descending: descending,
              )
              .snapshots(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            List<Article> articles = snapshot.data!.docs
                .map((doc) => Article.fromDocument(doc))
                .toList();

            articles = articles
                .where(
                  (s) => s.title.toLowerCase().contains(search.toLowerCase()),
                )
                .toList();

            return ListView(
              children: articles.map((document) {
                return RCard(article: document);
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  void setFilter() {
    switch (tabController.index) {
      case 0:
        filter = 'title';
        break;
      case 1:
        filter = 'author';
        break;
      case 2:
        filter = 'year';
        break;
      case 3:
        filter = 'course';
        break;
    }
    setState(() {});
  }

  Future openFilter(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              setFilter();
              Navigator.pop(context);
              setState(() {
                descending = true;
              });
            },
            child: const Text('Filtrar decrescente'),
          ),
          TextButton(
            onPressed: () async {
              setFilter();
              setState(() {
                descending = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Filtrar crescente'),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Escolha com deseja filtrar: ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TabBar(
              controller: tabController,
              labelColor: Colors.black,
              tabs: const [
                Tab(
                  text: 'Título',
                ),
                Tab(
                  text: 'Autor',
                ),
                Tab(
                  text: 'Ano',
                ),
                Tab(
                  text: 'Curso',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future openSearch(
    BuildContext context,
  ) async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {
                search = controller.text;
              });
            },
            child: const Text('Pesquisar'),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informe o que deseja pesquisar: ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            TextField(
              controller: controller,
            )
          ],
        ),
      ),
    );
  }
}
