import 'package:flutter/material.dart';
import 'package:mom_dance/constant.dart';

class CustomTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const CustomTooltip({Key? key, required this.message, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final overlay = Overlay.of(context)?.context.findRenderObject();
        final renderBox = context.findRenderObject() as RenderBox;
        final size = renderBox.size;
        final position = renderBox.localToGlobal(Offset.zero, ancestor: overlay);

        showDialog(
          context: context,
          builder: (context) => Stack(
            children: [
              Positioned(
                top: position.dy - 80, // Adjust for tooltip position
                left: position.dx + (size.width / 2) - 100, // Center the tooltip
                child: TooltipBox(message: message),
              ),
            ],
          ),
        );
      },
      child: child,
    );
  }
}

class TooltipBox extends StatelessWidget {
  final String message;

  const TooltipBox({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 200,
        height: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
