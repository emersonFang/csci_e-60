<cfinclude template = "../headerfp.cfm">

<!--- Respond to pickSubject.cfm --->
<cfparam name="form.editme" default="">
<cfparam name="form.delme" default="">
<cfparam name="form.addme" default="do this">
<cfset Asker="subjectform.cfm">
<cfparam name="url.Problem" default="">
<cfoutput>#Problem#</cfoutput><br>
<cfif len(form.editme)>
  <cfset myaction="updatesubject.cfm">
  <cfquery name="getSubject"        
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbsubject
  where subjectid = <cfoutput>#form.editme#</cfoutput>
  </cfquery>
  EDIT <cfoutput>#form.editme#</cfoutput><br>
<cfelse>
  <cfquery name="getSubject"           
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbsubject
  where 1=0
  <!--- An empty copy of Item --->
  </cfquery>
  ADD<br>
  <cfif len(form.delme)>
    <cfinclude template="deletesubject.cfm">
    <cfset form.delme="">
  <cfelseif len(form.addme)>
    <cfset myaction="insertsubject.cfm">
  </cfif>
</cfif>

<!--- Accept data for insert or update --->
<form name="myForm"
action=<cfoutput>"#myaction#"</cfoutput> method="post">
Subject Last Name: <input type="text" name="subject_lastname"
value=<cfoutput>"#getSubject.subject_lastname#"</cfoutput>
size="100" maxlength="100"><br>
Subject First Name: <input type="text" name="subject_firstname"
value=<cfoutput>"#getSubject.subject_firstname#"</cfoutput>
size="100" maxlength="100"><br>
<input type="button" name="dothis" value="Exit"
onClick="document.location='yoursite.cfm'; return false;">
<input type="reset" name="dummy" value="Reset">
<input type="submit" name="dothis" value="Submit">
<input type="hidden" name="subjectid"
value=<cfoutput>"#getSubject.subjectid#"</cfoutput>>
<input type="hidden" name="Asker" value=<cfoutput>"#Asker#"</cfoutput>>
</form>

<!--- Pick for update or delete --->
<hr>
<cfinclude template="pickSubject.cfm">

<cfinclude template = "../footerfp.cfm">