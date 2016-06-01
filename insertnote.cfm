<!-- Specify the key name and table name --->
<cfset Key="noteID">
<cfset Table="tbparticipant_note">

<!--- Begin the loop --->
<cfset try=0>
<cfloop condition="try lt 4">
<cfset try=try+1>
<cfset Qstring="?experimentid=#Form.experimentid#&versionid=#Form.versionid#&subjectid=#Form.subjectid#">

<cftry>
<cftransaction>
<cfset Qerr=0>
<!--- (no error yet) --->

<!--- Get next ID for single-element key --->
<cfquery name="getMax1" 
			datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
select max(#Key#) as Max1
from #Table#
</cfquery>

<cfif len(getMax1.Max1)>
  <cfset ID1=getMax1.Max1+1>
<cfelse>
  <cfset ID1=1>
</cfif>

<!--- Try to add the row --->
<cfquery name="addNote" 
			datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
insert into tbparticipant_note (experimentid, versionid, subjectid, noteno, note, notetype, notedate, notetime, researcherid)
values (<cfoutput>'#Form.experimentid#', '#Form.versionid#', '#Form.subjectid#', '#ID1#', '#Form.note#', '#Form.note_type#', '#Form.notedate#', '#Form.notetime#', '#Form.researcherid#'</cfoutput>)
</cfquery>

</cftransaction>

<!--- Exit here when OK --->
<cfbreak>

<!--- Retry up to max times --->
<cfcatch type="database">
<cfif try gt 3>
  <cfset Qstring="?Problem=Repeatedly failed to insert into #Table#; please notify the developer.">
  <cfbreak>
</cfif>
</cfcatch>
</cftry>
</cfloop>

<cfset myURL="#Asker##Qstring#">
<cflocation url="#myURL#">