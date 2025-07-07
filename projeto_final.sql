/* Challenge:
For your challenge take into consideration the database schema and the records below:
*/

DROP DATABASE IF EXISTS school_management;
CREATE DATABASE school_management;
USE school_management;

CREATE TABLE classes(
    id INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE subjects(
    id INTEGER AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE teachers(
    id INTEGER AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    subject_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

CREATE TABLE students(
    id INTEGER AUTO_INCREMENT,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    birth_date DATE,
    class_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(class_id) REFERENCES classes(id) ON DELETE SET NULL
);

INSERT INTO classes (id) VALUES
(1), (2), (3);

INSERT INTO subjects (name) VALUES
('Math'), ('Science'), ('History'), ('English');

INSERT INTO teachers (name, subject_id) VALUES
('John Doe', 1), ('Alice Smith', 2), ('Michael Johnson', 3), ('Emily Brown', 4),
('David Lee', 1), ('Sarah Adams', 2), ('Robert Davis', 3), ('Jennifer Wilson', 4);

INSERT INTO teachers (name) VALUES ('John Smith');

INSERT INTO students (first_name, last_name, birth_date, class_id) VALUES
('Emma', 'Smith', '2010-05-15', 1),
('James', 'Johnson', '2009-08-20', 1),
('Olivia', 'Brown', '2011-02-10', 2),
('William', 'Wilson', '2010-11-25', 3),
('Sophia', 'Davis', '2012-04-05', 3);

/* Task 1 (20 pts). Take the following information into consideration:
"School info: After 5th grade, each student will enroll in one class.
Each class will have a great deal of teachers to teach a different subject.
Each teacher can teach in more than one class."

Rethink the database schema to translate the relationship between classes and teachers
and don't forget referential actions.
*/

-- Answer 1: Do the necessary changes below:



CREATE TABLE teachers_classes(
id_class INT NOT NULL,
id_teacher INT,
id_subject INT NOT NULL,
PRIMARY KEY(id_class,id_teacher, id_subject),
FOREIGN KEY (id_class) REFERENCES classes(id) ON DELETE CASCADE,
FOREIGN KEY (id_teacher) REFERENCES teachers(id) ON DELETE CASCADE,
FOREIGN KEY (id_subject) REFERENCES subjects(id) ON DELETE CASCADE
);


/* Task 2 (10 pts). Add at least 8 records to your changed schema to connect classes and teachers. */

-- Answer 2: Add the statement below:

INSERT INTO teachers_classes (id_class, id_teacher, id_subject) VALUES
(1,1,1),
(2,2,2),
(3,3,3),
(1,4,4),
(2,5,1),
(3,6,2),
(2,7,3),
(2,8,4);


/* Task 3 (20 pts). Show the name of the teachers who teach History in this school (using aliases) */

-- Answer 3: Add the query below:

SELECT t.name AS teacher_name, s.name AS subject_name
FROM teachers t
JOIN subjects s
ON s.id = t.subject_id
WHERE s.id=3;   /*Aqui podias usar s.name = History*/


/* Task 4 (25 pts). Show the teachers' name and the subject they teach even when they are not assigned to a subject yet */

-- Answer 4: Add the query below:
USE school_management;
SELECT t.name AS teacher_name, s.name AS subject_name
FROM teachers t
LEFT JOIN subjects s
ON s.id = t.subject_id;


/* Task 5 (25 pts). Create a view called "class_subject_teacher_view" to show the teacher who gives each subject to a class.
Project the subject's name, the class id and teacher's name.
*/

-- Answer 5: Create and show the view below:

CREATE VIEW class_subject_teacher_view AS
SELECT t.name AS teacher_name, s.name AS subject_name, c.id
FROM teachers_classes tc
JOIN subjects s
	ON tc.id_subject = s.id
JOIN classes c
	ON tc.id_class=c.id
JOIN teachers t
	ON tc.id_teacher=t.id;

SELECT * FROM class_subject_teacher_view;


/* Task 6 (extra points - optional). Count the number of students in each class (10 pts) */

-- Answer 6: Add the query below:

SELECT c.id AS class_number, COUNT(s.id) AS student_number
FROM classes AS c, students AS s
WHERE s.class_id=c.id
GROUP BY c.id;
