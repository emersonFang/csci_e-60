<!-- Specify the table name --->
<cfset Table="tbresearcher">

<!--- Begin the loop --->
<cfset try=0>
<cfloop condition="try lt 4">
<cfset try=try+1>
<cfset Qstring="">

<cftry>

<!--- Try to delete the row; this small block is table-specific --->
<cfquery name="delResearcher" 
          datasource="#Request.DSN#"
          username="#Request.username#"
          password="#Request.password#">
delete from tbresearcher
where researcherid = #form.delme#
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

<cfset myURL="#Asker##Qstring#">
<cflocation url="#myURL#">