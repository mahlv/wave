
import 'package:flutter/foundation.dart';
import 'package:soundtt/core/enums/wave_type_enum.dart';

@immutable
class Wave {
  final String text;
  final List<String> hashtags;
  final String link;
  final List<String> imageLinks;
  final String uid;
  final WaveType waveType;
  final DateTime wavedAt;
  final List<String> likes;
  final List<String> commentIds;
  final String id;
  final int reshareCount;
  const Wave({
    required this.text,
    required this.hashtags,
    required this.link,
    required this.imageLinks,
    required this.uid,
    required this.waveType,
    required this.wavedAt,
    required this.likes,
    required this.commentIds,
    required this.id,
    required this.reshareCount,
  });

  Wave copyWith({
    String? text,
    List<String>? hashtags,
    String? link,
    List<String>? imageLinks,
    String? uid,
    WaveType? waveType,
    DateTime? wavedAt,
    List<String>? likes,
    List<String>? commentIds,
    String? id,
    int? reshareCount,
  }) {
    return Wave(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      link: link ?? this.link,
      imageLinks: imageLinks ?? this.imageLinks,
      uid: uid ?? this.uid,
      waveType: waveType ?? this.waveType,
      wavedAt: wavedAt ?? this.wavedAt,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      id: id ?? this.id,
      reshareCount: reshareCount ?? this.reshareCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'text': text});
    result.addAll({'hashtags': hashtags});
    result.addAll({'link': link});
    result.addAll({'imageLinks': imageLinks});
    result.addAll({'uid': uid});
    result.addAll({'waveType': waveType.type});
    result.addAll({'wavedAt': wavedAt.millisecondsSinceEpoch});
    result.addAll({'likes': likes});
    result.addAll({'commentIds': commentIds});
    result.addAll({'reshareCount': reshareCount});
  
    return result;
  }

  factory Wave.fromMap(Map<String, dynamic> map) {
    return Wave(
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      link: map['link'] ?? '',
      imageLinks: List<String>.from(map['imageLinks']),
      uid: map['uid'] ?? '',
      waveType:(map['waveType'] as String).toWaveTypeEnum(),
      wavedAt: DateTime.fromMillisecondsSinceEpoch(map['wavedAt']),
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      id: map['\$id'] ?? '',
      reshareCount: map['reshareCount']?.toInt() ?? 0,
    );
  }


  @override
  String toString() {
    return 'Wave(text: $text, hashtags: $hashtags, link: $link, imageLinks: $imageLinks, uid: $uid, waveType: $waveType, wavedAt: $wavedAt, likes: $likes, commentIds: $commentIds, id: $id, reshareCount: $reshareCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Wave &&
      other.text == text &&
      listEquals(other.hashtags, hashtags) &&
      other.link == link &&
      listEquals(other.imageLinks, imageLinks) &&
      other.uid == uid &&
      other.waveType == waveType &&
      other.wavedAt == wavedAt &&
      listEquals(other.likes, likes) &&
      listEquals(other.commentIds, commentIds) &&
      other.id == id &&
      other.reshareCount == reshareCount;
  }

  @override
  int get hashCode {
    return text.hashCode ^
      hashtags.hashCode ^
      link.hashCode ^
      imageLinks.hashCode ^
      uid.hashCode ^
      waveType.hashCode ^
      wavedAt.hashCode ^
      likes.hashCode ^
      commentIds.hashCode ^
      id.hashCode ^
      reshareCount.hashCode;
  }
}
