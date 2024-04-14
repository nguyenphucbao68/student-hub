class Proposal {
  //   @Column({ name: 'project_id', type: 'bigint' })
  // @ApiProperty({ description: 'projectId' })
  // projectId: number | string;

  // @Column({ name: 'student_id', type: 'bigint' })
  // @ApiProperty({ description: 'studentId' })
  // studentId: number | string;

  // @Column({ name: 'cover_letter' })
  // @ApiProperty({ description: 'coverLetter' })
  // coverLetter?: string;

  // @Column({ name: 'status_flag' })
  // @ApiProperty({ description: 'statusFlag' })
  // statusFlag: StatusFlag;

  // @Column({ name: 'disable_flag' })
  // @ApiProperty({ description: 'disableFlag' })
  // disableFlag: DisableFlag;

  // @ManyToOne(() => Project)
  // @JoinColumn({ name: 'project_id' })
  // project: Project;

  // @ManyToOne(() => Student)
  // @JoinColumn({ name: 'student_id' })
  // student: Student;
  int? projectId;
  int? studentId;
  String? coverLetter;
  String? statusFlag;
  String? disableFlag;

  Proposal(
      {this.projectId,
      this.studentId,
      this.coverLetter,
      this.statusFlag,
      this.disableFlag});
}
