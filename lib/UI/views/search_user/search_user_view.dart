import 'package:flutter/material.dart';
import 'package:velaris/UI/views/profile/profile_view.dart';
import 'package:velaris/UI/views/search_user/search_user_controller.dart';
import '../../../model/entity/dream_user.dart';
import '../../widgets/navbar.dart';
import '../../widgets/user_card.dart';

class SearchUserView extends StatefulWidget {
  const SearchUserView({super.key});

  @override
  State<SearchUserView> createState() => _SearchUserViewState();
}

class _SearchUserViewState extends State<SearchUserView> {
  final TextEditingController _controller = TextEditingController();
  SearchUserController searchUserController = SearchUserController();
  List<DreamUser> dreamUserList = [];
  String searchQuery = "";
  bool loading = false;
  DreamUser? dreamUser;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    await searchUserController.initialize();
    dreamUser = searchUserController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E3657),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Buscar usuario',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            bottom: 400,
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D2643),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Nombre',
                                    hintStyle: TextStyle(color: Colors.white38),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) async {
                                    searchQuery = value.trim();
                                    loading = true;
                                    setState(() {});
                                    dreamUserList = await searchUserController
                                        .searchUsers(searchQuery);
                                    loading = false;
                                    setState(() {});
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Stack(
                            children: [
                              searchQuery.isEmpty
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        'Aqui apareceran los usuarios que busques.\n¡Prueba a buscar alguno!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                  : dreamUserList.isEmpty
                                  ? Center(
                                    child: Text(
                                      '¿Ya estas mezclando los sueños lucidos con la realidad? No hemos encontrado ningun usuario con ese nombre.',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  )
                                  : ListView(
                                    children: [
                                      for (int i = 0; i < dreamUserList.length; i++)
                                        if (dreamUser?.blocked != null)
                                          if (() {
                                            final currentUser = dreamUser!;
                                            final isSameUser = dreamUserList[i].id == currentUser.id;
                                            final isBlocked = currentUser.blocked!.contains(dreamUserList[i].id);
                                            final yourBlocked = dreamUserList[i].blocked?.contains(currentUser.id);
                                            return !(isSameUser || isBlocked || yourBlocked!);
                                          }()) ...[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) => ProfileView(
                                                          dreamUser:
                                                              dreamUserList[i],
                                                        ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF3E2D66),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      blurRadius: 8,
                                                      offset: const Offset(0, 4),
                                                    ),
                                                  ],
                                                ),
                                                child: UserCard(
                                                  user: dreamUserList[i],
                                                  showButtons: false,
                                                  hasBloq: false,
                                                ),
                                              ),
                                            ),
                                            if (i < dreamUserList.length - 1)
                                              const SizedBox(height: 16),
                                          ],
                                    ],
                                  ),
                              if (loading)
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.black.withAlpha(150),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
