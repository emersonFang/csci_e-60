<!-- Specify the table name --->
<cfset Table="tbresearcher">

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
<cfquery name="chgresearcher"
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
update tbresearcher set
researcher_lastname = '#trim(form.researcher_lastname)#',
researcher_firstname = '#trim(form.researcher_firstname)#'
where researcherid = #form.researcherid#
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