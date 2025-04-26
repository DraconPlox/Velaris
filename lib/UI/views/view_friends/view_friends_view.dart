import 'package:flutter/material.dart';
import 'package:velaris/UI/views/view_friends/view_friends_controller.dart';
import 'package:velaris/model/entity/dream_user.dart';

import '../../../model/entity/dream_user.dart';
import '../../widgets/user_card.dart';
import '../profile/profile_view.dart';

class ViewFriends extends StatefulWidget {
  const ViewFriends({Key? key}) : super(key: key);

  @override
  State<ViewFriends> createState() => _ViewFriendsState();
}

class _ViewFriendsState extends State<ViewFriends> {
  ViewFriendsController viewFriendsController = ViewFriendsController();
  bool showFriends = true;
  bool requestPending = false;
  DreamUser? user;
  List<DreamUser>? listaAmigos;
  List<DreamUser>? listaSender;
  List<DreamUser>? listaReceive;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    await viewFriendsController.initialize();
    user = viewFriendsController.getUser();
    if (user?.friends?.isEmpty??true) {
      listaAmigos = [];
    } else {
      listaAmigos = await viewFriendsController.getFriends(user?.friends ?? []);
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
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      showFriends
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
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      !showFriends
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      showFriends
                          ? Expanded(
                            child: ListView.separated(
                              itemCount: listaAmigos?.length ?? 0,
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                // Preparado para cuando tengas los datos
                                DreamUser user = listaAmigos![index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                ProfileView(dreamUser: user),
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
                                      user: user,
                                      showButtons: requestPending,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                          : Expanded(
                            child: Column(
                              children: [
                                for (int i = 0; i < (listaReceive?.length??0); i++)
                                  GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                ProfileView(dreamUser: user),
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
                                      user: listaReceive![i],
                                      showButtons: requestPending,
                                      onAccept: () async {
                                        if (await viewFriendsController.acceptRequest(listaReceive?[i].id??"")) {
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
                                        await viewFriendsController.declineRequest(listaReceive?[i].id??"");
                                      },
                                    ),
                                  ),
                                ),
                                for (int i = 0; i < (listaSender?.length??0); i++)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                              ProfileView(dreamUser: user),
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
                                        user: listaSender![i],
                                        showButtons: false,
                                      ),
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
    );
  }
}
