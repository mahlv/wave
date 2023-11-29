import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundtt/apis/wave_api.dart';
import 'package:soundtt/core/enums/wave_type_enum.dart';
import 'package:soundtt/core/utils.dart';
import 'package:soundtt/features/auth/controller/auth_controller.dart';
import 'package:soundtt/models/wave_model.dart';

final waveControllerProvider = StateNotifierProvider<WaveController, bool>((ref) {
  return WaveController(
    ref: ref, 
    waveAPI: ref.watch(waveAPIProvider),
    );
});

class WaveController extends StateNotifier<bool> {
  final WaveAPI _waveAPI;
  final Ref _ref;
  WaveController({
    required Ref ref,
    required WaveAPI waveAPI,
  }) : _ref = ref, 
        _waveAPI = waveAPI,
    super(false);
  
  void shareWave({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if(text.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      _shareImageWave(
        images: images,
        text: text,
        context: context
      );
    } else {
      _shareTextWave(
        text: text,
        context: context
      );
    }
  }

  void _shareImageWave({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) { 

  }

    void _shareTextWave({
    required String text,
    required BuildContext context,
  }) async { 
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    final user = _ref.read(currentUserDetailsProvider).value!;

    Wave wave = Wave(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: const [],
      uid: user.uid,
      waveType: WaveType.text,
      wavedAt: DateTime.now(),
      likes: const [],
      commentIds: const [], id: '',
      reshareCount: 0
    );
    final res = await _waveAPI.shareWave(wave);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) => null);

    
  }

  String _getLinkFromText(String text) {
    String link = '';
    List<String> wordsInSentence = text.split('');
    for(String word in wordsInSentence) {
      if (word.startsWith('https://') || word.startsWith('www.'))  {
        link = word;
      }
    }
    return link;
  }

  List <String> _getHashtagsFromText(String text){
        List<String> hashtags = [];
    List<String> wordsInSentence = text.split('');
    for(String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}