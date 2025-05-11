import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velaris/UI/views/profile/profile_controller.dart';
import 'package:velaris/UI/views/view_friends/view_friends_view.dart';
import 'package:velaris/UI/widgets/user_profile_picture.dart';
import 'package:velaris/model/entity/dream_user.dart';

import '../../widgets/navbar.dart';
import '../edit_profile/edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key, this.dreamUser});

  final DreamUser? dreamUser;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final labelsLucidez = ['Lucido', 'No lucido'];
  final coloresLucidez = [Colors.greenAccent, Colors.redAccent];

  ProfileController profileController = ProfileController();
  String? descripcion;
  String? nickname;
  String? genero;
  DateTime? dob;
  int? year;
  Map<String, int> suenosLucidos = new Map<String, int>();
  bool pendingRequest = false;
  bool isFriend = false;
  bool isBlocked = false;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    suenosLucidos = profileController.getSuenosLucidos(
      await profileController.getDreams(userId: widget.dreamUser?.id),
    );
    await profileController.initialize();
    descripcion =
        widget.dreamUser?.description ?? (profileController.getDescription());
    genero = widget.dreamUser?.gender ?? (profileController.getGender());
    dob = widget.dreamUser?.dob ?? (profileController.getDob());
    nickname = widget.dreamUser?.nickname ?? (profileController.getNickname());
    if (dob != null) {
      // Fecha actual
      DateTime currentDate = DateTime.now();

      // Calcular la diferencia entre las fechas
      Duration difference = currentDate.difference(dob!);

      // Obtener años, meses y días
      year = (difference.inDays / 365).floor();
    }
    pendingRequest = await profileController.getIfExistsPendingRequest(
      widget.dreamUser?.id ?? "",
    );
    isFriend = await profileController.getIfFriend(widget.dreamUser?.id ?? "");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3E3657),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            bottom: 400,
          ),
          // Contenido principal
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
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Iconos superiores alineados a la derecha
                          widget.dreamUser == null
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.white),
                                    onPressed:
                                        () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => EditProfileView(),
                                            ),
                                          ),
                                        },
                                  ),
                                ],
                              )
                              : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  isFriend
                                      ? Row(
                                        children: [
                                          if (!isBlocked)
                                            IconButton(
                                              icon: Icon(
                                                FontAwesomeIcons.userCheck,
                                                color: Colors.white,
                                              ),
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) {
                                                    return Center(
                                                      child: Material(
                                                        color: Colors.transparent,
                                                        child: Container(
                                                          width: 300,
                                                          padding:
                                                              const EdgeInsets.all(
                                                                20,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color: Color(
                                                              0xFF433865,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  16,
                                                                ),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              Text(
                                                                "¿Estás seguro que deseas dejar de ser amigo con ${widget.dreamUser?.nickname}?",
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      Navigator.of(
                                                                        ctx,
                                                                      ).pop();
                                                                    },
                                                                    child: const Text(
                                                                      'Cancelar',
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors
                                                                                .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed: () async {
                                                                      if (await profileController
                                                                          .deleteFriend(
                                                                            widget.dreamUser?.id ??
                                                                                "",
                                                                          )) {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text(
                                                                              'Se ha eliminado a ${widget.dreamUser?.nickname} de tu lista de amigos',
                                                                            ),
                                                                          ),
                                                                        );
                                                                        initialize();
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text(
                                                                              'Ha habido un error al eliminar a ${widget.dreamUser?.nickname} de tu lista de amigos',
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      Navigator.of(
                                                                        context,
                                                                      ).pop();
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                    child: const Text(
                                                                      'Eliminar',
                                                                      style: TextStyle(
                                                                        color:
                                                                            Colors
                                                                                .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          IconButton(
                                            icon: Icon(Icons.block, color: Colors.white),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return Center(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        width: 300,
                                                        padding:
                                                            const EdgeInsets.all(
                                                              20,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xFF433865,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                16,
                                                              ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              !isBlocked
                                                              ? '¿Estás seguro que deseas bloquear a ${widget.dreamUser?.nickname}?'
                                                              : '¿Estás seguro que deseas desbloquear a ${widget.dreamUser?.nickname}?',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    Colors.white,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                      ctx,
                                                                    ).pop();
                                                                  },
                                                                  child: const Text(
                                                                    'Cancelar',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed: () async {
                                                                    final userId = widget.dreamUser!.id;
                                                                    if (!isBlocked) {
                                                                      bool resultado = await profileController.bloqUser(userId);

                                                                      if (resultado) {
                                                                        isBlocked = true;
                                                                        pendingRequest = false;
                                                                        isFriend = false;
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Usuario bloqueado con exito."),
                                                                          ),
                                                                        );
                                                                        Navigator.of(
                                                                          ctx,
                                                                        ).pop();
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Ha habido un error al intentar bloquear al usuario."),
                                                                          ),
                                                                        );
                                                                      }
                                                                    } else {
                                                                      bool resultado = await profileController.desbloqUser(userId??"");

                                                                      if (resultado) {
                                                                        isBlocked = false;
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Usuario desbloqueado con exito."),
                                                                          ),
                                                                        );
                                                                        Navigator.of(
                                                                          ctx,
                                                                        ).pop();
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Ha habido un error al intentar desbloquear al usuario."),
                                                                          ),
                                                                        );
                                                                      }
                                                                    }
                                                                    setState(() {});
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                  ),
                                                                  child: const Text(
                                                                    'Eliminar',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      )
                                      : pendingRequest
                                      ? Row(
                                        children: [
                                          if (!isBlocked)
                                          IconButton(
                                            icon: Icon(
                                              Icons.person_off_outlined,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return Center(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        width: 300,
                                                        padding: const EdgeInsets.all(
                                                          20,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Color(0xFF433865),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                16,
                                                              ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Text(
                                                              '¿Estás seguro que deseas eliminar la solicitud?',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.white,
                                                              ),
                                                              textAlign:
                                                                  TextAlign.center,
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                      ctx,
                                                                    ).pop();
                                                                  },
                                                                  child: const Text(
                                                                    'Cancelar',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed: () async {
                                                                    if (await profileController
                                                                        .cancelFriendRequest(
                                                                          widget
                                                                                  .dreamUser
                                                                                  ?.id ??
                                                                              "",
                                                                        )) {
                                                                      ScaffoldMessenger.of(
                                                                        context,
                                                                      ).showSnackBar(
                                                                        SnackBar(
                                                                          content: Text(
                                                                            'Se ha eliminado la solicitud',
                                                                          ),
                                                                        ),
                                                                      );
                                                                      initialize();
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                        context,
                                                                      ).showSnackBar(
                                                                        SnackBar(
                                                                          content: Text(
                                                                            'Ha habido un error al eliminar la solicitud',
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                    Navigator.of(
                                                                      context,
                                                                    ).pop();
                                                                  },
                                                                  style:
                                                                      ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red,
                                                                      ),
                                                                  child: const Text(
                                                                    'Eliminar',
                                                                    style: TextStyle(
                                                                      color:
                                                                          Colors
                                                                              .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.block, color: Colors.white),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return Center(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        width: 300,
                                                        padding:
                                                        const EdgeInsets.all(
                                                          20,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xFF433865,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              !isBlocked
                                                                  ? '¿Estás seguro que deseas bloquear a ${widget.dreamUser?.nickname}?'
                                                                  : '¿Estás seguro que deseas desbloquear a ${widget.dreamUser?.nickname}?',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                Colors.white,
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                      ctx,
                                                                    ).pop();
                                                                  },
                                                                  child: const Text(
                                                                    'Cancelar',
                                                                    style: TextStyle(
                                                                      color:
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed: () async {
                                                                    final userId = widget.dreamUser!.id;
                                                                    if (!isBlocked) {
                                                                      bool resultado = await profileController.bloqUser(userId);

                                                                      if (resultado) {
                                                                        isBlocked = true;
                                                                        pendingRequest = false;
                                                                        isFriend = false;
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Usuario bloqueado con exito."),
                                                                          ),
                                                                        );
                                                                        Navigator.of(
                                                                          ctx,
                                                                        ).pop();
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Ha habido un error al intentar bloquear al usuario."),
                                                                          ),
                                                                        );
                                                                      }
                                                                    } else {
                                                                      bool resultado = await profileController.desbloqUser(userId??"");

                                                                      if (resultado) {
                                                                        isBlocked = false;
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Usuario desbloqueado con exito."),
                                                                          ),
                                                                        );
                                                                        Navigator.of(
                                                                          ctx,
                                                                        ).pop();
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Ha habido un error al intentar desbloquear al usuario."),
                                                                          ),
                                                                        );
                                                                      }
                                                                    }
                                                                    setState(() {});
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                    Colors
                                                                        .red,
                                                                  ),
                                                                  child: const Text(
                                                                    'Eliminar',
                                                                    style: TextStyle(
                                                                      color:
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      )
                                      : Row(
                                        children: [
                                          if (!isBlocked)
                                          IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.userPlus,
                                              color: Colors.white,
                                            ),
                                            onPressed: () async {
                                              if (await profileController
                                                  .sendFriendRequest(
                                                    widget.dreamUser?.id ?? "",
                                                  )) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Se ha enviado la solicitud',
                                                    ),
                                                  ),
                                                );
                                                initialize();
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Ha habido un error al enviar la solicitud',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.block, color: Colors.white),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) {
                                                  return Center(
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Container(
                                                        width: 300,
                                                        padding:
                                                        const EdgeInsets.all(
                                                          20,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                            0xFF433865,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                            16,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              !isBlocked
                                                                  ? '¿Estás seguro que deseas bloquear a ${widget.dreamUser?.nickname}?'
                                                                  : '¿Estás seguro que deseas desbloquear a ${widget.dreamUser?.nickname}?',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                Colors.white,
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                      ctx,
                                                                    ).pop();
                                                                  },
                                                                  child: const Text(
                                                                    'Cancelar',
                                                                    style: TextStyle(
                                                                      color:
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  onPressed: () async {
                                                                    final userId = widget.dreamUser!.id;
                                                                    if (!isBlocked) {
                                                                      bool resultado = await profileController.bloqUser(userId);

                                                                      if (resultado) {
                                                                        isBlocked = true;
                                                                        pendingRequest = false;
                                                                        isFriend = false;
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Usuario bloqueado con exito."),
                                                                          ),
                                                                        );
                                                                        Navigator.of(
                                                                          ctx,
                                                                        ).pop();
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Ha habido un error al intentar bloquear al usuario."),
                                                                          ),
                                                                        );
                                                                      }
                                                                    } else {
                                                                      bool resultado = await profileController.desbloqUser(userId??"");

                                                                      if (resultado) {
                                                                        isBlocked = false;
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Usuario desbloqueado con exito."),
                                                                          ),
                                                                        );
                                                                        Navigator.of(
                                                                          ctx,
                                                                        ).pop();
                                                                      } else {
                                                                        ScaffoldMessenger.of(
                                                                          context,
                                                                        ).showSnackBar(
                                                                          SnackBar(
                                                                            content: Text("Ha habido un error al intentar desbloquear al usuario."),
                                                                          ),
                                                                        );
                                                                      }
                                                                    }
                                                                    setState(() {});
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                    Colors
                                                                        .red,
                                                                  ),
                                                                  child: const Text(
                                                                    'Eliminar',
                                                                    style: TextStyle(
                                                                      color:
                                                                      Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                ],
                              ),
                          const SizedBox(height: 6),

                          // Avatar y nombre alineados a la izquierda
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.dreamUser != null)
                                UserProfilePicture(
                                  url: widget.dreamUser!.profilePicture,
                                )
                              else
                                UserProfilePicture(
                                  url:
                                      profileController.getUser()?.profilePicture,
                                ),
                              SizedBox(width: 16),
                              Text(
                                nickname ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Descripción
                          Text(
                            descripcion ?? "",
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 20),

                          // Fecha de nacimiento y género
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Fecha de Nacimiento: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                dob != null && year != null
                                    ? '${dob!.day.toString().padLeft(2, '0')}/${dob!.month.toString().padLeft(2, '0')}/${dob!.year} ($year años)'
                                    : '',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Género: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                genero ?? "",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Título sección gráfica
                          const Text(
                            'Sueños en total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Zona de la gráfica (placeholder)
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3E3657),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: SizedBox(
                              height: 200,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: PieChart(
                                      PieChartData(
                                        sections: List.generate(labelsLucidez.length, (
                                          index,
                                        ) {
                                          final label =
                                              labelsLucidez[index]; // Obtenemos la etiqueta
                                          final value =
                                              suenosLucidos[label] ??
                                              0; // Obtenemos el número de sueños de esa etiqueta

                                          return PieChartSectionData(
                                            value: value.toDouble(),
                                            // Valor que corresponde a la sección del pastel
                                            color: coloresLucidez[index],
                                            // Color correspondiente
                                            title: value > 0 ? '$value' : '',
                                            // Solo mostramos el número si es mayor a 0
                                            radius: 60,
                                            // Radio del gráfico
                                            titleStyle: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  12, // Tamaño del texto del título
                                            ),
                                          );
                                        }),
                                        sectionsSpace: 2,
                                        // Espacio entre secciones
                                        centerSpaceRadius:
                                            0, // Espacio en el centro del pastel
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Espacio entre el gráfico y la leyenda
                                  // Leyenda a la derecha
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(labelsLucidez.length, (
                                        index,
                                      ) {
                                        final label =
                                            labelsLucidez[index]; // Obtenemos la etiqueta
                                        final color =
                                            coloresLucidez[index]; // Obtenemos el color correspondiente
                                        final count =
                                            suenosLucidos[label] ??
                                            0; // Obtenemos el número de sueños para esa etiqueta

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 12,
                                                // Tamaño del círculo de color
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: color,
                                                  // Color correspondiente a la etiqueta
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '$label ($count)',
                                                // Mostramos la etiqueta y el número de sueños
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      12, // Tamaño del texto
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
