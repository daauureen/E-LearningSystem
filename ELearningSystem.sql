-- Create database
CREATE DATABASE elearningsystem;
\c elearningsystem;

-- Admin table
CREATE TABLE admin (
                       adminid SERIAL PRIMARY KEY,
                       fname VARCHAR(150) NOT NULL,
                       lname VARCHAR(150),
                       email_id VARCHAR(250),
                       username VARCHAR(20) NOT NULL UNIQUE,
                       password VARCHAR(20),
                       gender VARCHAR(10),
                       picture BYTEA
);

INSERT INTO admin (fname, lname, email_id, username, password, gender)
VALUES ('Subhranshu', 'Patra', 'bongspatra@gmail.com', 'subha', '123', 'Male');


-- Student table
CREATE TABLE student (
                         stdid SERIAL PRIMARY KEY,
                         fname VARCHAR(150) NOT NULL,
                         lname VARCHAR(150),
                         email_id VARCHAR(250),
                         username VARCHAR(20) NOT NULL UNIQUE,
                         password VARCHAR(20),
                         gender VARCHAR(10),
                         registration_date DATE NOT NULL,
                         last_login TIMESTAMP,
                         picture BYTEA
);


-- Teacher table
CREATE TABLE teacher (
                         teacherid SERIAL PRIMARY KEY,
                         fname VARCHAR(150) NOT NULL,
                         lname VARCHAR(150),
                         email_id VARCHAR(250),
                         username VARCHAR(20) NOT NULL UNIQUE,
                         password VARCHAR(20),
                         gender VARCHAR(10),
                         registration_date DATE NOT NULL,
                         last_login TIMESTAMP,
                         picture BYTEA
);


-- Subjects
CREATE TABLE subjects (
                          subject_id SERIAL PRIMARY KEY,
                          name VARCHAR(150) NOT NULL UNIQUE,
                          adminid INT NOT NULL REFERENCES admin(adminid) ON DELETE CASCADE
);


-- Courses
CREATE TABLE courses (
                         course_id SERIAL PRIMARY KEY,
                         name VARCHAR(250) NOT NULL UNIQUE,
                         description VARCHAR(1000) NOT NULL,
                         content VARCHAR(3000) NOT NULL,
                         teacherid INT NOT NULL REFERENCES teacher(teacherid) ON DELETE CASCADE,
                         subject_id INT NOT NULL REFERENCES subjects(subject_id) ON DELETE CASCADE
);


-- Videos
CREATE TABLE videos (
                        video_id SERIAL,
                        title VARCHAR(250) NOT NULL,
                        link VARCHAR(1000) NOT NULL,
                        video_description TEXT NOT NULL,
                        upload_date DATE NOT NULL,
                        course_id INT NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
                        teacherid INT NOT NULL REFERENCES teacher(teacherid) ON DELETE CASCADE,
                        PRIMARY KEY (video_id, title)
);


-- PDFs
CREATE TABLE pdfs (
                      pdf_id SERIAL,
                      title VARCHAR(250) NOT NULL,
                      uploaded_file BYTEA NOT NULL,
                      upload_date DATE NOT NULL,
                      course_id INT NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
                      teacherid INT NOT NULL REFERENCES teacher(teacherid) ON DELETE CASCADE,
                      PRIMARY KEY (pdf_id, title)
);


-- Enrollments
CREATE TABLE enrollments (
                             enrollment_id SERIAL PRIMARY KEY,
                             enrollment_date DATE NOT NULL,
                             course_id INT NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
                             stdid INT NOT NULL REFERENCES student(stdid) ON DELETE CASCADE,
                             UNIQUE (course_id, stdid)
);


-- Messages
CREATE TABLE messages (
                          message_id SERIAL PRIMARY KEY,
                          message VARCHAR(2000) NOT NULL,
                          time_stamp TIMESTAMP NOT NULL,
                          user_id INT NOT NULL,
                          touser_id INT NOT NULL
);


-- MessageUsers
CREATE TABLE messageusers (
                              user_id INT NOT NULL,
                              message_id INT NOT NULL REFERENCES messages(message_id) ON DELETE CASCADE
);
