import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'dart:async' as async;

class PlayerInterFace extends StatefulWidget {
  final BonfireGame game;
  const PlayerInterFace({super.key, required this.game});
  static const overlayKey = 'PlayerInterface';

  @override
  State<PlayerInterFace> createState() => _PlayerInterFaceState();
}

class _PlayerInterFaceState extends State<PlayerInterFace> {
  double life = 0;
  final double width_Max = 100;
  double width_current = 100;
  late async.Timer _lifeTime;

  @override
  void initState() {
    _lifeTime =
        async.Timer.periodic(const Duration(milliseconds: 100), _verifyLife);
    super.initState();
  }

  @override
  void dispose() {
    _lifeTime.cancel();
    super.dispose();
  }

  Color getColor() {
    if (width_current < 60) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(width: 10),
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                margin: const EdgeInsets.all(20),
                width: width_current,
                height: 20,
                decoration: BoxDecoration(
                    color: getColor(), borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  width: width_Max,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white))),
            ],
          ),
        ],
      ),
    );
  }

  void _verifyLife(async.Timer timer) {
    if (life != (widget.game.player?.life ?? 0)) {
      setState(() {
        life = widget.game.player?.life ?? 0;
        final percent = life / (widget.game.player?.maxLife ?? 0);
        width_current = width_Max * percent;
      });
    }
  }
}
