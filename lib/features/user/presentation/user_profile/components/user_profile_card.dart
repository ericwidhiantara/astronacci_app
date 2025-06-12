import 'dart:io';

import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/dependencies_injection.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class UserProfileCard extends StatefulWidget {
  final UserDataEntity user;

  const UserProfileCard({super.key, required this.user});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> with MainBoxMixin {
  late ActiveTheme _selectedTheme = sl<SettingsCubit>().getActiveTheme();

  late final List<DataHelper> _listLanguage = [
    DataHelper(title: Constants.get.english, type: "en"),
    DataHelper(title: Constants.get.bahasa, type: "id"),
  ];
  late DataHelper _selectedLanguage =
      (getData(MainBoxKeys.locale) ?? "en") == "en"
          ? _listLanguage[0]
          : _listLanguage[1];

  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfilePictureCubit, ProfilePictureState>(
      listener: (context, state) => switch (state) {
        ProfilePictureStateLoading() => context.show(),
        ProfilePictureStateSuccess(:final data) => (() {
            context.dismiss();
            data.meta?.message.toString().toToastSuccess(context);

            context.read<UserProfileCubit>().fetchUserProfile();
          })(),
        ProfilePictureStateFailure(:final message) => (() {
            context.dismiss();
            message.toToastError(context);
          })(),
        _ => {},
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    final res = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              Text(Strings.of(context)!.changeProfilePicture),
                          content: Text(
                              Strings.of(context)!.changeProfilePictureDesc),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                final result = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return PickerBottomSheet(
                                      extra: const {
                                        "isSelfie": false,
                                        "enableFlipCamera": true,
                                      },
                                      onFilePicked: (File value) {
                                        debugPrint("ini value $value");
                                        context.back(true);
                                        setState(() {
                                          image = value;
                                        });
                                      },
                                      isWithWatermark: false,
                                    );
                                  },
                                );

                                if (result != null &&
                                    result == true &&
                                    context.mounted) {
                                  context.pop(true);
                                }
                              },
                              child: Text(
                                Strings.of(context)!.yes,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                Strings.of(context)!.cancel,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    if (res != null && res == true && context.mounted) {
                      context.read<ProfilePictureCubit>().changeProfilePicture(
                            PostChangeProfilePictureParams(
                              image: image!.path,
                            ),
                          );
                    }
                  },
                  child: CachedNetworkImage(
                    imageUrl: widget.user.avatarUrl ??
                        "https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: Dimens.size80,
                      backgroundImage:
                          image != null ? FileImage(image!) : imageProvider,
                      backgroundColor: Palette.primary,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Center(
                              child: SvgPicture.asset(
                                SvgImages.icAddPhoto,
                                height: Dimens.size30,
                                colorFilter: const ColorFilter.mode(
                                  Palette.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: Dimens.size80,
                      backgroundImage:
                          const NetworkImage("https://fakeimg.pl/150x150"),
                      backgroundColor: Palette.primary,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: Center(
                              child: SvgPicture.asset(
                                SvgImages.icAddPhoto,
                                height: Dimens.size30,
                                colorFilter: const ColorFilter.mode(
                                  Palette.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const Center(child: CircularProgressIndicator()),
                  ),
                ),
                SpacerV(value: Dimens.size16),
                Text(
                  widget.user.name ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.text20,
                      ),
                ),
                Text(
                  widget.user.email ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SpacerV(value: Dimens.size16),
          ListTile(
            onTap: () async {
              final result = await context.pushNamed(
                Routes.updateProfile.name,
                extra: widget.user,
              );
              if (result != null && result == true && context.mounted) {
                context.read<UserProfileCubit>().fetchUserProfile();
              }
            },
            title: Text(
              Strings.of(context)!.updateProfile,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          ListTile(
            onTap: () => context.pushNamed(Routes.changePassword.name),
            title: Text(
              Strings.of(context)!.changePassword,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            subtitle: Text(
              Strings.of(context)!.changePasswordDesc,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text10,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.size15,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: Dimens.size100,
                          child: Divider(
                            thickness: Dimens.size3,
                          ),
                        ),
                        Column(
                          children: ActiveTheme.values
                              .map(
                                (data) => ListTile(
                                  onTap: () {
                                    _selectedTheme = data;

                                    /// Reload theme
                                    context
                                        .read<SettingsCubit>()
                                        .updateTheme(data);
                                    context.pop();
                                  },
                                  title: Text(
                                    _getThemeName(data, context),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: Radio(
                                    value: data,
                                    groupValue: _selectedTheme,
                                    onChanged: (value) {
                                      _selectedTheme = data;

                                      /// Reload theme
                                      context
                                          .read<SettingsCubit>()
                                          .updateTheme(data);
                                      context.pop();
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            title: Text(
              Strings.of(context)!.theme,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            subtitle: Text(
              Strings.of(context)!.themeDesc,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text10,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.size15,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: Dimens.size100,
                          child: Divider(
                            thickness: Dimens.size3,
                          ),
                        ),
                        Column(
                          children: _listLanguage
                              .map(
                                (data) => ListTile(
                                  onTap: () {
                                    _selectedLanguage = data;

                                    /// Reload theme
                                    if (!mounted) return;
                                    context
                                        .read<SettingsCubit>()
                                        .updateLanguage(data.type ?? "en");

                                    context.pop();
                                  },
                                  title: Text(
                                    data.title ?? "-",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: Radio(
                                    value: data,
                                    groupValue: _selectedLanguage,
                                    onChanged: (value) {
                                      _selectedLanguage =
                                          value ?? _listLanguage[0];

                                      /// Reload theme
                                      if (!mounted) return;
                                      context
                                          .read<SettingsCubit>()
                                          .updateLanguage(
                                            value?.type ?? "en",
                                          );
                                      context.pop();
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            title: Text(
              Strings.of(context)!.language,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            subtitle: Text(
              Strings.of(context)!.languageDesc,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text10,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => const CustomLogoutDialog());
            },
            title: Text(
              Strings.of(context)!.logout,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Dimens.text14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            trailing: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }

  String _getThemeName(ActiveTheme activeTheme, BuildContext context) {
    if (activeTheme == ActiveTheme.system) {
      return Strings.of(context)!.themeSystem;
    } else if (activeTheme == ActiveTheme.dark) {
      return Strings.of(context)!.themeDark;
    } else {
      return Strings.of(context)!.themeLight;
    }
  }
}
