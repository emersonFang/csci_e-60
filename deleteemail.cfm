<!-- Specify the table name --->
<cfparam name="myaction" default="">
<cfparam name="Form.subjectid" default="XXXXXX" type="string">
<cfparam name="Form.emailno" default="123456" type="string">
<cfset Table="tbsubject_email">

<!--- Begin the loop --->
<cfset try=0>
<cfloop condition="try lt 4">
<cfset try=try+1>
<cfset Qstring="">

<cftry>

<!--- Try to delete the row; this small block is table-specific --->
<cfquery name="delEmail" 			
			datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
delete from tbsubject_email
where subjectid = #form.subjectid# and
emailno = #form.emailno#
</cfquery>

<!--- Exit here when OK --->
<cfbreak>

<!--- Retry up to max times --->
<cfcatch type="database">
<cfif try gt 3>
  <cfset Qstring="?Problem=Repeatedly failed to delete from #Table#; please notify the developer.">
  <cfbreak>
</cfif>
</cfcatch>
</cftry>
</cfloop>

<cfif try EQ 1>
<cfinclude template = "../generalfp.css"></cfinclude>
	(Successfully Deleted: <cfoutput>SubjectID: #Form.subjectid#, E-mail No: #Form.emailno#)<br /></cfoutput>
<cfelse>
<cfset myURL="#Asker##Qstring#">
<cflocation url="#myURL#">
</cfif>