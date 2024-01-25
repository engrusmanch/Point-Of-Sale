import 'dart:io';

import 'package:flutter/material.dart';
import 'package:point_of_sale/core/widgets/image_viewer.dart';
import 'package:point_of_sale/mvvm/entities/image_data.dart';
import 'package:shimmer/shimmer.dart';


class FileIcon extends StatelessWidget {
  const FileIcon(
      {required this.imageData,
      this.index,
      Key? key,
      required this.onRemove,
      this.isLoading = false,
      this.showRemoveIcon = true})
      : super(key: key);
  final CustomImageData imageData;
  final int? index;
  final Function() onRemove;
  final bool showRemoveIcon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            barrierColor: Theme.of(context).colorScheme.secondary,
            context: context,
            builder: (_) => ImageViewer(
                  imageFile: imageData.file,
                ));
      },
      child: SizedBox(
        height: 90.0,
        width: 90.0,
        child: Stack(
          children: [
            Align(
              child: isLoading
                  ? SizedBox(
                      height: 80.0,
                      width: 80.0,
                      child: Shimmer.fromColors(
                          baseColor: Theme.of(context).colorScheme.secondary,
                          highlightColor: Theme.of(context).colorScheme.secondaryContainer,
                          child: const Card()),
                    )
                  : Container(
                      // padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).colorScheme.primary)),
                      height: 80.0,
                      width: 80.0,
                      child: Image.file(
                        File(imageData.file!.path),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
            ),
            Container(),
            if (showRemoveIcon)
              Positioned(
                  right: 0.0,
                  child: InkWell(
                    onTap: () {
                      onRemove();
                    },
                    child: const CircleAvatar(
                      foregroundColor: Colors.red,
                      radius: 10.0,
                      backgroundColor: Color(0xffFF544E),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 10.0,
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
