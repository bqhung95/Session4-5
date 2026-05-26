CREATE DATABASE Employee_Payroll_Management;
CREATE SCHEMA Employee_Payroll;
CREATE TABLE Employee_Payroll.Employees(
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    department VARCHAR(10) NOT NULL,
    position VARCHAR(20) NOT NULL,
    salary INT,
    bonus INT,
    join_year INT NOT NULL
);

INSERT INTO Employee_Payroll.Employees(full_name, department, position, salary, bonus, join_year)
VALUES ('Nguyễn Văn Huy','IT','Developer','18000000','1000000','2021'),
       ('Trần Thị Mai','HR','Recruiter','12000000',NULL,'2020'),
       ('Lê Quốc Trung','IT','Tester','15000000','800000','2023'),
       ('Nguyễn Văn Huy','IT','Developer','18000000','1000000','2021'),
       ('Phạm Ngọc Hân','Finance','Accountant','14000000',NULL,'2019'),
       ('Bùi Thị Lan','HR','HR Manager','20000000','3000000','2018'),
       ('Đặng Hữu Tài','IT','Developer','17000000',NULL,'2022');
SELECT * FROM Employee_Payroll.Employees;

--- 1. Xóa các bản ghi trùng nhau hoàn toàn về tên, phòng ban và vị trí
--- Chưa giải được

--- 2. Cập nhật lương thưởng
--- a. Tăng 10% lương cho những nhân viên làm trong phòng IT có lương dưới 18000000
--- b. Với nhân viên có bonus IS NULL, đặt giá trị bonus = 500000
UPDATE Employee_Payroll.Employees
SET salary = salary * 1.10
WHERE department = 'IT' AND salary < 18000000;

UPDATE Employee_Payroll.Employees
SET bonus = '500000'
WHERE bonus IS NULL;

--- 3. Hiển thị danh sách nhân viên thuộc phòng IT hoặc HR, gia nhập sau năm 2020 và
-- có tổng thu nhập ( salary + bonus ) lớn hơn 15000000
-- Chỉ lấy 3 nhân viên đầu tiên sau khi sắp xếp giảm dần theo tổng thu nhập
SELECT employee_id, full_name, department, position, salary, bonus, join_year, (salary + bonus) AS Total
FROM Employee_Payroll.Employees
WHERE department IN ('IT','HR')
AND join_year > 2020
AND (salary + bonus) > 15000000
ORDER BY Total DESC
LIMIT 3;

--- 4. Tìm tất cả nhân viên có tên bắt đầu bằng Nguyễn hoặc kết thúc bằng Hân
SELECT full_name
FROM Employee_Payroll.Employees
WHERE full_name LIKE 'Nguyễn%' OR full_name LIKE '%Hân';

--- 5. Liệt kê các phòng ban duy nhất có ít nhất 1 nhân viên có bonus IS NOT NULL
SELECT DISTINCT department
FROM Employee_Payroll.Employees
WHERE bonus IS NOT NULL;


--- 6. hiển thị nhân viên gia nhập khoảng 2019 - 2022
SELECT employee_id, full_name, position, salary, bonus, join_year
FROM Employee_Payroll.Employees
WHERE join_year BETWEEN 2019 AND 2020;
