import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundtt/common/common.dart';
import 'package:soundtt/features/auth/controller/auth_controller.dart';
import 'package:soundtt/theme/pallete.dart';


class CreateWaveScreen extends ConsumerStatefulWidget {
      static route() => MaterialPageRoute(
        builder: (context) => const CreateWaveScreen(),
      );
  const CreateWaveScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateWaveScreenState();
}

class _CreateWaveScreenState extends ConsumerState<CreateWaveScreen> {
  final waveTextController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    waveTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton (
          onPressed: () {},
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          RoundedSmallButton(
            onTap: () {}, 
            label: 'Wave', 
            height: 20, 
            backgroundColor: Pallete.greenColor,
            textColor: Pallete.greyColor,
            ),
        ],
        ),
        body: currentUser == null
        ? const Loader()
        : SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(currentUser.profilePic),
                      radius: 30,
                    ),
                    const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          controller: waveTextController,
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                          decoration: const InputDecoration(
                            hintText: "What's happening?",
                            hintStyle: TextStyle(
                              color: Pallete.greyColor,
                            ),
                          ),
                        ),
                      ),
                  ],)
              ],
            ),
          ),
       ),
    );
  }
}