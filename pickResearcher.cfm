<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Show Researcher E-mail</title>
    <cfinclude template = "../generalfp.css">
  </head>

<body>

<cfquery name="getresearchers"                  
				datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
select * from tbresearcher
order by researcherid
</cfquery>
<cfform name="pick" action="researcherform.cfm" method="post">
<table>
<tr><th>researcher ID</th><th>Last Name</th><th>First Name</th><th>Update</th><th>Delete</th></tr>
<cfoutput query="getresearchers">
<tr <cfif CurrentRow MOD  2 IS 1>style="background-color: ##D5DBDD"</cfif>>
<td>#researcherid#</td><td>#researcher_lastname#</td><td>#researcher_firstname#</td>
<td><input type="submit" name="editme" value="#researcherid#"></td><td><input type="submit" name="delme" value="#researcherid#"></td></tr>
</cfoutput>
</table>
</cfform>

</body>
</html>