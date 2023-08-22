import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/menu_principal_provider.dart';
import 'dart:math' as math;

class IconLightOrDart extends StatefulWidget {
  const IconLightOrDart({super.key});

  @override
  State<IconLightOrDart> createState() => _IconLightOrDartState();
}

class _IconLightOrDartState extends State<IconLightOrDart>
    with SingleTickerProviderStateMixin {
  late final MenuPrincipalProvider controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<MenuPrincipalProvider>();

    controller.controllerIconLightOrDart = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuPrincipalProvider>(
      builder: (context, controller, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: RotationTransition(
                  turns: controller.controllerIconLightOrDart,
                  child: Transform.rotate(
                    angle: controller.animationMenuIconLightOrDart.value *
                        2.0 *
                        math.pi,
                    child: AnimatedCrossFade(
                      firstChild: Icon(
                        Icons.light_mode,
                        color: Colors.amber[900],
                      ),
                      secondChild: const Icon(Icons.dark_mode),
                      crossFadeState:
                          controller.animatedIconLightOrDartCrossFadeState(),
                      duration: controller.controllerIconLightOrDart.duration!,
                    ),
                  ),
                ),
                onTap: () {
                  controller.animatedLightDartIcon();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
