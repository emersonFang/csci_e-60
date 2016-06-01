<!-- Specify the table name --->
<cfparam name="Form.subjectid" default="XXXXXX" type="string">
<cfparam name="Form.emailno" default="123456" type="string">
<cfset Table="tbsubject_email">

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
<cfquery name="chgEmail" 
			datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
update tbsubject_email set
<!--- (leave ItemID unchanged) --->
subjectemail = '#trim(form.subjectemail)#'
where subjectid = #form.subjectid# and
emailno = #form.emailno#
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

<cfif try EQ 1>
<cfinclude template = "../generalfp.css"></cfinclude>
	<h4>Update Successful!</h4>
	<h4>Update:</h4> <cfoutput>SubjectID: #Form.subjectid#, E-mail No: #Form.emailno#, E-mail: #Form.subjectemail#<br /></cfoutput>
	<p>
	</p>
	<cfform name="return" action="emailform.cfm" method="post">
	<input type="hidden" name="subjectid" value=<cfoutput>"#Form.subjectid#"</cfoutput>/>
	<input type="submit" name="confirm" value="OK" />
	</cfform>
<cfelse>
<cfset myURL="#Asker##Qstring#">
<cflocation url="#myURL#">
</cfif>