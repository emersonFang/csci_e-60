<cfinclude template = "../headerfp.cfm">

<!--- Respond to pickResearcher.cfm --->
<cfparam name="form.editme" default="">
<cfparam name="form.delme" default="">
<cfparam name="form.addme" default="do this">
<cfset Asker="researcherform.cfm">
<cfparam name="url.Problem" default="">
<cfoutput>#Problem#</cfoutput><br>
<cfif len(form.editme)>
  <cfset myaction="updateresearcher.cfm">
  <cfquery name="getResearcher"        
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbresearcher
  where researcherid = <cfoutput>#form.editme#</cfoutput>
  </cfquery>
  EDIT <cfoutput>#form.editme#</cfoutput><br>
<cfelse>
  <cfquery name="getResearcher"           
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbresearcher
  where 1=0
  <!--- An empty copy of Researcher --->
  </cfquery>
  ADD<br>
  <cfif len(form.delme)>
    <cfinclude template="deleteresearcher.cfm">
    <cfset form.delme="">
  <cfelseif len(form.addme)>
    <cfset myaction="insertresearcher.cfm">
  </cfif>
</cfif>

<!--- Accept data for insert or update --->
<form name="myForm"
action=<cfoutput>"#myaction#"</cfoutput> method="post">
Researcher Last Name: <input type="text" name="researcher_lastname"
value=<cfoutput>"#getResearcher.researcher_lastname#"</cfoutput>
size="100" maxlength="100"><br>
Researcher First Name: <input type="text" name="researcher_firstname"
value=<cfoutput>"#getResearcher.researcher_firstname#"</cfoutput>
size="100" maxlength="100"><br>
<input type="button" name="dothis" value="Exit"
onClick="document.location='yoursite.cfm'; return false;">
<input type="reset" name="dummy" value="Reset">
<input type="submit" name="dothis" value="Submit">
<input type="hidden" name="researcherid"
value=<cfoutput>"#getResearcher.researcherid#"</cfoutput>>
<input type="hidden" name="Asker" value=<cfoutput>"#Asker#"</cfoutput>>
</form>

<!--- Pick for update or delete --->
<hr>
<cfinclude template="pickResearcher.cfm">

<cfinclude template = "../footerfp.cfm">