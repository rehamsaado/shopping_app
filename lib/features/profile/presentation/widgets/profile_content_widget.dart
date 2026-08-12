import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shopping_app/core/localization/app_strings.dart';
import '../../domain/entity/profile_entity.dart';
import 'profile_header_widget.dart';
import 'profile_section_widget.dart';
import 'profile_info_row_widget.dart';

class ProfileContentWidget extends StatelessWidget {
  final ProfileEntity profile;

  const ProfileContentWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final fullName = '${profile.name.firstname} ${profile.name.lastname}';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileHeaderWidget(fullName: fullName, email: profile.email),
          const SizedBox(height: 32),
          ProfileSectionWidget(
            title: context.tr('account_info'),
            children: [
              ProfileInfoRowWidget(
                icon: Icons.person_outline,
                label: context.tr('username'),
                value: profile.username,
              ),
              ProfileInfoRowWidget(
                icon: Icons.email_outlined,
                label: context.tr('email'),
                value: profile.email,
              ),
              ProfileInfoRowWidget(
                icon: Icons.phone_outlined,
                label: context.tr('phone'),
                value: profile.phone,
              ),
            ],
          ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 24),
          ProfileSectionWidget(
            title: context.tr('personal_name'),
            children: [
              ProfileInfoRowWidget(
                icon: Icons.badge_outlined,
                label: context.tr('first_name'),
                value: profile.name.firstname,
              ),
              ProfileInfoRowWidget(
                icon: Icons.badge_outlined,
                label: context.tr('last_name'),
                value: profile.name.lastname,
              ),
            ],
          ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 24),
          ProfileSectionWidget(
            title: context.tr('address'),
            children: [
              ProfileInfoRowWidget(
                icon: Icons.location_city_outlined,
                label: context.tr('city'),
                value: profile.address.city,
              ),
              ProfileInfoRowWidget(
                icon: Icons.streetview_outlined,
                label: context.tr('street'),
                value: profile.address.street,
              ),
              ProfileInfoRowWidget(
                icon: Icons.confirmation_number_outlined,
                label: context.tr('building_number'),
                value: profile.address.number.toString(),
              ),
              ProfileInfoRowWidget(
                icon: Icons.markunread_mailbox_outlined,
                label: context.tr('zip_code'),
                value: profile.address.zipcode,
              ),
            ],
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}