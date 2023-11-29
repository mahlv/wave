enum WaveType {
  text('text'),
  image('image'),
  audio('audio');

  final String type;
  const WaveType(this.type);
}

extension ConvertWave on String {
  WaveType toWaveTypeEnum() {
    switch (this) {
      case 'text':
      return WaveType.text;
      case 'image':
      return WaveType.image;
      case 'audio':
      return WaveType.audio;
      default:
      return WaveType.text;
    }
  }
}