<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Subject E-mail</title>
    <cfinclude template = "../generalfp.css">
  </head>

<body>

<cfquery name="getSubjects"                  
				datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
select * from tbsubject
order by subjectid
</cfquery>
<cfform name="pick" action="subjectform.cfm" method="post">
<table>
<tr><th>Subject ID</th><th>Last Name</th><th>First Name</th><th>Update</th><th>Delete</th></tr>
<cfoutput query="getSubjects">
<tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
<td>#subjectid#</td><td>#subject_lastname#</td><td>#subject_firstname#</td>
<td><input type="submit" name="editme" value="#subjectid#"></td><td><input type="submit" name="delme" value="#subjectid#"></td></tr>
</cfoutput>
</table>
</cfform>

</body>
</html>