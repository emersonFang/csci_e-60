<!-- Specify the key name and table name --->
<cfparam name="Form.subjectid" default="XXXXXX" type="string">
<cfparam name="Form.phoneno" default="123456" type="string">
<cfparam name="Form.phonetype" default="blah" type="string">
<cfset Key="lineno">
<cfset Table="tbsubject_phone">

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
where #Table#.subjectid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR"
      value="#Form.subjectid#">
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
insert into tbsubject_phone (subjectid, lineno, phoneno, phonetype)
values (<cfoutput>'#Form.subjectid#', '#ID1#', '#Form.phoneno#', '#Form.phonetype#'</cfoutput>)
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

<cfif try EQ 1>
<cfinclude template = "../generalfp.css"></cfinclude>
	<h4>Update Successful!</h4>
	<h4>Added:</h4> <cfoutput>SubjectID: #Form.subjectid#, Line No: #ID1#, Phone No.: #Form.phoneno#, Phone Type: #Form.phonetype#<br /></cfoutput>
	<p>
	</p>
	<cfform name="return" action="phoneform.cfm" method="post">
	<input type="hidden" name="subjectid" value=<cfoutput>"#Form.subjectid#"</cfoutput>/>
	<input type="submit" name="confirm" value="OK" />
	</cfform>
<cfelse>
<cfset myURL="#Asker##Qstring#">
<cflocation url="#myURL#">
</cfif>