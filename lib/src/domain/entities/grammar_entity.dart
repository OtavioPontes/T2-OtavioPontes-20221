class GrammarRule {
  final String leftSide;
  final String rightSide;

  GrammarRule({
    required this.leftSide,
    required this.rightSide,
  });

  @override
  String toString() => 'GrammarRule($leftSide -> $rightSide)';
}
