<!-- Specify the key name and table name --->
<cfset Key="subjectID">
<cfset Table="tbsubject">

<!--- Begin the loop --->
<cfset try=0>
<cfloop condition="try lt 4">
<cfset try=try+1>
<cfset Qstring="?subjectid=#Form.subjectid#">

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
<cfquery name="addPhone" 
			datasource="#Request.DSN#"
            username="#Request.username#"
            password="#Request.password#">
insert into tbsubject (subjectid, subject_lastname, subject_firstname)
values (<cfoutput>'#ID1#', '#Form.subject_lastname#', '#Form.subject_firstname#'</cfoutput>)
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