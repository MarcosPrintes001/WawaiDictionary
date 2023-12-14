// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class TeamMember {
  final String name;
  final String role;
  final String imageMember;

  TeamMember({
    required this.name,
    required this.role,
    required this.imageMember,
  });
}

class TeamPage extends StatelessWidget {
  final List<TeamMember> teamMembers = [
    TeamMember(
        name: 'Nome Colaborador', role: 'Função', imageMember: ''),
    TeamMember(
      name: 'Marcos Printes',
      role: 'Desenvolvedor Mobile',
      imageMember: '',
    ),
    TeamMember(
        name: 'Nome Colaborador', role: 'Função', imageMember: ''),
    TeamMember(
        name: 'Nome Colaborador', role: 'Função', imageMember: ''),
    TeamMember(
        name: 'Nome Colaborador', role: 'Função', imageMember: ''),
    TeamMember(
        name: 'Nome Colaborador', role: 'Função', imageMember: ''),
  ];

  TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: teamMembers.length,
      itemBuilder: (context, index) {
        return buildTeamMemberCard(teamMembers[index]);
      },
    );
  }

  Widget buildTeamMemberCard(TeamMember member) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30.0,
          backgroundImage: '' == member.imageMember
              ? AssetImage(member.imageMember)
              : const AssetImage('assets/tapotaLogo.png'),
        ),
        title: Text(member.name),
        subtitle: Text(member.role),
      ),
    );
  }
}
