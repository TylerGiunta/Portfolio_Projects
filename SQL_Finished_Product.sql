/* Bellabeat Data Analysis 
	Step 1 Cleaning the data- Merge like sheets in excel by combining like measures, I used hourlyCalories, hourlyIntensities, and hourlySteps. Megered by using the Mergesheets Google Add-on
		Went through sheets cleaning out all duplicate, missing, and improper cases through excel. 
		Reanamed new sheet steps_intensity_calorie_by_hour and added it to a new folder called clean data
		Uploaded flat files to Microsoft SQL Server Management Studio under table names-
		dailyActivity_0813
		Heartrate_seconds
		minuteMETsNarrow
		minuteSleep_0813
		Sleep_day
		weightLoginfo
		Selected the top 1000 rows to make sure the import went smoothly */

		SELECT TOP(1000) *
		FROM [dbo].[daily_activity_cleaned]

		--Create a new clean database by changing string data to floats and integers
				
		CREATE TABLE bellabeat.dbo.daily_activity_cleaned
			(Id FLOAT, ActivityDate DATETIME2(7), TotalSteps INT, TotalDistance FLOAT, VeryActiveDistance FLOAT, ModeratelyActiveDistance FLOAT, 
			LightActiveDistance FLOAT, SedentaryActiveDistance FLOAT, VeryActiveMinutes INT, FairlyActiveMinutes INT, LightlyActiveMinutes INT, 
			SedentaryMinutes INT, Calories FLOAT,)

			--Insert the data into the new database
				
		INSERT INTO bellabeat.dbo.daily_activity_cleaned
			(Id,ActivityDate, TotalSteps, TotalDistance, VeryActiveDistance, ModeratelyActiveDistance, LightActiveDistance, SedentaryActiveDistance, VeryActiveMinutes,
			FairlyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes, Calories)
				
		--Changing data to float
				
		SELECT 
			Id,
			ActivityDate,
			TotalSteps,
			CAST(TotalDistance AS FLOAT) AS TotalDistance,
			CAST(VeryActiveDistance AS FLOAT) AS VeryActiveDistance,
			CAST(ModeratelyActiveDistance AS FLOAT) AS ModeratelyActiveDistance,
			CAST(LightActiveDistance AS FLOAT) AS LightActiveDistance,
			CAST(SedentaryActiveDistance AS FLOAT) AS SedentaryActiveDistance,
				VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes,
				SedentaryMinutes, Calories
			FROM bellabeat.dbo.dailyActivity
				
		--Ran into the error of a duplicate table, had to run
				
			IF EXISTS(SELECT*
				FROM bellabeat.dbo.daily_activity_cleaned)
				DROP TABLE bellabeat.dbo.daily_activity_cleaned

		/*At the beginning of the prompt to be able to create the new table 

		Save Query as Cleaning_daily_activity

		Repeat and clean weightLogInfo database setting Id and WeightKg as FLOAT and Date as DATETIME2(7) */

	/*Step 2 Analysis
		Find out basic information about the data.
		Number of Users
		Average, Minimum, and Maximum Heartrate
		Average, Minimum, and Miximum Hours Asleep
		Average, Minimum, Maximum Weight
		Average Steps
		Average Distance
		Average Calories
		Average Active Minutes- Average Active Hours
		
		1) Tracking their physical activities and number of users
		Number of Users 33
		Average Steps 7637
		Average Distance 5.48
		Average Calories 2303.61*/

		SELECT 
			COUNT(DISTINCT Id) AS users_tracking_activity,
			AVG(TotalSteps) AS average_steps,
			AVG(TotalDistance) AS average_distance,
			AVG(Calories) AS average_calories
		FROM bellabeat.dbo.daily_activity_cleaned

		/*2) Tracking Heart Rate
		Users Tracking Heartrate 14
		Average Heartrate 77BPM
		Minimum Heartrate 36BPM
		Maximum Heartrate 203BPM*/
				
		SELECT 
			COUNT(DISTINCT Id) AS users_tracking_heartRate,
			AVG(Value) AS average_heartrate,
			MIN(Value) AS minimum_heartrate,
			MAX(Value) AS maximum_heartrate
		FROM bellabeat.dbo.heartrate_seconds

		/*3) Tracking Sleep
		Users Tracking Sleep 24
		Average Hours of Sleep 6.98
		Minimum Hourse of Sleep 13.26
		Average Hours in Bed 7.63*/
				
		SELECT 
			COUNT(DISTINCT Id) AS users_tracking_sleep,
			AVG(TotalMinutesAsleep)/60.0 AS average_hours_asleep,
			MIN(TotalMinutesAsleep)/60.0 AS minimum_hours_asleep,
			MAX(TotalMinutesAsleep)/60.0 AS maximum_hours_asleep,
			AVG(TotalTimeInBed)/60.0 AS average_hours_inBed
		FROM bellabeat.dbo.sleep_day

		/*4) Tracking Weight
		Users Tracking Weight 8
		Average Weight 72.03
		Minimum Weight 52.59
		Maximum Weight 133.5*/

		SELECT 
			COUNT(DISTINCT Id) AS users_tracking_weight,
			AVG(WeightKg) AS average_weight,
			MIN(WeightKg) AS minimum_weight,
			MAX(WeightKg) AS maximum_weight
		FROM bellabeat.dbo.weight_cleaned

		/*5) Tracking Steps, Distance, Calories
		Average Steps 7637
		Average Distance 5.48
		Average Calories 2303.60*/

		SELECT 
			COUNT(DISTINCT Id) AS users_tracking_activity,
			AVG(TotalSteps) AS average_steps,
			AVG(TotalDistance) AS average_distance,
			AVG(Calories) AS average_calories
		FROM bellabeat.dbo.daily_activity_cleaned

		/*6) Calculate the number of days each user tracked physical activity
		To find minimum value and maximum value add DISTICT on the end
		Max days recording physical activity -31
		Min days recording physical activity -4*/

		SELECT DISTINCT Id,
			COUNT(ActivityDate) OVER (PARTITION By Id) AS days_activity_recorded
		FROM bellabeat.dbo.daily_activity_cleaned
			ORDER BY days_activity_recorded

		/*7) Calcualate the average minutes of activity
		Average very active minutes 21
		Average fairly active minutes 13
		Average lightly active minutes 192
		Average sedentary minutes 991 */

		SELECT 
			AVG(VeryActiveMinutes) AS AverageVeryActiveMinutes,
			AVG(FairlyActiveMinutes) AS AverageFairlyActiveMinutes,
			AVG(LightlyActiveMinutes) AS AverageLightlyActiveMinutes,
			AVG(SedentaryMinutes) AS AverageSedentaryMinutes
		FROM bellabeat.dbo.daily_activity_cleaned

		/*9) Change minutes to hours
		Average very active hours 0.35
		Average fairly active hours 0.22
		Average lightly active hours 3.20
		Average sedentary hours 16.52 */

		SELECT 
			ROUND(AVG(VeryActiveMinutes)/60.0,2) AS AverageVeryActiveHours,
			ROUND(AVG(FairlyActiveMinutes)/60.0,2) AS AverageFairlyActiveHours,
			ROUND(AVG(LightlyActiveMinutes)/60.0,2) AS AverageLightlyActiveHours,
			ROUND(AVG(SedentaryMinutes)/60.0,2) AS AverageSedentaryHours
		FROM bellabeat.dbo.daily_activity_cleaned

		/*10) High intensity or high METs implies more people are physically active during that time

		Change the TotalIntensity into an integer from nvarchar50*/

		ALTER TABLE bellabeat.dbo.hourly_activity ALTER COLUMN TotalIntensity int
