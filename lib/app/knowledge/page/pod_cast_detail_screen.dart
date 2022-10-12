import 'package:flutter/material.dart';

import '../../../network/modal/podcast/pod_cast_response.dart';

class PodCastDetailScreen extends StatefulWidget {
  final PodcastElement item;

  const PodCastDetailScreen({required this.item, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PodCastDetailScreenState();
}

class _PodCastDetailScreenState extends State<PodCastDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
