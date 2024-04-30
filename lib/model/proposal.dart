// class Proposal {
//   //   @Column({ name: 'project_id', type: 'bigint' })
//   // @ApiProperty({ description: 'projectId' })
//   // projectId: number | string;

//   // @Column({ name: 'student_id', type: 'bigint' })
//   // @ApiProperty({ description: 'studentId' })
//   // studentId: number | string;

//   // @Column({ name: 'cover_letter' })
//   // @ApiProperty({ description: 'coverLetter' })
//   // coverLetter?: string;

//   // @Column({ name: 'status_flag' })
//   // @ApiProperty({ description: 'statusFlag' })
//   // statusFlag: StatusFlag;

//   // @Column({ name: 'disable_flag' })
//   // @ApiProperty({ description: 'disableFlag' })
//   // disableFlag: DisableFlag;

//   // @ManyToOne(() => Project)
//   // @JoinColumn({ name: 'project_id' })
//   // project: Project;

//   // @ManyToOne(() => Student)
//   // @JoinColumn({ name: 'student_id' })
//   // student: Student;
//   int? projectId;
//   int? studentId;
//   String? coverLetter;
//   String? statusFlag;
//   String? disableFlag;

//   Proposal(
//       {this.projectId,
//       this.studentId,
//       this.coverLetter,
//       this.statusFlag,
//       this.disableFlag});
// }

import 'package:carea/model/project.dart';
import 'package:carea/model/student.dart';

class Proposal {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? projectId;
  int? studentId;
  String? coverLetter;
  int? statusFlag;
  int? disableFlag;
  Student? student;
  Project? project;
  Proposal({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.projectId,
    this.studentId,
    this.coverLetter,
    this.statusFlag,
    this.disableFlag,
    this.student,
    this.project,
  });

  Proposal parse(dynamic item) {
    return Proposal(
      id: item['id'],
      createdAt: item['createdAt'],
      updatedAt: item['updatedAt'],
      deletedAt: item['deletedAt'],
      projectId: item['projectId'],
      studentId: item['studentId'],
      coverLetter: item['coverLetter'],
      statusFlag: item['statusFlag'],
      disableFlag: item['disableFlag'],
      project: Project().tryParse(item['project']),
    );
  }

  Proposal parseWithStd(dynamic item) {
    return Proposal(
      id: item['id'],
      createdAt: item['createdAt'],
      updatedAt: item['updatedAt'],
      deletedAt: item['deletedAt'],
      projectId: item['projectId'],
      studentId: item['studentId'],
      coverLetter: item['coverLetter'],
      statusFlag: item['statusFlag'],
      disableFlag: item['disableFlag'],
      student: Student().tryParseWithFullname(item['student']),
    );
  }

  Proposal? tryParse(dynamic item) {
    if (item == null) return null;
    return Proposal().parse(item);
  }

  List<Proposal>? parseToList(dynamic item) {
    if (item == null) return null;
    return item.map<Proposal>((item) => Proposal().parse(item)).toList();
  }
}
