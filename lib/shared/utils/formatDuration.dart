String formatDuration(int duration) {
  final minutes = duration ~/ 60;
  final seconds = duration - minutes * 60;
  return "$minutes:${seconds < 10 ? '0': ''}$seconds";
}
