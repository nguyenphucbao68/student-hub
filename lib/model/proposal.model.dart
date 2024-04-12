import 'package:carea/commons/constants.dart';

class ProposalModel {
  String id;
  String studentName;
  String yearInfo;
  String role;
  String skill;
  String coverLetter;
  HIRE_STATUS hireStatus;

  ProposalModel({
    required this.id,
    required this.studentName,
    required this.yearInfo,
    required this.skill,
    required this.role,
    required this.coverLetter,
    required this.hireStatus,
  });

  static List<ProposalModel> getReadyToHireProposals() {
    return [
      ProposalModel(
          id: '1',
          studentName: 'John Doe',
          yearInfo: '4th year student',
          skill: 'Excellent',
          role: 'Fullstack Engineer',
          coverLetter:
              'I have gone through your project and it seem like a great project. I will commit for your project...',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '2',
          studentName: 'Alice Smith',
          yearInfo: 'Final year student',
          skill: 'Proficient',
          role: 'Backend Developer',
          coverLetter:
              'I am excited about your project and confident in my ability to contribute effectively. Let’s discuss the details!',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '3',
          studentName: 'Michael Johnson',
          yearInfo: '3rd year student',
          skill: 'Skilled',
          role: 'UI/UX Designer',
          coverLetter:
              'I am passionate about creating intuitive user experiences and would love to bring my expertise to your project.',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '4',
          studentName: 'Emily Brown',
          yearInfo: 'Final year student',
          skill: 'Excellent',
          role: 'Data Scientist',
          coverLetter:
              'With a strong background in data analysis, I am excited to apply my skills to your project and deliver meaningful insights.',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '5',
          studentName: 'David Lee',
          yearInfo: 'Graduated',
          skill: 'Proficient',
          role: 'Mobile App Developer',
          coverLetter:
              'I have hands-on experience in mobile app development and am eager to contribute to your project right away.',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '6',
          studentName: 'Sophia Garcia',
          yearInfo: 'Final year student',
          skill: 'Skilled',
          role: 'Frontend Developer',
          coverLetter:
              'I have a keen eye for design and a strong grasp of frontend technologies. I would love to collaborate on your project.',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '7',
          studentName: 'Robert Clark',
          yearInfo: '3rd year student',
          skill: 'Excellent',
          role: 'AI Engineer',
          coverLetter:
              'I am fascinated by machine learning and eager to apply my knowledge to real-world challenges. Let’s make your project a success!',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '8',
          studentName: 'Lily Anderson',
          yearInfo: 'Graduated',
          skill: 'Proficient',
          role: 'Software Engineer',
          coverLetter:
              'Having recently graduated, I am equipped with the latest skills and techniques needed for your project.',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '9',
          studentName: 'Daniel Martinez',
          yearInfo: 'Final year student',
          skill: 'Skilled',
          role: 'DevOps Engineer',
          coverLetter:
              'I am well-versed in continuous integration and deployment. Let me help streamline your project’s development process.',
          hireStatus: HIRE_STATUS.ready_to_hire),
      ProposalModel(
          id: '10',
          studentName: 'Olivia White',
          yearInfo: '2nd year student',
          skill: 'Proficient',
          role: 'Cybersecurity Analyst',
          coverLetter:
              'Cybersecurity is my passion. I am ready to contribute to securing your project and ensuring its safety.',
          hireStatus: HIRE_STATUS.ready_to_hire)
    ];
  }

  static List<ProposalModel> getHiredProposals() {
    return [
      ProposalModel(
          id: '11',
          studentName: 'Sarah Johnson',
          yearInfo: 'Graduated',
          skill: 'Excellent',
          role: 'Backend Engineer',
          coverLetter:
              'I have extensive experience in backend development and am ready to contribute to your project immediately.',
          hireStatus: HIRE_STATUS.hired),
      ProposalModel(
          id: '12',
          studentName: 'Matthew Taylor',
          yearInfo: 'Final year student',
          skill: 'Proficient',
          role: 'Data Analyst',
          coverLetter:
              'I have a strong analytical background and am excited to apply my skills to your project’s data needs.',
          hireStatus: HIRE_STATUS.hired),
      ProposalModel(
          id: '13',
          studentName: 'Emma Brown',
          yearInfo: 'Graduated',
          skill: 'Skilled',
          role: 'UI Designer',
          coverLetter:
              'I specialize in creating clean and intuitive user interfaces. Let me help bring your project to life.',
          hireStatus: HIRE_STATUS.hired),
      ProposalModel(
          id: '14',
          studentName: 'James Anderson',
          yearInfo: '3rd year student',
          skill: 'Excellent',
          role: 'Frontend Developer',
          coverLetter:
              'I am passionate about frontend development and eager to contribute my skills to your project’s user experience.',
          hireStatus: HIRE_STATUS.hired)
    ];
  }
}
