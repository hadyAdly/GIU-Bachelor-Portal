CREATE proc AddEmployee
@CompanyID int output,@email varchar(50),@name varchar(20),@phone_number varchar(20),@field varchar(25),
@StaffID int output,
@pass varchar(10) output
AS
IF (SELECT Company_id FROM Company WHERE Company_id=@CompanyID ) is not null
begin
set @pass= @StaffId
select @StaffID =max(staff_id) from Employee
INSERT into Employee(staff_id,Company_id,Username,Password,Email,Field,Phone)
VALUES(@StaffID,@CompanyID,@name,@pass,@email,@field,@phone_number)

end
ELSE
PRINT 'there is no company ny that name';
go
/*to be investigated......detective conan ys3a da2eman*/
CREATE proc CompanyCreateLocalProject
@company_id int,@proj_code varchar(10),@title varchar(50),@description varchar(200),@major_code varchar(10)
AS
INSERT into Bachelor_Project(Name,Description)
VALUES(@title,@description)
INSERT into MajorHasBachelorProject(Major_code,Project_code)
VALUES (@major_code,@proj_code)
INSERT into Industrial(Industrial_code,C_id)
VALUES(@proj_code,@company_id)
go
CREATE proc AssignEmployee
@bachelor_code varchar(10),@staff_id int output, @Company_id int
AS
UPDATE Industrial 
SET E_id=@staff_id
WHERE C_id=@Company_id and Industrial_code=@bachelor_code
go
/*grades are to be revised since they don't make any utter sense rn*/
CREATE proc CompanyGradeThesis
@Company_id int,@sid int ,@date datetime,@Company_grade Decimal(4,2),@thesis_title varchar(50)
AS
UPDATE Thesis
SET Total_Grade =(GradeIndustrialThesis.grade&GradeIndustrialThesis.Employee_grade)/2
WHERE sid =@sid and Title= @thesis_title
go
CREATE proc CompanyGradeDefense
@Company_id int,@sid int ,@date datetime,@Company_grade Decimal(4,2),@defense_location varchar(5)
AS
UPDATE Defense
SET Total_Grade =(GradeIndustrialDefense.Compay_grade+GradeIndustrialDefense.Employee_grade)/2
WHERE sid =@sid and Location= @defence_location
go
CREATE proc CompanyGradePR
@Company_id int ,@sid int , @date datetime,@Company_grade decimal(4,2)
AS
UPDATE ProgressReport 
SET ComulativeProgressReportGrade = calculated(Average ProgressReprt.grade),Grade= Calculated(GradeAcademicPR.Lecturer_grade or
GradeIndustrialPR.Company_grade)
WHERE sid=@sid and Date =date
go
CREATE proc TACreatePR
@TA_id int ,@sid int ,@date datetime,@content varchar(1000)
AS
INSERT into ProgressReport(sid,Date,Content)
VALUES(@sid,@date,@content)
go
CREATE proc TAAddToDO
@meeting_id int ,@to_do_list varchar(200)
AS
UPDATE MeetingToDoList
SET ToDoList= @to_do_list
WHERE Meeting_ID =@meeting_id
go
CREATE proc ViewUsers
@User_type varchar(20),@User_id int
AS
IF @User_type is not null and @User_id is not null
begin
SELECT* From Users
WHERE user_id=@User_id and Role=@User_type
end
ELSE
IF @User_id is null
begin
SELECT* FROM Users
WHERE Role=@User_type
end
ELSE
begin
SELECT* FROM Users
WHERE user_id=@User_id
end
go
CREATE proc AssignAllStudentsToLocalProject
AS
SELECT Student.sid,Bachelor_Project.*
FROM Student INNER JOIN Bachelor_Project
ON Student.Assigned_Project_code=Bachelor_Project.Code
go
/*why the fuck does it give coordinator id*/
CREATE proc AssignTAs
@coordinator_id int ,@TA_id int ,@proj_code varchar(10)
UPDATE Bachelor_Project
SET 
WHERE
go
CREATE proc ViewRecommendation
@lecture_id int 
AS
IF @lecture_id is null
SELECT* FROM LecturerRecommendEE
ELSE
BEGIN
SELECT* FROM LecturerRecommendEE
WHERE L_id=@lecture_id
END
go
CREATE proc AssignEE
@coordinator_id int , @EE_id int ,@proj_code varchar(10)
AS
IF (SELECT PCode FROM LecturerRecommendEE)=@proj_code and (SELECT EE_id FROM LecturerRecommendEE)=@EE_id
begin
UPDATE Academic
SET EE_id=@EE_id
WEHRE Academic_code=@proj_code
go 
CREATE proc ScheduleDefense
@sid int ,@data datetime,@time time,@location varchar(5)
AS
INSERT into Defense(sid,Location,Time,Date)
VALUES(@sid,@location,@time,@data)
go