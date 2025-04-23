import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velaris/UI/views/profile/profile_view.dart';
import 'package:velaris/UI/views/search_user/search_user_controller.dart';
import '../../../model/entity/dream_user.dart';
import '../../widgets/navbar.dart';
import '../../widgets/user_profile_picture.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
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
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: kToolbarHeight + 24),
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
                      // Input de búsqueda
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
                                  searchQuery = value.trim();
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
                      // Resultados
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
                                      'Aquí aparecerán los usuarios que busques.\n¡Prueba a buscar alguno!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                                : dreamUserList.isEmpty
                                ? Center(
                                  child: Text(
                                    '¿Ya estás mezclando los sueños lúcidos con la realidad? No hemos encontrado ningún usuario con ese nombre.',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                )
                                : ListView.separated(
                                  itemCount: dreamUserList.length,
                                  separatorBuilder:
                                      (_, __) => const SizedBox(height: 16),
                                  itemBuilder: (context, index) {
                                    DreamUser user = dreamUserList[index];
                                    String nickname = user.nickname ?? "-";

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => ProfileView(
                                                  dreamUser: user,
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF3E2D66),
                                          // fondo morado oscuro
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.25,
                                              ),
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 24,
                                              backgroundColor:
                                                  Colors.grey.shade400,
                                              backgroundImage:
                                                  user.profilePicture != null
                                                      ? NetworkImage(
                                                        user.profilePicture!,
                                                      )
                                                      : null,
                                              child:
                                                  user.profilePicture == null
                                                      ? const Icon(
                                                        Icons.person,
                                                        color: Colors.white,
                                                      )
                                                      : null,
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  nickname,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                            if (loading)
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.black.withAlpha(150),
                                child: Center(
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
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
