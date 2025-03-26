import 'dart:io';

import 'package:chat/core/utils/extensions/snakbar_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatelessWidget {
  final File? image;
  final Function(File) onImageSelected;
  const AvatarPicker({super.key, this.image, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showImageSourceDialog(context),
          child: CircleAvatar(
            radius: 70,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            backgroundImage: image != null ? FileImage(image!) : null,
            child:
                image == null
                    ? Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    )
                    : null,
          ),
        ),
        TextButton(
          onPressed: () => showImageSourceDialog(context),
          child: Text(
            image == null ? "Add Profile Photo" : "Change Profile Photo",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        onImageSelected(File(pickedFile.path));
      }
      if (context.mounted) {
        context.showInfoSnackbar('Image Picked Successfully');
      }
    } catch (e) {
      if (context.mounted) {
        context.showErrorSnackbar('Failed to pick image: ${e.toString()}');
      }
    }
  }

  void showImageSourceDialog(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      builder:
          (context) => AlertDialog.adaptive(
            title: Text(
              'Choose Image Source',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),

            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  buildIconButton(
                    context: context,
                    icon: Icons.camera_alt_outlined,
                    onPressed: () {
                      _pickImage(context, ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  buildIconButton(
                    context: context,
                    icon: Icons.photo_library_outlined,
                    onPressed: () {
                      _pickImage(context, ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
    );
  }

  buildIconButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
        child: Icon(
          icon,
          size: 40,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
