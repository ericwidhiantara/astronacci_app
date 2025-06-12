import 'package:boilerplate/core/core.dart';
import 'package:boilerplate/features/features.dart';
import 'package:boilerplate/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpdateProfileFormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final TextEditingController dateOfBirthController;
  final TextEditingController dateOfBirthUnformattedController;
  final TextEditingController genderController;
  final TextEditingController locationController;
  final FocusNode nameFocus;
  final FocusNode emailFocus;
  final FocusNode bioFocus;
  final FocusNode dateOfBirthFocus;
  final FocusNode genderFocus;
  final FocusNode locationFocus;
  final VoidCallback? onSend;
  final Function(String value) onGenderChange;

  const UpdateProfileFormSection({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.bioController,
    required this.dateOfBirthController,
    required this.dateOfBirthUnformattedController,
    required this.genderController,
    required this.locationController,
    required this.nameFocus,
    required this.emailFocus,
    required this.bioFocus,
    required this.dateOfBirthFocus,
    required this.genderFocus,
    required this.locationFocus,
    this.onSend,
    required this.onGenderChange,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextF(
            key: const Key("name"),
            curFocusNode: nameFocus,
            nextFocusNode: emailFocus,
            textInputAction: TextInputAction.next,
            controller: nameController,
            keyboardType: TextInputType.text,
            hintText: Strings.of(context)!.name,
            hint: Strings.of(context)!.name,
            validator: (String? value) => value != null
                ? (value.isEmpty ? Strings.of(context)!.errorEmptyField : null)
                : null,
          ),
          TextF(
            key: const Key("email"),
            enable: false,
            curFocusNode: emailFocus,
            nextFocusNode: dateOfBirthFocus,
            textInputAction: TextInputAction.next,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "john.doe@gmail.com",
            hint: Strings.of(context)!.email,
            validator: (String? value) => value != null
                ? (!value.isValidEmail()
                    ? Strings.of(context)?.errorInvalidEmail
                    : null)
                : null,
          ),
          BlocBuilder<SettingsCubit, DataHelper>(
            builder: (_, data) {
              return TextF(
                key: const Key("date_of_birth"),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (date != null) {
                    dateOfBirthController.text = DateFormat(
                      "EEEE, dd MMMM yyyy",
                      data.type == "en" ? "en" : "id",
                    ).format(date);
                    dateOfBirthUnformattedController.text = DateFormat(
                      "yyyy-MM-dd",
                      data.type == "en" ? "en" : "id",
                    ).format(date);
                  }
                },
                curFocusNode: dateOfBirthFocus,
                nextFocusNode: genderFocus,
                textInputAction: TextInputAction.next,
                controller: dateOfBirthController,
                keyboardType: TextInputType.text,
                hintText: Strings.of(context)!.dateOfBirth,
                hint: Strings.of(context)!.dateOfBirth,
                validator: (String? value) => value != null
                    ? (value.isEmpty
                        ? Strings.of(context)!.errorEmptyField
                        : null)
                    : null,
              );
            },
          ),
          CustomRadioList(
            required: true,
            hintText: Strings.of(context)!.gender,
            options: [
              RadioOption(
                value: "male",
                label: Text(Strings.of(context)!.male),
              ),
              RadioOption(
                value: "female",
                label: Text(Strings.of(context)!.female),
              ),
            ],
            onChanged: (value) {
              onGenderChange(value!);
            },
            activeColor: Theme.of(context).colorScheme.primary,
          ),
          TextF(
            key: const Key("location"),
            curFocusNode: locationFocus,
            nextFocusNode: bioFocus,
            textInputAction: TextInputAction.next,
            controller: locationController,
            keyboardType: TextInputType.text,
            hintText: Strings.of(context)!.address,
            hint: Strings.of(context)!.address,
            validator: (String? value) => value != null
                ? (value.isEmpty ? Strings.of(context)!.errorEmptyField : null)
                : null,
          ),
          TextF(
            key: const Key("bio"),
            curFocusNode: bioFocus,
            textInputAction: TextInputAction.done,
            controller: bioController,
            keyboardType: TextInputType.text,
            hintText: Strings.of(context)!.bio,
            hint: Strings.of(context)!.bio,
            minLine: 5,
            validator: (String? value) => value != null
                ? (value.isEmpty ? Strings.of(context)!.errorEmptyField : null)
                : null,
          ),
          SpacerV(value: Dimens.size20),
          Button(
            title: Strings.of(context)!.save,
            color: Theme.of(context).extension<CustomColor>()?.primary,
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                onSend?.call();
              }
            },
          ),
          SpacerV(value: Dimens.size20),
        ],
      ),
    );
  }
}
