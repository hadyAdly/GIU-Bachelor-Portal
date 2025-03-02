create table Users(
user_id int identity,
Username varchar(100),
Password varchar(100),
Email varchar(100),
Role varchar(100),
Phone_number int,
Primary key(user_id)
);
create table Lecturer(
Lecturer_id int identity,
schedule varchar(100),
Primary key(Lecturer_id),
foreign key(Lecturer_id) references Users
);
create table LecturerFields(
Lecturer_id int identity,
field varchar(100),
Primary key(Lecturer_id,field),
foreign key(Lecturer_id) references Lecturer 
);
create table Company(
Company_id int identity,
Name varchar(100),
Representative_name varchar(100),
Representative_Email varchar(100),
Location varchar(100),
Primary key(Company_id),
foreign key(Company_id) references Users 
);
create table Employee(
Staff_id int identity,
Company_id int identity,
Username varchar(100),
Password varchar(100),
Email varchar(100),
Field varchar(100),
Phone int,
Primary key(Staff_id,Company_id),
foreign key(Company_id) references Company
);
create table External_Examiner(
EE_id int identity,
Schedule varchar(100),
Primary key(EE_id),
foreign key(EE_id) references Users
);
create table Teaching_Assistant(
TA_id int identity,
Schedule varchar(100),
Primary key(TA_id),
foreign key(TA_id) references Users
);
create table Coordinator(
coordinator_id int identity,
Primary key(coordinator_id),
foreign key(coordinator_id) references Users
);
create table Student(
sid int identity,
first_name varchar(100),
last_name varchar(100),
Major_code int,
Date_Of_Birth datetime,
Adress varchar(100),
Age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(Date_Of_Birth)),
Semester int,
GPA float,
TotalBachelorGrade AS((0.3*Thesis.Total_grade+0.3*Defense.Total_grade+ 0.4*ComulativeProgressReportGrade)),
Assigned_Project_code int,
Primary key(sid),
foreign key(sid) references Users,
foreign key(Major_code) references Major,
foreign key(Assigned_Project_code) references Bachelor_Project
);
create table Bachelor_Project(
Code int,
Name varchar(100),
Submitted_Materials varchar(100),
Description varchar(100),
Primary key(Code)
);
create table BachelorSubmittedMaterials(
Code int,
Material varchar(100),
Primary key(Code),
foreign key(Code) references Bachelor_Project
);
create table Academic(
Academic_code int,
L_id int identity,
TA_id int identity,
EE_id int identity,
Primary key(Academic_code),
foreign key(Academic_code) references Bachelor_Project,
foreign key(L_id) references Lecturer,
foreign key(TA_id) references Teaching_Assistant,
foreign key(EE_id) references External_Examiner
);
create table Industrial(
Industrial_code int,
C_id int identity,
L_id int identity,
E_id int identity,
Primary key(Industrial_code),
foreign key(Industrial_code) references Bachelor_Project,
foreign key(C_id) references Company,
foreign key(L_id) references Lecturer,
foreign key(E_id) references Employee
);
create table Faculty(
Faculty_Code int,
Name varchar(100),
Dean varchar(100),
Primary key(Faculty_Code),
foreign key(Dean) references Lecturer
);
create table Major(
Major_Code int,
Faculty_code int,
Major_Name varchar(100),
Primary key(Major_Code),
foreign key(Faculty_code) references Faculty
);
create table Meeting(
Meeting_ID int identity,
L_id int identity,
STime float,
ETime float,
Duration As (Meeting.ETime – Meeting.STime),
Date datetime,
Meeting_Point varchar(100),
Primary key(Meeting_ID),
foreign key(L_id) references Lecturer
);
create table MeetingToDoList(
Meeting_ID int identity,
ToDoList varchar(100),
Primary key(Meeting_ID,ToDoList),
foreign key(Meeting_ID) references Meeting
);
create table MeetingAttendents(
Meeting_ID int identity,
Attendant_id int identity,
Primary key(Meeting_ID,Attendant_id),
foreign key(Meeting_ID) references Meeting,
foreign key(Attendant_id) references Users
);
create table Thesis(
sid int identity,
Title varchar(100),
Deadline datetime,
PDF_doc varchar(100),
Total_grade As ((GradeAcademicThesis.EE_grade+GradeAcademicThesis.Lecturer_grade)/2 or 
(GradeIndustrialThesis.Company_grade And GradeIndustrialThesis.Employee_grade)/2),
Primary key(sid,Title),
foreign key(sid) references Student
);
create table Defense(
sid int identity,
Location varchar(100),
Content varchar(100),
Time time,
Date datetime,
Total_Grade As ((GradeAcademicDefense.EE_grade + GradeAcademicDefense.Lecturer_grade)/2 
or (GradeIndustrialDefense.Compay_grade+GradeIndustrialDefense.Employee_grade)/2),
Primary key(sid,Location),
foreign key(sid) references Student
);
create table ProgressReport(
sid int identity,
Date datetime,
Content varchar(100),
Grade AS (GradeAcademicPR.Lecturer_grade or GradeIndustrialPR.Company_grade),
UpdatingUser_id int identity,
ComulativeProgressReportGrade AS(Average ProgressReprt.grade),
Primary key(sid,Date),
foreign key(sid) references Student,
foreign key(UpdatingUser_id) references Users
);
create table GradeIndustrialPR(
C_id int identity,
sid int identity,
Date datetime,
Company_grade float,
Lecturer_grade float,
Primary key(sid,Date),
foreign key(C_id) references Company,
foreign key(sid) references ProgressReport,
foreign key(Date) references ProgressReport
);
create table GradeAcademicPR(
L_id int identity,
sid int identity,
Date datetime,
Lecturer_grade float,
Primary key(sid,Date),
foreign key(L_id) references Lecturer,
foreign key(sid) references ProgressReport,
foreign key(Date) references ProgressReport
);
create table GradeAcademicThesis(
L_id int identity,
EE_id  int identity,
sid int identity,
Title varchar(100),
EE_grade float,
Lecturer_grade float,
Primary key(sid,Title),
foreign key(L_id) references Lecturer,
foreign key(EE_id) references External_Examiner,
foreign key(sid) references Thesis,
foreign key(Title) references Thesis
);
create table GradeIndustrialThesis(
C_id int identity,
E_id int identity,
sid int identity,
Title varchar(100),
Company_grade float,
Employee_grade float,
Primary key(sid,Title),
foreign key(C_id) references Company,
foreign key(E_id) references Employee,
foreign key(sid) references Thesis,
foreign key(Title) references Thesis
);
create table GradeAcademicDefense(
L_id int identity,
EE_id int identity,
sid int identity,
Location varchar(100),
EE_grade float,
Lecturer_grade float,
Primary key(sid,Location),
foreign key(L_id) references Lecturer,
foreign key(EE_id) references External_Examiner,
foreign key(sid) references Defense,
foreign key(Location) references Defense
);
create table GradeIndustrialDefense(
C_id int identity,
E_id int identity,
sid int identity,
Location varchar(100),
Company_grade float,
Employee_grade float,
Primary key(sid,Location),
foreign key(C_id) references Company,
foreign key(E_id) references Employee,
foreign key(sid) references Defense,
foreign key(Location) references Defense
);
create table LecturerRecommendEE(
L_id int identity,
EE_id int identity,
PCode int,
Primary key(EE_id,PCode),
foreign key(L_id) references Lecturer,
foreign key(EE_id) references External_Examiner,
foreign key(PCode) references Academic
);
create table StudentPreferences(
sid int identity,
PCode int,
PreferenceNumber int,
Primary key(sid,PCode),
foreign key(sid) references Student,
foreign key(PCode) references Bachelor_Project
);
create table MajorHasBachelorProject(
Major_code int,
Project_code int,
Primary key(Major_code,Project_code),
foreign key(Major_code) references Major,
foreign key(Project_code) references Bachelor_Project
);