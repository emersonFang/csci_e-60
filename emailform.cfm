<head>
    <title>Change Data:</title>
    <cfinclude template = "../generalfp.css">
  </head>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">


<cfparam name="Form.subjectid" default="AAA" type="string">
<cfparam name="Form.emailno" default="" type="string">

    <cfinclude template = "../headerfp.cfm">

<!--- Respond to showsubjectemailr.cfm --->
<cfparam name="Form.editme" default="">
<cfparam name="Form.delme" default="">
<cfparam name="Form.addme" default="do this">
<cfset Asker="emailform.cfm">
<cfparam name="URL.Problem" default="">
<cfoutput>#Problem#</cfoutput><br>
<cfif len(Form.editme)>
  <cfset myaction="updateemail.cfm">
  <cfquery name="getsubjectemail"                  
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
  select * from tbsubject_email
  where subjectid = <cfoutput>#Form.subjectid#</cfoutput> and
  emailno = <cfoutput>#Form.emailno#</cfoutput>
  </cfquery>
  (EDIT): <cfoutput>#Form.editme#</cfoutput><br>
<cfelse>
<cfquery name="getsubjectemail"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
  select * from tbsubject_email
where 1 = 0
</cfquery>
<cfset dummy=QueryAddRow(getsubjectemail)>
  ADD<br>
  <cfif len(Form.delme)>
    <cfinclude template="deleteemail.cfm">
    <cfset myaction= "deleteemail.cfm">
  <cfelseif len(Form.addme)>
    <cfset myaction="insertemail.cfm">
  </cfif>
</cfif>

<!--- Accept data for insert or update --->
<form name="myForm"
action=<cfoutput>"#myaction#"</cfoutput> method="post">
E-mail <cfoutput>#Form.emailno#</cfoutput>: <input type="text" name="subjectemail"
value=<cfoutput>"#getsubjectemail.subjectemail#"</cfoutput>
size="100" maxlength="100"><br>
<input type="button" name="dothis" value="Exit"
onClick="document.location='homefp.cfm'; return false;">
<input type="reset" name="dummy" value="Reset">
<input type="submit" name="dothis" value="Submit">
<input type="hidden" name="subjectid" value=<cfoutput>"#Form.subjectid#"</cfoutput>>
<input type="hidden" name="emailno" value=<cfoutput>"#Form.emailno#"</cfoutput>>
<input type="hidden" name="Asker" value=<cfoutput>"#Asker#"</cfoutput>>
</form>

</body>
</html>

<!--- Pick for update or delete --->
<hr>
<cfinclude template="showsubjectemailr.cfm">

<cfinclude template = "../footerfp.cfm">