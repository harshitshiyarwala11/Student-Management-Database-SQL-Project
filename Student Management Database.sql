create table students (
student_id INT primary key,
name varchar(50),
gender char(1),
age INT,
grade varchar(2),
mathscore INT,
sciencescore INT,
englishscore INT
);

INSERT INTO students (student_id, name, gender, age, grade, mathscore, sciencescore, englishscore) VALUES
(1, 'Raj Patel', 'M', 15, 'A', 88, 91, 85),
(2, 'Nikul Parmar', 'M', 14, 'A', 92, 89, 90),
(3, 'Ram Kumar', 'M', 16, 'B', 76, 81, 74),
(4, 'Shivanu Mangrulkar', 'F', 15, 'A', 90, 93, 88),
(5, 'Mohit Mehta', 'M', 14, 'C', 65, 68, 70),
(6, 'Muskan Rathod', 'F', 15, 'B', 78, 82, 80),
(7, 'Arjun Rathod', 'M', 16, 'B', 81, 79, 77),
(8, 'Khushi Parmar', 'F', 14, 'A', 95, 94, 92),
(9, 'Rohan Verma', 'M', 15, 'C', 69, 72, 68),
(10, 'Pooja Sharma', 'F', 16, 'B', 84, 86, 83),
(11, 'Aditya Nair', 'M', 15, 'A', 91, 88, 89),
(12, 'Babita Iyer', 'F', 14, 'A', 89, 92, 90),
(13, 'Manav Gupta', 'M', 16, 'C', 62, 65, 67),
(14, 'Neha Choudhary', 'F', 15, 'B', 80, 78, 82),
(15, 'Kunal Singh', 'M', 14, 'B', 83, 85, 81),
(16, 'Aditi Mishra', 'F', 16, 'A', 94, 90, 93),
(17, 'Rahul Bansal', 'M', 15, 'C', 70, 73, 69),
(18, 'Meera Kapoor', 'F', 14, 'A', 88, 91, 87),
(19, 'Sahil Khanna', 'M', 16, 'B', 79, 82, 78),
(20, 'Nidhi Agarwal', 'F', 15, 'A', 93, 95, 91);

/* Show all details */
select * from students
/* to find all the details from the table we will simply use "*" to get all the results */


/* Average score in each subject */
select round(avg(mathscore), 2) as avg_math, round(avg(sciencescore), 2) as avg_science, round(avg(englishscore), 2) as avg_english
from students
/* To find the average score of student in each subject we have used "avg" aggregate function we have also used "round" function
to get the results with decimal value up to 2 decimals */
/* with the results we found that student's best performance came in science followed by math and english, though there is
 big difference between the average results of all the 3 subjects */


/* Top performer */
with best_student as (select student_id, name, gender, sum(mathscore + sciencescore + englishscore) as total_score from students
group by student_id, name)
select  Row_number() over (order by total_score desc) as best_student, student_id, name, gender, total_score from best_student
/* To get the results for the top performer we have used "row_number" function to get the ranking of students as per the total number
of marks scored from the summation of all the 3 subjects, we have also used Cte here to create a temporary table for total score from 
all the 3 subjects */
/* with the results we found that female gender has performed well, we also get an insight that the top 13 performers have scored
marks more than 80% and top 10 have scored more than 250 marks out of 300 */


/* Count students per grade */
select  grade , count(student_id) from students
group by grade
order by grade asc
/* to get the results for the grade count, we have used "count" aggregate function */
/* from the results we can see that 30% of students have scored grade A, only 4 student have scored grade C */


/* Average score by gender */
with gender_score as (select student_id, gender, sum(mathscore + sciencescore + englishscore) as total_score from students
group by student_id, gender)
select gender, round(avg(total_score), 2) from gender_score
group by gender
/* to get the results for average score by gender we have again used the Cte to create a temporary table where we can the total score
from all the subjects, after that we have used "avg" aggregate function to get the final result with 2 decimal place using "round" function
notice that we also need to select the primary key here to get the optimal results */
/* from the results we found that females average score is more compare to males, which we were also able to find in our one of the
previous insights where, top 5 student with best score were females */


/* Students with mathscore > 80 */
select student_ID, name, mathscore from students
where mathscore > 80
/* to get the results for maths score greater than 80 we have used where function to find the score of maths which is more than 80 */
/* from the insight we found that 12 students have scored more than 80 in Math */


/* update the grades of students */
update students 
set grade = case 
when (mathscore + sciencescore + englishscore)/3 >= 90 then 'A'
when (mathscore + sciencescore + englishscore)/3 >= 80 then 'B'
when (mathscore + sciencescore + englishscore)/3 >= 70 then 'C'
else 'D'
end
/* to update the grade of students, we have used to update function along with case when function to group the gardes as per the 
marks scored */

