<!-- Specify the table name --->
<cfset Table="tbparticipant_note">

<!--- Begin the loop --->
<cfset try=0>
<cfloop condition="try lt 4">
<cfset try=try+1>
<cfset Qstring="">

<cftry>
<cftransaction>
<cfset Qerr=0>
<!--- (no error yet) --->

<!--- Try to change the row; this small block is table-specific --->
<cfquery name="chgnote"
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
update tbparticipant_note set
note = '#trim(form.note)#', notetype = '#trim(form.notetype)#', notedate = '#trim(form.notedate)#',
notetime = '#trim(form.notetime)#', researcherid = '#trim(form.researcherid)#'
where experimentid = #form.experimentid# and
versionid = #form.versionid# and
subjectid = #form.subjectid# and
noteno = #form.noteno#
</cfquery>

</cftransaction>
<!--- Exit here when OK --->
<cfbreak>

<!--- Retry up to max times --->
<cfcatch type="database">
<cfif try gt 3>
  <cfset Qstring="?Problem=Repeatedly failed to change #Table#; please notify the developer.">
  <cfbreak>
</cfif>
</cfcatch>
</cftry>
</cfloop>

<cfset myURL="#Asker##Qstring#">
<cflocation url="#myURL#">