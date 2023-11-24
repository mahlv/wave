import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soundtt/common/common.dart';
import 'package:soundtt/constants/assets_constants.dart';
import 'package:soundtt/core/utils.dart';
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
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    waveTextController.dispose();
  }

  void onPickImages() async {
    images = await pickImages();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton (
          onPressed: () {
            Navigator.pop(context);
          },
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
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                      ),
                  ],),
                  if(images.isNotEmpty)
                  CarouselSlider(items: images.map(
                    (file) { return Container(width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                     child: Image.file(file)
                     );
                    },
                  ) 
                  .toList(),
                  options: CarouselOptions(
                    height: 400,
                    enableInfiniteScroll: false,
                  ),
                  ),
              ],
            ),
          ),
       ),
       bottomNavigationBar:Container(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 0.3,
            ),
          ), 
        ),
         child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: GestureDetector(
                onTap: onPickImages,
                child: SvgPicture.asset(AssetsConstants.galleryIcon)
                ),
            ),
                      Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: SvgPicture.asset(AssetsConstants.gifIcon),
            ),
                      Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: SvgPicture.asset(AssetsConstants.emojiIcon),
            ),
          ],
         ),
       ),
    );
  }
}