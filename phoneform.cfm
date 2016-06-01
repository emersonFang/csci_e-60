<head>
    <title>Change Data:</title>
    <cfinclude template = "../generalfp.css">
  </head>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">


<cfparam name="Form.subjectid" default="AAA" type="string">
<cfparam name="Form.lineno" default="" type="string">

    <cfinclude template = "../headerfp.cfm">

<!--- Respond to showsubjectphoner.cfm --->
<cfparam name="Form.editme" default="">
<cfparam name="Form.delme" default="">
<cfparam name="Form.addme" default="do this">
<cfset Asker="phoneform.cfm">
<cfparam name="URL.Problem" default="">
<cfoutput>#Problem#</cfoutput><br>
<cfif len(Form.editme)>
  <cfset myaction="updatephone.cfm">
  <cfquery name="getsubjectphone"                  
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
  select * from tbsubject_phone
  where subjectid = <cfoutput>#Form.subjectid#</cfoutput> and
  lineno = <cfoutput>#Form.lineno#</cfoutput>
  </cfquery>
  (EDIT): <cfoutput>#Form.editme#</cfoutput><br>
<cfelse>
<cfquery name="getsubjectphone"
            datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
  select * from tbsubject_phone
where 1 = 0
</cfquery>
<cfset dummy=QueryAddRow(getsubjectphone)>
  ADD<br>
  <cfif len(Form.delme)>
    <cfinclude template="deletephone.cfm">
    <cfset myaction= "deletephone.cfm">
  <cfelseif len(Form.addme)>
    <cfset myaction="insertphone.cfm">
  </cfif>
</cfif>

<!--- Accept data for insert or update --->
<form name="myForm"
action=<cfoutput>"#myaction#"</cfoutput> method="post">
Phone Number: <cfoutput>#Form.lineno#</cfoutput>: <input type="text" name="phoneno"
value=<cfoutput>"#getsubjectphone.phoneno#"</cfoutput>
size="100" maxlength="100"><br>
Phone Type: <input type="text" name="phonetype"
value=<cfoutput>"#getsubjectphone.phonetype#"</cfoutput>
size="100" maxlength="100"><br>
<input type="button" name="dothis" value="Exit"
onClick="document.location='homefp.cfm'; return false;">
<input type="reset" name="dummy" value="Reset">
<input type="submit" name="dothis" value="Submit">
<input type="hidden" name="subjectid" value=<cfoutput>"#Form.subjectid#"</cfoutput>>
<input type="hidden" name="lineno" value=<cfoutput>"#Form.lineno#"</cfoutput>>
<input type="hidden" name="Asker" value=<cfoutput>"#Asker#"</cfoutput>>
</form>

</body>
</html>

<!--- Pick for update or delete --->
<hr>
<cfinclude template="showsubjectphoner.cfm">

<cfinclude template = "../footerfp.cfm">