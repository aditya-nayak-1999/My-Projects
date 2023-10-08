import 'package:flutter/material.dart';

void main() {
  UserInfo userInfo = UserInfo(
    name: 'John Doe',
    position: 'Software Engineer',
    company: 'ACME Enterprises',
    phone: '(312) 555-1212',
    email: 'john.doe@acme.com',
    address1: '10 W 31st St.',
    address2: 'Chicago, IL 60616',
    education: [
      EducationInfo(logo: 'assets/images/highschool-logo.png', name: 'Riverdale High', gpa: 4.0),
      EducationInfo(logo: 'assets/images/university-logo.png', name: 'Illinois Tech, B.S. in C.S.', gpa: 3.8)
    ],
    projects: [
      ProjectInfo(name: 'Profile App', logo: 'assets/images/project1-logo.png'),
      ProjectInfo(name: 'Food App', logo: 'assets/images/project2-logo.png'),
      ProjectInfo(name: 'Dating App', logo: 'assets/images/project3-logo.png'),
      ProjectInfo(name: 'Streaming App', logo: 'assets/images/project4-logo.png'),
      ProjectInfo(name: 'Shopping App', logo: 'assets/images/project5-logo.png')
    ]
  );

  runApp(MaterialApp(home: UserInfoPage(userInfo: userInfo)));
}

//User Info
class UserInfo {
  final String name, position, company, phone, email, address1, address2;
  final List<EducationInfo> education;
  final List<ProjectInfo> projects;

  UserInfo({
    required this.name,
    required this.position,
    required this.company,
    required this.phone,
    required this.email,
    required this.address1,
    required this.address2,
    required this.education,
    required this.projects,
  });
}

//Education Info
class EducationInfo {
  final String logo, name;
  final double gpa;

  EducationInfo({
    required this.logo,
    required this.name,
    required this.gpa,
  });
}

//Project Info
class ProjectInfo {
  final String name, logo;

  ProjectInfo({
    required this.name,
    required this.logo,
  });
}

//User Info Page
class UserInfoPage extends StatelessWidget {
  final UserInfo userInfo;

  UserInfoPage({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: ListView(
        children: [
          ProfileSection(userInfo: userInfo),
          ContactSection(userInfo: userInfo),
          EducationSection(educationInfo: userInfo.education),
          ProjectsSection(projects: userInfo.projects),
        ],
      ),
    );
  }
}

//Profile section
class ProfileSection extends StatelessWidget {
  final UserInfo userInfo;

  ProfileSection({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Row(
        children: [
          Image.asset('assets/images/profile.jpg', width: 100),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userInfo.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(userInfo.position),
                SizedBox(height: 5),
                Text(userInfo.company),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//Education Section
class EducationSection extends StatelessWidget {
  final List<EducationInfo> educationInfo;

  EducationSection({required this.educationInfo});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Education', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for (var edu in educationInfo)
            Row(
              children: [
                Image.asset(edu.logo, width: 50),
                SizedBox(width: 10),
                Text(edu.name),
                Spacer(),
                Text('GPA: ${edu.gpa}'),
              ],
            ),
        ],
      ),
    );
  }
}

//Contact Section
class ContactSection extends StatelessWidget {
  final UserInfo userInfo;

  ContactSection({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 5),
              Text('${userInfo.phone}'),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.email),
              SizedBox(width: 5),
              Text('${userInfo.email}'),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 5),
              Expanded(child: Text('${userInfo.address1}, ${userInfo.address2}')),
            ],
          ),
        ],
      ),
    );
  }
}


//Project Section
class ProjectsSection extends StatelessWidget {
  final List<ProjectInfo> projects;

  ProjectsSection({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            spacing: 16, 
            runSpacing: 16, 
            children: projects.map((project) {
              return Column(
                children: [
                  Image.asset(project.logo, width: 50),
                  SizedBox(height: 5),
                  Text(project.name),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}