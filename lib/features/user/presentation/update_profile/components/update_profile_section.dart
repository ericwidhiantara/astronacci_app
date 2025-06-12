import 'dart:developer' as developer;

import 'package:boilerplate/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateProfileSection extends StatefulWidget {
  final UserDataEntity profile;

  const UpdateProfileSection({super.key, required this.profile});

  @override
  State<UpdateProfileSection> createState() => _UpdateProfileSectionState();
}

class _UpdateProfileSectionState extends State<UpdateProfileSection> {
  final _conName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conBio = TextEditingController();
  final _conDateOfBirth = TextEditingController();
  final _conGender = TextEditingController();
  final _conDateOfBirthUnformatted = TextEditingController();
  final _conLocation = TextEditingController();

  final _fnName = FocusNode();
  final _fnEmail = FocusNode();
  final _fnBio = FocusNode();
  final _fnDateOfBirth = FocusNode();
  final _fnGender = FocusNode();
  final _fnLocation = FocusNode();

  final _keyForm = GlobalKey<FormState>();

  void resetForm() {
    setState(() {
      _conName.clear();
      _conEmail.clear();
      _conBio.clear();
      _conDateOfBirth.clear();
      _conGender.clear();
      _conDateOfBirthUnformatted.clear();
      _conLocation.clear();

      _fnName.unfocus();
      _fnEmail.unfocus();
      _fnBio.unfocus();
      _fnDateOfBirth.unfocus();
      _fnGender.unfocus();
      _fnLocation.unfocus();
    });
  }

  @override
  void initState() {
    final cubit = context.read<SettingsCubit>();

    _conName.text = widget.profile.name ?? "";
    _conEmail.text = widget.profile.email ?? "";
    _conBio.text = widget.profile.bio ?? "";

    if (widget.profile.dateOfBirth == null) {
      _conDateOfBirth.text = DateFormat(
        "EEEE, dd MMMM yyyy",
        cubit.state.type == "en" ? "en" : "id",
      ).format(DateTime.now());
      _conDateOfBirthUnformatted.text = DateTime.now().toString();
    } else {
      _conDateOfBirth.text = DateFormat(
        "EEEE, dd MMMM yyyy",
        cubit.state.type == "en" ? "en" : "id",
      ).format(
        DateTime.parse(widget.profile.dateOfBirth ?? ""),
      );
      _conDateOfBirthUnformatted.text = widget.profile.dateOfBirth ?? "";
    }
    _conGender.text = widget.profile.gender ?? "";
    _conLocation.text = widget.profile.location ?? "";

    super.initState();
  }

  @override
  void dispose() {
    _conName.dispose();
    _conEmail.dispose();
    _conBio.dispose();
    _conDateOfBirth.dispose();
    _conGender.dispose();
    _conDateOfBirthUnformatted.dispose();
    _conLocation.dispose();
    _fnName.dispose();
    _fnEmail.dispose();
    _fnBio.dispose();
    _fnDateOfBirth.dispose();
    _fnGender.dispose();
    _fnLocation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UpdateProfileFormSection(
            formKey: _keyForm,
            nameController: _conName,
            emailController: _conEmail,
            bioController: _conBio,
            dateOfBirthController: _conDateOfBirth,
            dateOfBirthUnformattedController: _conDateOfBirthUnformatted,
            genderController: _conGender,
            locationController: _conLocation,
            nameFocus: _fnName,
            emailFocus: _fnEmail,
            bioFocus: _fnBio,
            dateOfBirthFocus: _fnDateOfBirth,
            genderFocus: _fnGender,
            locationFocus: _fnLocation,
            onGenderChange: (value) {
              developer.log(value);
              setState(() {
                _conGender.text = value;
              });
            },
            onSend: () {
              context.read<UpdateProfileCubit>().updateProfile(
                    PostUpdateProfileParams(
                      name: _conName.text,
                      email: _conEmail.text,
                      bio: _conBio.text,
                      dateOfBirth: _conDateOfBirthUnformatted.text,
                      gender: _conGender.text,
                      location: _conLocation.text,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
