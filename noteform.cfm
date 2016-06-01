<cfinclude template = "../headerfp.cfm">

<!--- Respond to picknote.cfm --->
<cfparam name="form.editme" default="">
<cfparam name="form.delme" default="">
<cfparam name="form.addme" default="do this">
<cfset Asker="noteform.cfm">
<cfparam name="url.Problem" default="">
<cfoutput>#Problem#</cfoutput><br>
<cfif len(form.editme)>
  <cfset myaction="updatenote.cfm">
  <cfquery name="getnote"        
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbparticipant_note
  where experimentid = <cfoutput>#form.experimentid#</cfoutput> and
  versionid = <cfoutput>#form.versionid#</cfoutput> and
  subjectid = <cfoutput>#form.subjectid#</cfoutput> and
  noteno = <cfoutput>#form.noteno#</cfoutput>
  </cfquery>
  EDIT <cfoutput>#form.editme#</cfoutput><br>
<cfelse>
  <cfquery name="getnote"           
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbparticipant_note
  where 1=0
  </cfquery>
  ADD<br>
  <cfif len(form.delme)>
    <cfinclude template="deletenote.cfm">
    <cfset form.delme="">
  <cfelseif len(form.addme)>
    <cfset myaction="insertnote.cfm">
  </cfif>
</cfif>



<cfquery name="getNoteType"           
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbnotetype
  </cfquery>

<cfquery name="getResearcher"           
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
  select * from tbresearcher
  </cfquery>


<!--- Accept data for insert or update --->
<cfform name="myForm"
action="#myaction#" method="post">
Note: <input type="text" name="note"
value=<cfoutput>"#getnote.note#"</cfoutput>
size="100" maxlength="100"><br>
Note Type (SER, MAL, or GEN): <input type="text" name="note"
value=<cfoutput>"#getnote.notetype#"</cfoutput>
size="100" maxlength="100"><br>
Note Date: <input type="text" name="notedate" value=<cfoutput>#getnote.notedate#</cfoutput>>
size="100" maxlength="100"><br>
Note Time: <input type="text" name="notetime" value=<cfoutput>#getnote.notetime#</cfoutput>
size="100" maxlength="100"><br>
Researcher ID: <input type="text" name="note"
value=<cfoutput>"#getnote.researcherid#"</cfoutput>
size="100" maxlength="100"><br>
<input type="button" name="dothis" value="Exit"
onClick="document.location='yoursite.cfm'; return false;">
<input type="reset" name="dummy" value="Reset">
<input type="submit" name="dothis" value="Submit">
<input type="hidden" name="experimentid" value=<cfoutput>"#getnote.experimentid#"</cfoutput>>
<input type="hidden" name="versionid" value=<cfoutput>"#getnote.versionid#"</cfoutput>>
<input type="hidden" name="subjectid" value=<cfoutput>"#getnote.subjectid#"</cfoutput>>
<input type="hidden" name="noteno" value=<cfoutput>"#getnote.noteno#"</cfoutput>>
<input type="hidden" name="notedate" value=<cfoutput>"#getnote.notedate#"</cfoutput>>
<input type="hidden" name="notetime" value=<cfoutput>"#getnote.notetime#"</cfoutput>>
<input type="hidden" name="Asker" value=<cfoutput>"#Asker#"</cfoutput>>
</cfform>

<!--- Pick for update or delete --->
<hr>
<cfinclude template="shownotes.cfm">

<cfinclude template = "../footerfp.cfm">