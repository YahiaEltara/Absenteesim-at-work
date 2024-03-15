
-- Create a join table
Select * from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number ;

-- Find the healthiest employees for the bonus
Select * from Absenteeism_at_work
where Social_drinker = 0 and Social_drinker = 0 and Body_mass_index < 25 and
Absenteeism_time_in_hours < (Select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work) ;

-- Compensation rate increase for nonsmokers
-- (Budget $983,221) , [(2,080 Hours/Year) (320 Nonsmokers) = 665,600 H/Y]
--        >> $1.47/H   or  >> $3,072.56/Y
Select count(*) as Nonsmokers from Absenteeism_at_work
Where Social_drinker = 0

-- optimize this query
Select
a.ID, r.Reason, Month_of_absence, Body_mass_index,
	CASE WHEN Body_mass_index < 18.5 THEN 'Under Weight'
		 WHEN Body_mass_index Between 18.5 AND 25 THEN 'Healthy Weight'
		 WHEN Body_mass_index Between 25 AND 30 THEN 'Over Weight'
		 WHEN Body_mass_index > 18.5 THEN 'Obese'
		 ELSE 'Unkown' END AS BMI_Category,
	CASE WHEN Month_of_absence IN(12,1,2) THEN 'Winter'
		 WHEN Month_of_absence IN(3,4,5) THEN 'Spring'
		 WHEN Month_of_absence IN(6,7,8) THEN 'Summer'
		 WHEN Month_of_absence IN(9,10,11) THEN 'Fall'
		 ELSE 'Unkown' END AS Season_NA,
Seasons, Month_of_absence, Day_of_the_week,Transportation_expense,
Education,Son,Social_drinker,Social_smoker,Pet,Disciplinary_failure,
Age,Work_load_Average_day,Absenteeism_time_in_hours
From Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r
on a.Reason_for_absence = r.Number ;