// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, dead_code, unused_element, prefer_null_aware_operators
import 'package:DNL/core/blocs/profile/profile_bloc.dart';
import 'package:DNL/core/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:DNL/common/values/constants.dart';
import 'package:DNL/common/utils/convTime.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/image_placeholder_button.dart';

class ProfilePhotos extends StatefulWidget {
  const ProfilePhotos({super.key});

  @override
  _ProfilePhotosState createState() => _ProfilePhotosState();
}

class _ProfilePhotosState extends State<ProfilePhotos> {
  final picker = HLImagePicker();
  List<Media> medias = [];
  ProfileModel _profile = ProfileModel();

  Future<void> updateProfile(medias) async {
    context
        .read<ProfileBloc>()
        .add(ProfileUpdated(_profile.copyWith(medias: medias)));
  }

  @override
  void initState() {
    super.initState();

    ProfileModel profile = context.read<ProfileBloc>().state.profile;

    for (int i = 0; i < 6; i++) {
      if (profile.medias == null) {
        Media temp = Media(
          index: i,
          type: '',
          media: '',
          thumbnail: '',
          duration: '',
        );
        medias.add(temp);
      } else {
        medias = profile.medias!;
      }
    }

    setState(() {
      _profile = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isCroppingEnabled = true;
    int count = 1;
    MediaType type = MediaType.all;
    bool isExportThumbnail = true;
    bool enablePreview = false;
    bool usedCameraButton = true;
    int numberOfColumn = 3;
    CropAspectRatio? aspectRatio;
    List<CropAspectRatioPreset>? aspectRatioPresets;
    double compressQuality = 0.9;
    CroppingStyle croppingStyle = CroppingStyle.normal;

    _openCamera(int index, MediaType type) async {
      try {
        final media = await picker.openCamera(
          cropping: isCroppingEnabled,
          cameraOptions: HLCameraOptions(
            cameraType:
                type == MediaType.video ? CameraType.video : CameraType.image,
            recordVideoMaxSecond: 300,
            isExportThumbnail: isExportThumbnail,
            thumbnailCompressFormat: CompressFormat.jpg,
            thumbnailCompressQuality: 0.9,
          ),
          cropOptions: HLCropOptions(
            aspectRatio: aspectRatio,
            aspectRatioPresets: aspectRatioPresets,
            croppingStyle: croppingStyle,
          ),
        );
        setState(() {
          if (media.type == 'video') {
            medias[index] = Media(
              index: index,
              type: 'video',
              media: media.path,
              thumbnail: media.thumbnail ?? "",
              duration: convTimetoMinSec(media.duration ?? 0.0),
            );
          } else {
            medias[index] = Media(
              index: index,
              type: 'image',
              media: media.path,
              thumbnail: media.path,
              duration: "",
            );
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    _openPicker(int index) async {
      try {
        final media = await picker.openPicker(
          cropping: isCroppingEnabled,
          pickerOptions: HLPickerOptions(
            mediaType: type,
            enablePreview: enablePreview,
            isExportThumbnail: isExportThumbnail,
            thumbnailCompressFormat: CompressFormat.jpg,
            thumbnailCompressQuality: 0.9,
            recordVideoMaxSecond: 300,
            maxSelectedAssets: isCroppingEnabled ? 1 : count,
            usedCameraButton: usedCameraButton,
            numberOfColumn: numberOfColumn,
          ),
          cropOptions: HLCropOptions(
            aspectRatio: aspectRatio,
            aspectRatioPresets: aspectRatioPresets,
            compressQuality: compressQuality,
            compressFormat: CompressFormat.jpg,
            croppingStyle: croppingStyle,
          ),
        );
        setState(() {
          if (media[0].type == 'video') {
            medias[index] = Media(
              index: index,
              type: 'video',
              media: media[0].path,
              thumbnail: media[0].thumbnail ?? "",
              duration: convTimetoMinSec(media[0].duration ?? 0.0),
            );
          } else {
            medias[index] = Media(
              index: index,
              type: 'image',
              media: media[0].path,
              thumbnail: media[0].path,
              duration: "",
            );
          }
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    void onImageButtonClicked(String type, int index) async {
      switch (type) {
        case "Take Photo":
          await _openCamera(index, MediaType.image);
          break;
        case "Record Video":
          await _openCamera(index, MediaType.video);
          break;
        default:
          await _openPicker(index);
          break;
      }

      await updateProfile(medias);
    }

    void onDelete(int index) {
      setState(() {
        medias[index] = Media(
          index: index,
          type: '',
          media: '',
          thumbnail: '',
          duration: '',
        );
        // widget.onChange(medias);
      });
    }

    return Column(
      children: [
        const SizedBox(height: 28),
        SizedBox(
          height: 124,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ImagePlaceholderButton(
                    image: medias[0].thumbnail,
                    duration: medias[0].duration,
                    onDelete: () {
                      onDelete(0);
                    },
                    onPressed: (e) {
                      onImageButtonClicked(e, 0);
                    }),
              ),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: medias[1].thumbnail,
                      duration: medias[1].duration,
                      onDelete: () {
                        onDelete(1);
                      },
                      onPressed: (e) {
                        onImageButtonClicked(e, 1);
                      })),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: medias[2].thumbnail,
                      duration: medias[2].duration,
                      onDelete: () {
                        onDelete(2);
                      },
                      onPressed: (e) {
                        onImageButtonClicked(e, 2);
                      }))
            ],
          ),
        ),
        const SizedBox(height: 17),
        SizedBox(
          height: 124,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ImagePlaceholderButton(
                    image: medias[3].thumbnail,
                    duration: medias[3].duration,
                    onDelete: () {
                      onDelete(3);
                    },
                    onPressed: (e) {
                      onImageButtonClicked(e, 3);
                    }),
              ),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: medias[4].thumbnail,
                      duration: medias[4].duration,
                      onDelete: () {
                        onDelete(4);
                      },
                      onPressed: (e) {
                        onImageButtonClicked(e, 4);
                      })),
              const SizedBox(width: 17),
              Expanded(
                  flex: 1,
                  child: ImagePlaceholderButton(
                      image: medias[5].thumbnail,
                      duration: medias[5].duration,
                      onDelete: () {
                        onDelete(5);
                      },
                      onPressed: (e) {
                        onImageButtonClicked(e, 5);
                      }))
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text("Tap to edit,drag to reorder",
            textAlign: TextAlign.center,
            style: CustomTextStyle.getDescStyle(
                Theme.of(context).colorScheme.onSurface)),
        const SizedBox(height: 24),
        SizedBox(
          // width: 361,
          height: 62,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/star.svg",
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  height: 62,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: ShapeDecoration(
                    color: const Color(0x0C9D9D9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            'Videos bring your profile to life, giving others a better sense of who you are :)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF95F80),
                              fontSize: 14,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
