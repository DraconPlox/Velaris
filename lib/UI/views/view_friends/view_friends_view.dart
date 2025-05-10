import 'package:flutter/material.dart';
import 'package:velaris/UI/views/view_friends/view_friends_controller.dart';
import 'package:velaris/model/entity/dream_user.dart';
import '../../widgets/navbar.dart';
import '../../widgets/user_card.dart';
import '../profile/profile_view.dart';

class ViewFriendsView extends StatefulWidget {
  const ViewFriendsView({Key? key}) : super(key: key);

  @override
  State<ViewFriendsView> createState() => _ViewFriendsViewState();
}

class _ViewFriendsViewState extends State<ViewFriendsView> {
  ViewFriendsController viewFriendsController = ViewFriendsController();
  bool showFriends = true;
  int listaUsers = 1;
  bool requestPending = false;
  bool hasBloq = false;
  DreamUser? user;
  List<DreamUser>? listaAmigos;
  List<DreamUser>? listaSender;
  List<DreamUser>? listaReceive;
  List<DreamUser>? listaBloqueados;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    await viewFriendsController.initialize();
    user = viewFriendsController.getUser();
    if (user?.friends?.isEmpty ?? true) {
      listaAmigos = [];
    } else {
      listaAmigos = await viewFriendsController.getFriends(user?.friends ?? []);
    }
    if (user?.blocked?.isEmpty ?? true) {
      listaBloqueados = [];
    } else {
      listaBloqueados = await viewFriendsController.getUsersBlocked(user?.blocked ?? []);
    }
    listaSender = await viewFriendsController.getRequestsSender();
    listaReceive = await viewFriendsController.getRequestsReceive();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1033),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Amistades',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: Navbar(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                showFriends = true;
                                requestPending = false;
                                hasBloq = false;
                                listaUsers = 1;
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      listaUsers == 1
                                          ? const Color(0xFF5E4AA5)
                                          : const Color(0xFF3E2D66),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Amigos',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                showFriends = false;
                                requestPending = true;
                                hasBloq = false;
                                listaUsers = 2;
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      listaUsers == 2
                                          ? const Color(0xFF5E4AA5)
                                          : const Color(0xFF3E2D66),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Pendientes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                showFriends = false;
                                requestPending = false;
                                hasBloq = true;
                                listaUsers = 3;
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      listaUsers == 3
                                          ? const Color(0xFF5E4AA5)
                                          : const Color(0xFF3E2D66),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Bloqueados',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      listaUsers == 1
                          ? Expanded(
                            child: ListView.separated(
                              itemCount: listaAmigos?.length ?? 0,
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProfileView(
                                              dreamUser: listaAmigos![index],
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
                                      color: const Color(0xFF3E2D66),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: UserCard(
                                      user: listaAmigos![index],
                                      showButtons: requestPending,
                                      hasBloq: hasBloq,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          : listaUsers == 2
                          ? Expanded(
                            child: Column(
                              children: [
                                for (int i = 0; i < (listaReceive?.length ?? 0); i++)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ProfileView(
                                                dreamUser: listaReceive![i],
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
                                        color: const Color(0xFF3E2D66),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.25,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: UserCard(
                                        user: listaReceive![i],
                                        showButtons: requestPending,
                                        hasBloq: hasBloq,
                                        onAccept: () async {
                                          if (await viewFriendsController
                                              .acceptRequest(listaReceive?[i].id ?? "", user?.nickname ?? "")) {
                                            initialize();
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Ha habido un problema a la hora de aceptar la solicitud',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        onCancel: () async {
                                          await viewFriendsController
                                              .declineRequest(
                                                listaReceive?[i].id ?? "",
                                              );
                                        },
                                      ),
                                    ),
                                  ),
                                for (int i = 0; i < (listaSender?.length ?? 0); i++)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ProfileView(
                                                dreamUser: listaSender![i],
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
                                        color: const Color(0xFF3E2D66),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.25,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: UserCard(
                                        user: listaSender![i],
                                        showButtons: false,
                                        hasBloq: hasBloq,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                          : Expanded(
                            child: ListView.separated(
                              itemCount: listaBloqueados?.length ?? 0,
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //No hace nada al estar bloqueado.
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
                                      color: const Color(0xFF3E2D66),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: UserCard(
                                      user: listaBloqueados![index],
                                      showButtons: requestPending,
                                      hasBloq: hasBloq,
                                      onDesbloq: () async {
                                        if (await viewFriendsController
                                            .desbloqUser(
                                          listaBloqueados?[index].id ?? "",
                                        )) initialize();
                                      },
                                    ),
                                  ),
                                );
                              },
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
    );
  }
}
